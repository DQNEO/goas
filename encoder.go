// Encode assembly statements into machine code
package main

import (
	"fmt"
	"strconv"
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
//  See Section 2.1.5 for the encodings of the ModR/M and SIB bytes.

func composeModRM(mod modField, regOp byte, rm byte) byte {
	return uint8(mod)<<6 + regOp<<3 + rm
}

type modField uint8

const ModIndirectionWithNoDisplacement modField = 0b00
const ModIndirectionWithDisplacement8 modField = 0b01
const ModIndirectionWithDisplacement32 modField = 0b10
const ModRegi modField = 0b11

const RM_RIP_RELATIVE = 0b101

// 3.1.1.1 Opcode Column in the Instruction Summary Table (Instructions without VEX Prefix)
// /digit — A digit between 0 and 7 indicates that the ModR/M byte of the instruction uses only the r/m (register
// or memory) operand. The reg field contains the digit that provides an extension to the instruction's opcode.

// shlash_n represents /n value which may be passed an a regOpcode.
const slash_0 = 0 // /0
const slash_1 = 1 // /1
const slash_2 = 2 // /2
const slash_3 = 3 // /3
const slash_4 = 4 // /4
const slash_5 = 5 // /5
const slash_6 = 6 // /6
const slash_7 = 7 // /7

// The registers are encoded using the 4-bit values in the X.Reg column of the following table.
// X.Reg is in binary.
func regBits(reg string) uint8 {
	var x_reg uint8
	switch reg {
	case "ax", "al":
		x_reg = 0b0000
	case "cx", "cl":
		x_reg = 0b0001
	case "dx", "dl":
		x_reg = 0b0010
	case "bx", "bl":
		x_reg = 0b0011
	case "sp", "ah":
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
//  Certain encodings of the ModR/M byte require a second addressing byte (the SIB byte). The base-plus-index and
//  scale-plus-index forms of 32-bit addressing require the SIB byte.
//  The SIB byte includes the following fields:
//  • The scale field specifies the scale factor.
//  • The index field specifies the register number of the index register.
//  • The base field specifies the register number of the base register.

const SibIndexNone uint8 = 0b100
const SibBaseRSP uint8 = 0b100

//     7                           0
//  +---+---+---+---+---+---+---+---+
//  | scale |   index   |    base   |
//  +---+---+---+---+---+---+---+---+
func composeSIB(scale byte, index byte, base byte) byte {
	return scale<<6 + index<<3 + base
}

var variableInstrs []*Instruction

// 3.1.1.3 Instruction Column in the Opcode Summary Table
// The “Instruction” column gives the syntax of the instruction statement as it would appear in an ASM386 program.
// The following is a list of the symbols used to represent operands in the instruction statements:
//
// • rel8 — A relative address in the range from 128 bytes before the end of the instruction to 127 bytes after the
// end of the instruction.
// • rel16, rel32 — A relative address within the same code segment as the instruction assembled. The rel16
// symbol applies to instructions with an operand-size attribute of 16 bits; the rel32 symbol applies to instructions
// with an operand-size attribute of 32 bits.
//
type variableCode struct {
	trgtSymbol  string
	rel8Code    []byte
	rel8Offset  uintptr
	rel32Code   []byte
	rel32Offset uintptr
}

type Instruction struct {
	addr         uintptr
	s            *Stmt
	code         []byte // static code
	next         *Instruction
	index        int
	varcode      *variableCode
	isLenDecided bool
}

var callTargets []*callTarget

type callTarget struct {
	trgtSymbol string
	caller     *Instruction
	offset     uintptr
	width      int // 1 or 4 or 8
}

func registerCallTarget(caller *Instruction, trgtSymbol string, offset uintptr, width int) {
	callTargets = append(callTargets, &callTarget{
		trgtSymbol: trgtSymbol,
		caller:     caller,
		offset:     offset,
		width:      width,
	})
}

func calcDistance(userInstr *Instruction, symdef *symbolDefinition) (int, int, int, bool) {
	var dbg bool
	if symdef.name == ".L.for.cond.355" {
		dbg = true
	}
	var from, to *Instruction
	var forward bool
	if userInstr.index > symdef.instr.index {
		// backward reference
		from, to = symdef.instr, userInstr.next
	} else {
		// forward reference
		from, to = userInstr.next, symdef.instr
		forward = true
	}
	if dbg {
	}

	var hasVariableLength bool
	var diff, min, max int
	for instr := from; instr != to; instr = instr.next {
		if !instr.isLenDecided {
			hasVariableLength = true
			lenShort, lenLarge := len(instr.varcode.rel8Code), len(instr.varcode.rel32Code)
			min += lenShort
			max += lenLarge
			diff += lenLarge
		} else {
			length := len(instr.code)
			diff += length
			min += length
			max += length
		}
	}

	if !forward {
		diff, min, max = -diff, -min, -max
	}

	return diff, min, max, !hasVariableLength
}

func encode(s *Stmt) *Instruction {
	defer func() {
		if x := recover(); x != nil {
			panic(fmt.Sprintf("%s\n[encoder] %s at %s:%d\n\necho '%s' |./encode as",
				x,
				s.source, *s.filePath, s.lineno, s.source))
		}
	}()

	var code []byte
	var instr = &Instruction{
		s: s,
	}

	if s.keySymbol == "" {
		//fmt.Printf(" (label)\n")
		instr.isLenDecided = true
		return instr
	}

	var srcOp, trgtOp Operand
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
		code = []byte{0x90}
	case "jmp": // JMP rel8 or rel32s
		trgtSymbol := trgtOp.(*symbolExpr).name
		varcode := &variableCode{
			trgtSymbol: trgtSymbol,
			// JMP rel8: EB cb
			rel8Code:   []byte{0xeb, 0},
			rel8Offset: 1,
			// JMP rel32: E9 cd
			rel32Code:   []byte{0xe9, 0, 0, 0, 0},
			rel32Offset: 1,
		}
		instr.varcode = varcode
		code = varcode.rel32Code // Conservative allocation
		variableInstrs = append(variableInstrs, instr)
	case "je": // JE rel8 or rel32
		trgtSymbol := trgtOp.(*symbolExpr).name
		varcode := &variableCode{
			trgtSymbol: trgtSymbol,
			// JE rel8: 74 cb
			rel8Code:   []byte{0x74, 0},
			rel8Offset: 1,
			// JE rel32: 0F 84 cd
			rel32Code:   []byte{0x0f, 0x84, 0, 0, 0, 0},
			rel32Offset: 2,
		}
		instr.varcode = varcode
		code = varcode.rel32Code // Conservative allocation
		variableInstrs = append(variableInstrs, instr)
	case "jne":
		trgtSymbol := trgtOp.(*symbolExpr).name
		varcode := &variableCode{
			trgtSymbol: trgtSymbol,
			// JNE rel8: 75 cb
			rel8Code:   []byte{0x75, 0},
			rel8Offset: 1,
			// JE rel32: 0F 85 cd
			rel32Code:   []byte{0x0f, 0x85, 0, 0, 0, 0},
			rel32Offset: 2,
		}
		instr.varcode = varcode
		code = varcode.rel32Code // Conservative allocation
		variableInstrs = append(variableInstrs, instr)
	case "callq", "call":
		trgtSymbol := trgtOp.(*symbolExpr).name

		// call rel16
		code = []byte{0xe8}
		ru := &relaTextUser{
			instr:  instr,
			offset: uintptr(len(code)),
			uses:   trgtSymbol,
			toJump: true,
		}
		relaTextUsers = append(relaTextUsers, ru)
		code = append(code, 0, 0, 0, 0)

		registerCallTarget(instr, trgtSymbol, 1, 4)

	case "leaq":
		switch src := srcOp.(type) {
		case *indirection: // leaq foo(%regi), %regi
			regi := src.regi
			trgtRegi := trgtOp.(*register)
			var opcode uint8 = 0x8d
			if regi.name == "rip" {
				// RIP relative addressing
				mod := ModIndirectionWithNoDisplacement
				modRM := composeModRM(mod, trgtRegi.toBits(), RM_RIP_RELATIVE)
				code = []byte{REX_W, opcode, modRM}

				symbol := src.expr.(*symbolExpr).name
				ru := &relaTextUser{
					instr:  instr,
					offset: uintptr(len(code)),
					uses:   symbol,
				}

				code = append(code, 0, 0, 0, 0)
				relaTextUsers = append(relaTextUsers, ru)
			} else {
				num := src.expr.(*numberLit).val
				displacement, err := strconv.ParseInt(num, 0, 32)
				if err != nil {
					panic(err)
				}

				var modRM, rm, reg byte
				var displacementBytes []byte
				if displacement == 0 {
					mod := ModIndirectionWithNoDisplacement
					rm = regi.toBits()
					reg = trgtRegi.toBits()
					modRM = composeModRM(mod, reg, rm)
				} else if -128 <= displacement && displacement < 128 {
					mod := ModIndirectionWithDisplacement8
					rm = regi.toBits()
					reg = trgtRegi.toBits()
					modRM = composeModRM(mod, reg, rm)
					displacementBytes = []byte{uint8(displacement)}
				} else {
					mod := ModIndirectionWithDisplacement32
					rm = regi.toBits()
					reg = trgtRegi.toBits()
					modRM = composeModRM(mod, reg, rm)
					var disp32 int32 = int32(displacement)
					displacementBytes = (*[4]byte)(unsafe.Pointer(&disp32))[:]
				}
				if rm == regBits("sp") {
					// use SIB
					sib := composeSIB(0b00, SibIndexNone, SibBaseRSP)
					code = []byte{REX_W, opcode, modRM, sib}
				} else {
					code = []byte{REX_W, opcode, modRM}
				}

				code = append(code, displacementBytes...)
			}
		default:
			panic(fmt.Sprintf("TBI: %T (%s)", srcOp, s.source))
		}
	case "movb":
		switch src := srcOp.(type) {
		case *register:
			var opcode uint8 = 0x88
			switch trgt := trgtOp.(type) {
			case *indirection:
				// movb %al,0(%rsi)
				assert(evalNumExpr(trgt.expr) == 0, "expect offset 0")
				mod := ModIndirectionWithNoDisplacement
				reg := src.toBits()
				rm := trgt.regi.toBits()
				modRM := composeModRM(mod, reg, rm)
				code = []byte{opcode, modRM}
			default:
				panic("TBI")
			}
		default:
			panic("TBI")
		}
	case "movw":
		switch src := srcOp.(type) {
		case *register:
			const PREFIX uint8 = 0x66
			var opcode uint8 = 0x89
			switch trgt := trgtOp.(type) {
			case *indirection:
				// movw %ax,0(%rsi)
				assert(evalNumExpr(trgt.expr) == 0, "expect offset 0")
				mod := ModIndirectionWithNoDisplacement
				reg := src.toBits()
				rm := trgt.regi.toBits()
				modRM := composeModRM(mod, reg, rm)
				code = []byte{PREFIX, opcode, modRM}
			default:
				panic("TBI")
			}
		default:
			panic("TBI")
		}
	//case "movl":
	//	op1, op2 := s.operands[0], s.operands[1]
	//	assert(op1.typ == "$number", "op1 type should be $number")
	//	//op1Regi, IsOp1Regi := op1.(*register)
	//	op2Regi := op2.(*register)
	//
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
			var modRM uint8 = composeModRM(ModRegi, 0, trgtOp.(*register).toBits())
			code = []byte{REX_W, opcode, modRM}
			code = append(code, bytesNum[:]...)
		case *register:
			var opcode uint8 = 0x89
			switch trgt := trgtOp.(type) {
			case *register:
				mod := ModRegi
				reg := src.toBits() // src
				op2Regi := trgtOp.(*register)
				rm := op2Regi.toBits() // dst
				modRM := composeModRM(mod, reg, rm)
				code = []byte{REX_W, opcode, modRM}
			case *indirection:
				if trgt.isRipRelative() {
					switch expr := trgt.expr.(type) {
					case *binaryExpr:
						// REX.W 89 /r (MOV r/m64 r64, MR)
						// "movq %rbx, runtime.__argv__+8(%rip)"
						mod := ModIndirectionWithNoDisplacement
						reg := src.toBits() // src
						modRM := composeModRM(mod, reg, RM_RIP_RELATIVE)
						code = []byte{REX_W, opcode, modRM}

						symbol := expr.left.(*symbolExpr).name
						//if _, defined := definedSymbols[symbol]; !defined {
						// @TODO shouud use expr.right.(*numberExpr).val as an offset
						ru := &relaTextUser{
							instr:  instr,
							offset: uintptr(len(code)),
							uses:   symbol,
							adjust: int64(evalNumExpr(expr.right)),
						}
						relaTextUsers = append(relaTextUsers, ru)
						//}
						code = append(code, 0, 0, 0, 0)

					default:
						panic("TBI:" + string(s.source))
					}
				} else {
					// movq %rax, 32(%rsp)
					reg := src.toBits() // src
					rm := trgt.regi.toBits()
					num := trgt.expr.(*numberLit).val
					displacement, err := strconv.ParseInt(num, 0, 8)
					if err != nil {
						panic(err)
					}
					if rm == regBits("sp") {
						// insert SIB byte
						mod := ModIndirectionWithDisplacement8
						modRM := composeModRM(mod, reg, rm)
						sib := composeSIB(0b00, SibIndexNone, SibBaseRSP)
						code = []byte{REX_W, opcode, modRM, sib, uint8(displacement)}
					} else {
						if displacement == 0 {
							mod := ModIndirectionWithNoDisplacement
							modRM := composeModRM(mod, reg, rm)
							code = []byte{REX_W, opcode, modRM}
						} else {
							mod := ModIndirectionWithDisplacement8
							modRM := composeModRM(mod, reg, rm)
							code = []byte{REX_W, opcode, modRM, uint8(displacement)}
						}
					}
				}
			default:
				panic("unexpected op2.typ:")
			}
		case *indirection: // "movq foo(%regi), X", "movq 8(%regi), X"
			srcRegi := src.regi
			trgtRegi := trgtOp.(*register)
			if srcRegi.name == "rip" {
				// RIP relative addressing
				var opcode uint8 = 0x8b
				reg := trgtRegi.toBits()
				mod := ModIndirectionWithNoDisplacement
				modRM := composeModRM(mod, reg, RM_RIP_RELATIVE)
				code = []byte{REX_W, opcode, modRM}

				symbol := src.expr.(*symbolExpr).name
				ru := &relaTextUser{
					instr:  instr,
					offset: uintptr(len(code)),
					uses:   symbol,
				}

				code = append(code, 0, 0, 0, 0)

				relaTextUsers = append(relaTextUsers, ru)
			} else if srcRegi.name == "rsp" {
				var opcode uint8 = 0x8b
				val := evalNumExpr(src.expr)
				if val == 0 {
					var mod = ModIndirectionWithNoDisplacement // indirection
					var rm = regBits("sp")
					reg := trgtRegi.toBits()
					modRM := composeModRM(mod, reg, rm)
					sib := composeSIB(0b00, SibIndexNone, SibBaseRSP)
					code = []byte{REX_W, opcode, modRM, sib}
				} else {
					var mod = ModIndirectionWithDisplacement8
					var rm = regBits("sp")
					reg := trgtRegi.toBits()
					modRM := composeModRM(mod, reg, rm)
					sib := composeSIB(0b00, SibIndexNone, SibBaseRSP)
					if val > 256 {
						panic("TBI")
					}
					code = []byte{REX_W, opcode, modRM, sib, uint8(val)}
				}
			} else {
				var opcode uint8 = 0x8b
				reg := trgtRegi.toBits()
				var ival int
				if src.expr != nil {
					ival = evalNumExpr(src.expr)
				}
				if ival != 0 {
					var mod = ModIndirectionWithDisplacement8
					var rm = srcRegi.toBits()
					modRM := composeModRM(mod, reg, rm)
					if ival > 256 {
						panic("TBI")
					}
					code = []byte{REX_W, opcode, modRM, uint8(ival)}
				} else {
					mod := ModIndirectionWithNoDisplacement
					rm := srcRegi.toBits()
					modRM := composeModRM(mod, reg, rm)
					code = []byte{REX_W, opcode, modRM}
				}
			}
		default:
			panic(fmt.Sprintf("TBI:%v", src))
		}
	case "movzbq":
		// Move byte to quadword, zero-extension.
		switch src := srcOp.(type) {
		case *register:
			mod := ModRegi
			reg := src.toBits()
			rm := trgtOp.(*register).toBits()
			modRM := composeModRM(mod, reg, rm)
			code = []byte{REX_W, 0x0f, 0xb6, modRM}
		case *indirection:
			mod := ModIndirectionWithNoDisplacement
			rm := src.regi.toBits()
			reg := trgtOp.(*register).toBits()
			modRM := composeModRM(mod, reg, rm)
			if rm == regBits("sp") {
				// use SIB
				sib := composeSIB(0b00, SibIndexNone, SibBaseRSP)
				code = []byte{REX_W, 0x0f, 0xb6, modRM, sib}
			} else {
				code = []byte{REX_W, 0x0f, 0xb6, modRM}
			}
		default:
			panic("TBI")
		}
	case "movzwq":
		// Move word to quadword, zero-extension.
		switch src := srcOp.(type) {
		case *indirection:
			mod := ModIndirectionWithNoDisplacement
			reg := src.regi.toBits()
			rm := trgtOp.(*register).toBits()
			modRM := composeModRM(mod, reg, rm)
			code = []byte{REX_W, 0x0f, 0xb7, modRM}
		default:
			panic("TBI")
		}
	case "addl":
		var opcode uint8 = 0x01
		regFieldN := trgtOp.(*register).toBits()
		var modRM uint8 = 0b11000000 + regFieldN
		code = []byte{opcode, modRM}
	case "addq":
		switch src := srcOp.(type) {
		case *register:
			opcode := uint8(0x01)
			regi := srcOp.(*register).toBits()
			rm := trgtOp.(*register).toBits()
			modRM := composeModRM(ModRegi, regi, rm)
			code = []byte{REX_W, opcode, modRM}
		case *immediate: // "addq $32, %regi"
			{
				rm := trgtOp.(*register).toBits()
				modRM := composeModRM(ModRegi, slash_0, rm)
				imValue := evalNumExpr(src.expr)
				switch {
				case imValue < 128:
					code = []byte{REX_W, 0x83, modRM, uint8(imValue)}
				case imValue < 1<<31:
					i32 := int32(imValue)
					hex := (*[4]uint8)(unsafe.Pointer(&i32))
					if trgtOp.(*register).name == "rax" {
						code = []byte{REX_W, 0x05, hex[0], hex[1], hex[2], hex[3]}
					} else {
						code = []byte{REX_W, 0x05, modRM, hex[0], hex[1], hex[2], hex[3]}
					}
				default:
					panic("TBI")
				}
			}
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
			code = []byte{REX_W, opcode, modRM}
		case *immediate:
			rm := trgtOp.(*register).toBits()
			// modRM = 0xec = 1110_1100 = 11_101_100 = 11_5_sp
			modRM := composeModRM(ModRegi, slash_5, rm)
			imValue, err := strconv.ParseInt(src.expr.(*numberLit).val, 0, 32)
			if err != nil {
				panic(err)
			}
			switch {
			case imValue < 1<<7:
				code = []byte{REX_W, 0x83, modRM, uint8(imValue)}
			case imValue < 1<<31:
				i32 := int32(imValue)
				hex := (*[4]uint8)(unsafe.Pointer(&i32))
				code = []byte{REX_W, 0x81, modRM, hex[0], hex[1], hex[2], hex[3]}
			default:
				panic("TBI")
			}
		default:
			panic("TBI")
		}
	case "imulq":
		switch src := srcOp.(type) {
		case *register:
			// IMUL r64, r/m64
			opcodes := []uint8{0x0f, 0xaf}
			rm := srcOp.(*register).toBits()
			regi := trgtOp.(*register).toBits()
			modRM := composeModRM(ModRegi, regi, rm)
			code = []byte{REX_W, opcodes[0], opcodes[1], modRM}
		case *immediate:
			opcode := uint8(0x6b)
			// IMUL r64, r/m64, imm8
			// Quadword register := r/m64 ∗ sign-extended immediate byte.
			reg := trgtOp.(*register).toBits()
			modRM := composeModRM(ModRegi, reg, 0)
			imValue, err := strconv.ParseInt(src.expr.(*numberLit).val, 0, 8)
			if err != nil {
				panic(err)
			}
			code = []byte{REX_W, opcode, modRM, uint8(imValue)} // REX.W, IMULQ, ModR/M, ib

		default:
			panic("TBI")
		}
	case "divq":
		opcode := uint8(0xf7)
		rm := trgtOp.(*register).toBits()
		modRM := composeModRM(ModRegi, slash_6, rm)
		code = []byte{REX_W, opcode, modRM}
	case "cmpq":
		switch srcOp.(type) {
		case *register:
			opcode := uint8(0x39)
			regi := srcOp.(*register).toBits()
			rm := trgtOp.(*register).toBits()
			modRM := composeModRM(ModRegi, regi, rm)
			code = []byte{REX_W, opcode, modRM}
		case *immediate:
			opcode := uint8(0x83)
			imValue, err := strconv.ParseInt(srcOp.(*immediate).expr.(*numberLit).val, 0, 8)
			if err != nil {
				panic(err)
			}
			rm := trgtOp.(*register).toBits()
			modRM := composeModRM(ModRegi, 7, rm)
			code = []byte{REX_W, opcode, modRM, uint8(imValue)}
		default:
			panic("TBI:" + s.source)
		}
	case "setl":
		opcode1 := uint8(0x0f)
		opcode2 := uint8(0x9c)
		reg := trgtOp.(*register).toBits()
		modRM := composeModRM(ModRegi, reg, 0)
		code = []byte{opcode1, opcode2, modRM}
	case "setle":
		opcode1 := uint8(0x0f)
		opcode2 := uint8(0x9e)
		reg := trgtOp.(*register).toBits()
		modRM := composeModRM(ModRegi, reg, 0)
		code = []byte{opcode1, opcode2, modRM}
	case "setg":
		opcode1 := uint8(0x0f)
		opcode2 := uint8(0x9f)
		reg := trgtOp.(*register).toBits()
		modRM := composeModRM(ModRegi, reg, 0)
		code = []byte{opcode1, opcode2, modRM}
	case "setge":
		opcode1 := uint8(0x0f)
		opcode2 := uint8(0x9d)
		reg := trgtOp.(*register).toBits()
		modRM := composeModRM(ModRegi, reg, 0)
		code = []byte{opcode1, opcode2, modRM}
	case "sete":
		opcode1 := uint8(0x0f)
		opcode2 := uint8(0x94)
		reg := trgtOp.(*register).toBits()
		modRM := composeModRM(ModRegi, reg, 0)
		code = []byte{opcode1, opcode2, modRM}
	case "pushq":
		switch trgt := trgtOp.(type) {
		case *register:
			code = []byte{0x50 + trgt.toBits()}
		case *immediate:
			imValue, err := strconv.ParseInt(trgt.expr.(*numberLit).val, 0, 32)
			if err != nil {
				panic(err)
			}
			switch {
			case imValue < 1<<7: //PUSH imm8 : 6a ib
				code = []byte{0x6a, uint8(imValue)}
			//case imValue < 1<<14 : //PUSH imm16: 	68 iw
			//	ui16 := int16(imValue)
			//	hex := (*[2]uint8)(unsafe.Pointer(&ui16))
			//	r = []byte{0x68, hex[0], hex[1]}
			case imValue < 1<<31: // PUSH imm32 68 id
				ui32 := int32(imValue)
				hex := (*[4]uint8)(unsafe.Pointer(&ui32))
				code = []byte{0x68, hex[0], hex[1], hex[2], hex[3]}
			default:
				panic("TBI")
			}
		default:
			panic("[encoder] TBI:" + string(s.source))
		}
	case "popq":
		switch trgt := trgtOp.(type) {
		case *register:
			// 58 +rd. POP r64.
			code = []byte{0x58 + trgt.toBits()}
		default:
			panic("[encoder] TBI:" + string(s.source))
		}
	case "xor":
		// XOR r/m64, imm8
		// REX.W 83 /6 ib
		opcode := uint8(0x83)
		rm := trgtOp.(*register).toBits()
		modRM := composeModRM(ModRegi, slash_6, rm)
		imValue := evalNumExpr(srcOp.(*immediate).expr)
		code = []byte{REX_W, opcode, modRM, uint8(imValue)}
	case "ret", "retq":
		code = []byte{0xc3}
	case "syscall":
		code = []byte{0x0f, 0x05}
	case "leave":
		code = []byte{0xc9}
	case ".text":
		//fmt.Printf(" skip\n")
	case ".global":
		// Ignore. captured in main routine
	default:
		panic(fmt.Sprintf("[encoder] TBI: %s at line %d\n\necho '%s' |./encode as",
			s.source, 0, s.source))
	}

	//fmt.Printf("=>  %#x\n", r)
	instr.code = code
	if instr.varcode == nil {
		instr.isLenDecided = true
	}
	return instr
}

func encodeData(s *Stmt, dataAddr uintptr) []byte {
	defer func() {
		if x := recover(); x != nil {
			panic(fmt.Sprintf("%s\n[encoder] %s at %s:%d\n\necho '%s' |./encode as",
				x,
				s.source, *s.filePath, s.lineno, s.source))
		}
	}()

	if s.labelSymbol != "" {
		definedSymbols[s.labelSymbol].address = dataAddr
	}
	if s.keySymbol == "" {
		return nil
	}

	switch s.keySymbol {
	case ".byte":
		op := s.operands[0]
		switch opDtype := op.(type) {
		case *numberLit:
			rawVal := opDtype.val
			i, err := strconv.ParseInt(rawVal, 0, 8)
			if err != nil {
				panic(err)
			}
			buf := (*[1]byte)(unsafe.Pointer(&i))
			return buf[:]
		case *charLit:
			rawVal := opDtype.val
			return []uint8{rawVal}
		}
	case ".word":
		op := s.operands[0]
		rawVal := op.(*numberLit).val
		i, err := strconv.ParseInt(rawVal, 0, 16)
		if err != nil {
			panic(err)
		}
		buf := (*[2]byte)(unsafe.Pointer(&i))
		return buf[:]
	case ".quad":
		op := s.operands[0]
		switch opDtype := op.(type) {
		case *numberLit:
			rawVal := opDtype.val
			i, err := strconv.ParseInt(rawVal, 0, 64)
			if err != nil {
				panic(err)
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
	case ".string":
		op := s.operands[0]
		val := op.(string)
		bytes := append([]byte(val), 0)
		return bytes
	default:
		panic("TBI:" + s.keySymbol)
	}
	return nil
}
