// Encode assembly statements into machine code
package main

import (
	"fmt"
	"strconv"
	"strings"
	"unsafe"
)

// Intel SDM
// Volume 2 Instruction Set Reference
// CHAPTER 2 INSTRUCTION FORMAT
//

const REX_W byte = 0x48

//  2.1.3 ModR/M and SIB Bytes
//
//    7   6   5   4   3   2   1   0
//  +---+---+---+---+---+---+---+---+
//  |  mod  | reg/opcode|    r/m    |
//  +---+---+---+---+---+---+---+---+
//
//  Many instructions that refer to an operand in memory have an addressing-form specifier byte (called the ModR/M
//  byte) following the primary opcode. The ModR/M byte contains three fields of information:
//  • The mod field combines with the r/m field to form 32 possible values: eight registers and 24 addressing modes.
//  • The reg/opcode field specifies either a register number or three more bits of opcode information. The purpose
//  of the reg/opcode field is specified in the primary opcode.
//  • The r/m field can specify a register as an operand or it can be combined with the mod field to encode an
//  addressing mode. Sometimes, certain combinations of the mod field and the r/m field are used to express
//  opcode information for some instructions.
//
//  Certain encodings of the ModR/M byte require a second addressing byte (the SIB byte). The base-plus-index and
//  scale-plus-index forms of 32-bit addressing require the SIB byte.
//  The SIB byte includes the following fields:
//  • The scale field specifies the scale factor.
//  • The index field specifies the register number of the index register.
//  • The base field specifies the register number of the base register.
//  See Section 2.1.5 for the encodings of the ModR/M and SIB bytes.

type modField uint8
const ModIndirectionWithNoDisplacement modField = 0b00
const ModIndirectionWithDisplacement8 modField = 0b01
const ModIndirectionWithDisplacement32 modField = 0b10
const ModRegi modField = 0b11

const RM_SPECIAL_101 uint8 = 0b101 // none? rip?

func composeModRM(mod modField, regOpcode byte, rm byte) byte {
	return uint8(mod)<<6 + regOpcode<<3 + rm
}

const REG_NONE = 0b101


// The registers are encoded using the 4-bit values in the X.Reg column of the following table.
// X.Reg is in binary.
func regBits(reg string) uint8 {
	var x_reg uint8
	switch reg {
	case "ax","al":
		x_reg = 0b0000
	case "cx","cl":
		x_reg = 0b0001
	case "dx","dl":
		x_reg = 0b0010
	case "bx", "bl":
		x_reg = 0b0011
	case "sp","ah":
		x_reg = 0b0100
	case "bp", "ch":
		x_reg = 0b0101 // or /5
	case "si", "dh":
		x_reg = 0b0110
	case "di", "bh":
		x_reg = 0b0111
	default:
		panic("TBI: unexpected register " + reg)
	}
	return x_reg
}

// SIB
// https://wiki.osdev.org/X86-64_Instruction_Encoding#SIB

const SibIndexNone uint8 = 0b100
const SibBaseRSP uint8 = 0b100

//     7                           0
//  +---+---+---+---+---+---+---+---+
//  | scale |   index   |    base   |
//  +---+---+---+---+---+---+---+---+
func composeSIB(scale byte, index byte, base byte) byte {
	return scale<<6 + index<<3 + base
}

type Instruction struct {
	startAddr uintptr
	raw       *statement
	code      []byte
}

func encode(s *statement, instrAddr uintptr) *Instruction {
	defer func() {
		if x:= recover(); x!=nil {
			panic(fmt.Sprintf("%s\n[encoder] %s at %s:%d\n\necho '%s' |./encode as",
				x,
				s.raw, *s.filename, s.lineno, s.raw))
		}
	}()

	//debugf("stmt=%#v\n", s)
	var r []byte
	var instr = &Instruction{
		startAddr: instrAddr,
		raw:       s,
	}
	if s.labelSymbol != "" {
		definedSymbols[s.labelSymbol].address = instrAddr
	}

	if s.labelSymbol != "" && s.keySymbol == "" {
		//fmt.Printf(" (label)\n")
		return instr
	}

	var srcOp, trgtOp operand
	switch len(s.operands) {
	case 0:
		// No operands. "ret", "leave" etc.
	case 1:
		trgtOp = s.operands[0]
	case 2:
		srcOp, trgtOp = s.operands[0], s.operands[1]
	default:
		panic("too many operands")
	}


	//fmt.Printf("[translator] %s (%d ops) => ", s.keySymbol, len(s.operands))
	switch s.keySymbol {
	case "nop":
		r = []byte{0x90}
	case "jmp":
		// EB cb
		trgtSymbol := trgtOp.(*symbolExpr).name
		r = []byte{0xeb}
		r = append(r, 0)
		unresolvedCodeSymbols[instrAddr+1] = &addrToReplace{
			nextInstrAddr: instrAddr + uintptr(len(r)),
			symbolUsed:    trgtSymbol,
		}
	case "je": // JE rel32
		trgtSymbol := trgtOp.(*symbolExpr).name
		r = []byte{0x0f,0x84}
		r = append(r, 0,0,0,0)
		unresolvedCodeSymbols[instrAddr+1] = &addrToReplace{
			nextInstrAddr: instrAddr + uintptr(len(r)),
			symbolUsed:    trgtSymbol,
		}
	case "jne":
		trgtSymbol := trgtOp.(*symbolExpr).name
		r = []byte{0x0f,0x85}
		r = append(r, 0,0,0,0)
		unresolvedCodeSymbols[instrAddr+1] = &addrToReplace{
			nextInstrAddr: instrAddr + uintptr(len(r)),
			symbolUsed:    trgtSymbol,
		}
	case "callq", "call":
		trgtSymbol := trgtOp.(*symbolExpr).name

		r = []byte{0xe8}
		ru := &relaTextUser{
			addr:   instrAddr + uintptr(len(r)),
			uses:   trgtSymbol,
			toJump: true,
		}
		relaTextUsers = append(relaTextUsers, ru)

		r = append(r, 0, 0, 0, 0)

		unresolvedCodeSymbols[instrAddr+1] = &addrToReplace{
			nextInstrAddr: instrAddr + uintptr(len(r)),
			symbolUsed:    trgtSymbol,
		}
	case "leaq":
		switch src := srcOp.(type) {
		case *indirection: // leaq foo(%regi), %regi
			regi := src.regi
			trgtRegi := trgtOp.(*register)
			var opcode uint8 = 0x8d
			if regi.name == "rip" {
				// RIP relative addressing
				reg := trgtRegi.toBits()
				mod := ModIndirectionWithNoDisplacement
				modRM := composeModRM(mod, reg, 0b101)
				r = []byte{REX_W, opcode, modRM}

				symbol := src.expr.(*symbolExpr).name
				ru := &relaTextUser{
					addr: instrAddr + uintptr(len(r)),
					uses: symbol,
				}

				r = append(r, 0, 0, 0, 0)
				relaTextUsers = append(relaTextUsers, ru)
			} else if regi.name == "rsp" {
				mod := ModIndirectionWithDisplacement8
				rm := regBits("sp")
				reg := trgtRegi.toBits()
				modRM := composeModRM(mod, reg, rm)
				sib := composeSIB(0b00, SibIndexNone, SibBaseRSP)
				num := src.expr.(*numberLit).val
				displacement, err := strconv.ParseInt(num, 0, 8)
				if err != nil {
					panic(err)
				}
				r = []byte{REX_W, opcode, modRM, sib, uint8(displacement)}
			}
		default:
			panic(fmt.Sprintf("TBI: %T (%s)", srcOp, s.raw))
		}
	//case "movl":
	//	op1, op2 := s.operands[0], s.operands[1]
	//	assert(op1.typ == "$number", "op1 type should be $number")
	//	//op1Regi, IsOp1Regi := op1.(*register)
	//	op2Regi := op2.(*register)
	//
	//	//debugf("op1,op2=%s,%s  ", op1, op2)
	//	intNum, err := strconv.ParseInt(op1.string, 0, 32)
	//	if err != nil {
	//		panic(err)
	//	}
	//	var num int32 = int32(intNum)
	//	bytesNum := (*[4]byte)(unsafe.Pointer(&num))
	//	var opcode byte
	//	regFieldN := op2Regi.toBits()
	//	opcode = 0xb8 + regFieldN
	//	tmp := []byte{opcode}
	//	r = append(tmp, (bytesNum[:])...)
	case "movq":
		//		assert(op1.typ == "$number", "op1 type should be $number")
		//assert(op2.typ == "register", "op2 type should be register")
		switch src := srcOp.(type) {
		case *immediate: // movq $123, %regi
			intNum, err := strconv.ParseInt(src.expr.(*numberLit).val, 0, 32)
			if err != nil {
				panic(err)
			}
			var num int32 = int32(intNum)
			bytesNum := (*[4]byte)(unsafe.Pointer(&num))
			var opcode uint8 = 0xc7
			var modRM uint8 = 0b11000000 + trgtOp.(*register).toBits()
			r = []byte{REX_W, opcode, modRM}
			r = append(r, bytesNum[:]...)
		case *register:
			var opcode uint8 = 0x89
			switch trgt := trgtOp.(type) {
			case *register:
				mod := ModRegi
				reg := src.toBits() // src
				op2Regi := trgtOp.(*register)
				rm := op2Regi.toBits() // dst
				modRM := composeModRM(mod, reg, rm)
				r = []byte{REX_W, opcode, modRM}
			case *indirection:
				if trgt.isRipRelative() {
					switch expr := trgt.expr.(type) {
					case *binaryExpr:
						// REX.W 89 /r (MOV r/m64 r64, MR)
						// "movq %rbx, runtime.__argv__+8(%rip)"
						mod := ModIndirectionWithNoDisplacement
						reg := src.toBits()  // src
						rm := RM_SPECIAL_101 // RIP
						modRM := composeModRM(mod, reg, rm)
						r = []byte{REX_W, opcode, modRM}

						symbol := expr.left.(*symbolExpr).name
						if _, defined := definedSymbols[symbol]; !defined {
							// @TODO shouud use expr.right.(*numberExpr).val as an offset
							ru := &relaTextUser{
								addr:   instrAddr + uintptr(len(r)),
								uses:   symbol,
								adjust: int64(evalNumExpr(expr.right)),
							}
							relaTextUsers = append(relaTextUsers, ru)
						}
						r = append(r, 0, 0, 0, 0)

					default:
						panic("TBI:" + string(s.raw))
					}
				} else {
					// movq %rax, 32(%rsp)
					mod := ModIndirectionWithDisplacement8
					reg := src.toBits() // src
					rm := regBits("sp")
					modRM := composeModRM(mod, reg, rm)

					sib := composeSIB(0b00, SibIndexNone, SibBaseRSP)
					num := trgt.expr.(*numberLit).val
					displacement, err := strconv.ParseInt(num, 0, 8)
					if err != nil {
						panic(err)
					}
					r = []byte{REX_W, opcode, modRM, sib, uint8(displacement)}
				}
			default:
				panic("unexpected op2.typ:")
			}
		case *indirection: // "movq foo(%regi), X", "movq (%regi), X"
			srcRegi := src.regi
			trgtRegi := trgtOp.(*register)
			if srcRegi.name == "rip" {
				// RIP relative addressing
				var opcode uint8 = 0x8b
				reg := trgtRegi.toBits()
				mod := ModIndirectionWithNoDisplacement
				modRM := composeModRM(mod, reg, 0b101)
				r = []byte{REX_W, opcode, modRM}

				symbol := src.expr.(*symbolExpr).name
				ru := &relaTextUser{
					addr: instrAddr + uintptr(len(r)),
					uses: symbol,
				}

				r = append(r, 0, 0, 0, 0)

				relaTextUsers = append(relaTextUsers, ru)
			} else if srcRegi.name == "rsp" {
				var opcode uint8 = 0x8b
				if src.expr.(*numberLit).val == "0" {
					var mod = ModIndirectionWithNoDisplacement // indirection
					var rm = regBits("sp")
					reg := trgtRegi.toBits()
					modRM := composeModRM(mod, reg, rm)
					sib := composeSIB(0b00, SibIndexNone, SibBaseRSP)
					r = []byte{REX_W, opcode, modRM, sib}
				} else {
					var mod = ModIndirectionWithDisplacement8
					var rm = regBits("sp")
					reg := trgtRegi.toBits()
					modRM := composeModRM(mod, reg, rm)
					sib := composeSIB(0b00, SibIndexNone, SibBaseRSP)
					offset, err := strconv.ParseInt(src.expr.(*numberLit).val, 0, 8)
					if err != nil {
						panic(err)
					}
					r = []byte{REX_W, opcode, modRM, sib, uint8(offset)}
				}
			} else {
				var opcode uint8 = 0x8b
				reg := trgtRegi.toBits()
				mod := ModIndirectionWithNoDisplacement
				rm := srcRegi.toBits()
				modRM := composeModRM(mod, reg, rm)
				r = []byte{REX_W, opcode, modRM}
			}
		default:
			panic(fmt.Sprintf("TBI:%v", src))
		}
	case "movzbq": // MOVZX r64 r/m8
		// Move byte to quadword, zero-extension.
		// REX.W 0F B6 /r
		mod := ModRegi
		reg := srcOp.(*register).toBits() // src
		rm := trgtOp.(*register).toBits() // dst
		modRM := composeModRM(mod, reg, rm)
		r = []byte{REX_W, 0x0f, 0xb6, modRM}
	case "addl":
		var opcode uint8 = 0x01
		regFieldN := trgtOp.(*register).toBits()
		var modRM uint8 = 0b11000000 + regFieldN
		r = []byte{opcode, modRM}
	case "addq":
		opcode := uint8(0x01)
		switch srcOp.(type) {
		case *register:
			regi := srcOp.(*register).toBits()
			rm := trgtOp.(*register).toBits()
			modRM := composeModRM(ModRegi, regi, rm)
			r = []byte{REX_W, opcode, modRM}
		case *immediate: // "addq $32, %regi"
			opcode := uint8(0x83)
			rm := trgtOp.(*register).toBits()
			modRM := composeModRM(0b11, 0, rm)
			imm := srcOp.(*immediate)
			imValue := evalNumExpr(imm.expr)
			r = []byte{REX_W, opcode, modRM, uint8(imValue)} // REX.W, IMULQ, ModR/M, ib
		default:
			panic("TBI")
		}
	case "subq":
		switch src := srcOp.(type) {
		case *register:
			opcode := uint8(0x29)
			regi := srcOp.(*register).toBits()
			rm := trgtOp.(*register).toBits()
			modRM := composeModRM(ModRegi, regi, rm)
			r = []byte{REX_W, opcode, modRM}
		case *immediate:
			opcode := uint8(0x83)
			rm := trgtOp.(*register).toBits()
			// modRM = 0xec = 1110_1100 = 11_101_100 = 11_5_sp
			const reg5 = 5
			modRM := composeModRM(ModRegi, reg5, rm)
			imValue, err := strconv.ParseInt(src.expr.(*numberLit).val, 0, 8)
			if err != nil {
				panic(err)
			}
			r = []byte{REX_W, opcode, modRM, uint8(imValue)}
		default:
			panic("TBI")
		}
	case "imulq":
		// IMUL r64, r/m64, imm8
		// Quadword register := r/m64 ∗ sign-extended immediate byte.
		opcode := uint8(0x6b)
		reg := trgtOp.(*register).toBits()
		modRM := composeModRM(0b11, reg, 0)
		imm := srcOp.(*immediate)
		imValue, err := strconv.ParseInt(imm.expr.(*numberLit).val, 0, 8)
		if err != nil {
			panic(err)
		}
		r = []byte{REX_W, opcode, modRM, uint8(imValue)} // REX.W, IMULQ, ModR/M, ib
	case "cmpq":
		switch srcOp.(type) {
		case *register:
			opcode := uint8(0x01)
			regi := srcOp.(*register).toBits()
			rm := trgtOp.(*register).toBits()
			modRM := composeModRM(ModRegi, regi, rm)
			r = []byte{REX_W, opcode, modRM}
		case *immediate:
			opcode := uint8(0x83)
			imValue, err := strconv.ParseInt(srcOp.(*immediate).expr.(*numberLit).val, 0, 8)
			if err != nil {
				panic(err)
			}
			rm := trgtOp.(*register).toBits()
			modRM := composeModRM(ModRegi, 7, rm)
			r = []byte{REX_W, opcode, modRM, uint8(imValue)}
		default:
			panic("TBI:" + s.raw)
		}
	case "sete":
		opcode1 := uint8(0x0f)
		opcode2 := uint8(0x94)
		reg := trgtOp.(*register).toBits()
		modRM := composeModRM(ModRegi, reg, 0)
		r = []byte{opcode1, opcode2, modRM}
	case "pushq":
		switch trgt := trgtOp.(type) {
		case *register:
			r = []byte{0x50 + trgt.toBits()}
		case *immediate:
			imValue, err := strconv.ParseInt(trgt.expr.(*numberLit).val, 0, 8)
			if err != nil {
				panic(err)
			}
			r = []byte{0x6a, uint8(imValue)}
		default:
			panic("[encoder] TBI:" + string(s.raw))
		}
	case "popq":
		switch trgt := trgtOp.(type) {
		case *register:
			// 58 +rd. POP r64.
			r = []byte{0x58 + trgt.toBits()}
		default:
			panic("[encoder] TBI:" + string(s.raw))
		}
	case "xor":
		// XOR r/m64, imm8
		// REX.W 83 /6 ib
		opcode := uint8(0x83)
		const reg6 = 6
		rm := trgtOp.(*register).toBits()
		modRM := composeModRM(ModRegi, reg6, rm)
		imValue := evalNumExpr(srcOp.(*immediate).expr)
		r = []byte{REX_W, opcode, modRM, uint8(imValue)}
	case "ret", "retq":
		r = []byte{0xc3}
	case "syscall":
		r = []byte{0x0f, 0x05}
	case "leave":
		r = []byte{0xc9}
	case ".text":
		//fmt.Printf(" skip\n")
	case ".global":
		// Ignore. captured in main routine
	default:
		panic(fmt.Sprintf("[encoder] TBI: %s at line %d\n\necho '%s' |./encode as",
			s.raw, 0, s.raw))
	}

	//fmt.Printf("=>  %#x\n", r)
	instr.code = r
	return instr
}

func encodeData(s *statement, dataAddr uintptr) []byte {
	if s.labelSymbol != "" {
		definedSymbols[s.labelSymbol].address = dataAddr
	}
	switch s.keySymbol {
	case ".quad":
		op := s.operands[0]
		//debugf(".quad type=%T\n", op.ifc)
		switch opDtype := op.(type) {
		case *numberLit:
			rawVal := opDtype.val
			var i int64
			if strings.HasPrefix(rawVal, "0x") {
				var err error
				i, err = strconv.ParseInt(rawVal, 0, 0)
				if err != nil {
					panic(err)
				}
			} else {
				// TBI
			}
			buf := (*[8]byte)(unsafe.Pointer(&i))
			return buf[:]
		case *symbolExpr:
			ru := &relaDataUser{
				addr: dataAddr,
				uses: opDtype.name,
			}
			relaDataUsers = append(relaDataUsers, ru)
			return make([]byte, 8)
		default:
			panic("Unexpected op.typ:")
		}
	case "": // label
		//panic("empty keySymbol:" + s.labelSymbol)
	default:
		panic("TBI:" + s.keySymbol)
	}
	return nil
}
