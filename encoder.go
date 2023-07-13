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

// REX prefix
// https://wiki.osdev.org/X86-64_Instruction_Encoding#REX_prefix
// Encoding
// The layout is as follows:
//
//	7                           0
//
// +---+---+---+---+---+---+---+---+
// | 0   1   0   0 | W | R | X | B |
// +---+---+---+---+---+---+---+---+

// Intel SDM
// 2.2.1.2 More on REX Prefix Fields
//
// W : 1 = 64 Bit Operand Size
// R: Extension of the ModR/M reg field. REX.R modifies the ModR/M reg field when that field encodes a GPR, SSE, control or debug register.
// B: Extension of the ModR/M r/m field, SIB base field, or Opcode reg field.

const REX_B byte = 0x41  // 0b0100001
const REX_W byte = 0x48  // 0b01001000
const REX_WB byte = 0x49 // 0b01001001
const REX_WR byte = 0x4c // 0b01001100

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

// shlash_n represents /n value which may be passed as a regOpcode.
const slash_0 = 0 // /0 0b000
const slash_1 = 1 // /1 0b001
const slash_2 = 2 // /2 0b010
const slash_3 = 3 // /3 0b011
const slash_4 = 4 // /4 0b010
const slash_5 = 5 // /5 0b101
const slash_6 = 6 // /6 0b110
const slash_7 = 7 // /7 0b111

// SIB
//  Certain encodings of the ModR/M byte require a second addressing byte (the SIB byte). The base-plus-index and
//  scale-plus-index forms of 32-bit addressing require the SIB byte.
//  The SIB byte includes the following fields:
//  • The scale field specifies the scale factor.
//  • The index field specifies the register number of the index register.
//  • The base field specifies the register number of the base register.

const SibIndexNone uint8 = 0b100
const SibBaseRSP uint8 = 0b100

//	7                           0
//
// +---+---+---+---+---+---+---+---+
// | scale |   index   |    base   |
// +---+---+---+---+---+---+---+---+
func composeSIB(scale byte, index byte, base byte) byte {
	return scale<<6 + index<<3 + base
}

var variableInstrs []*Instruction

func isInInt8Range(n int) bool {
	return -128 <= n && n <= 127
}

// 3.1.1.3 Instruction Column in the Opcode Summary Table
// The “Instruction” column gives the syntax of the instruction statement as it would appear in an ASM386 program.
// The following is a list of the symbols used to represent operands in the instruction statements:
//
// • rel8 — A relative address in the range from 128 bytes before the end of the instruction to 127 bytes after the
// end of the instruction.
// • rel16, rel32 — A relative address within the same code segment as the instruction assembled. The rel16
// symbol applies to instructions with an operand-size attribute of 16 bits; the rel32 symbol applies to instructions
// with an operand-size attribute of 32 bits.
type variableCode struct {
	trgtSymbol  string
	rel8Code    []byte
	rel8Offset  uintptr
	rel32Code   []byte
	rel32Offset uintptr
}

type Instruction struct {
	addr                 uintptr
	symbolDefinition     string
	stmt                 *Stmt
	index                int
	code                 []byte // fixed length code
	varcode              *variableCode
	isLenDecided         bool
	next                 *Instruction
	unresolvedCallTarget *callTarget
}

func (ins *Instruction) String() string {
	return fmt.Sprintf("[%04x] %s", ins.addr, ins.stmt.source)
}

//var callTargets []*callTarget

type callTarget struct {
	trgtSymbol string
	caller     *Instruction
	offset     uintptr
	width      int // 1 or 4 or 8
}

func registerCallTarget(instr *Instruction, trgtSymbol string) {

}

func calcDistance(userInstr *Instruction, symdef *symbolDefinition) (int, int, int, bool) {
	var from, to *Instruction
	forward := userInstr.index <= symdef.instr.index
	if forward {
		from, to = userInstr.next, symdef.instr
	} else {
		from, to = symdef.instr, userInstr.next
	}
	var hasVariableLength bool
	var diff, min, max int
	for instr := from; instr != to; instr = instr.next {
		if !instr.isLenDecided {
			hasVariableLength = true
			lenShort, lenLarge := len(instr.varcode.rel8Code), len(instr.varcode.rel32Code)
			min += lenShort
			max += lenLarge
			diff += lenLarge // because instr.code is nil in this case
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

func appendRelaTextUser(ru *relaTextUser, stmt *Stmt) {
	//fmt.Fprintf(os.Stderr, "appending RU: %s from '%s'\n", ru.uses, stmt.source)
	relaTextUsers = append(relaTextUsers, ru)
}

func Bytes(b ...byte) []byte {
	return b
}

func Encode(s *Stmt) *Instruction {
	defer func() {
		if x := recover(); x != nil {
			panic(fmt.Sprintf("%s\n[encoder] %s at %s:%d\n\n  ./tool/encode '%s'",
				x,
				s.source, *s.filePath, s.lineno, s.source))
		}
	}()

	if s.keySymbol == "" {
		// No instruction
		return &Instruction{
			stmt:         s,
			isLenDecided: true,
		}
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

	cd, vr, rela, cltrgt := encode(s, s.keySymbol, srcOp, trgtOp)

	var instr = &Instruction{
		stmt:                 s,
		code:                 cd,
		unresolvedCallTarget: cltrgt,
		varcode:              vr,
	}

	if rela != nil {
		rela.instr = instr
		appendRelaTextUser(rela, s)
	}
	if cltrgt != nil {
		cltrgt.caller = instr
	}

	if vr != nil {
		variableInstrs = append(variableInstrs, instr)
	} else {
		instr.isLenDecided = true
	}

	return instr
}

func encode(stmt *Stmt, keySymbol string, srcOp Operand, trgtOp Operand) (code []byte, vrCode *variableCode, ru *relaTextUser, ct *callTarget) {
	switch keySymbol {
	case ".text":
	case ".global":
	case "nop":
		code = Bytes(0x90)
		return
	case "ret", "retq":
		code = Bytes(0xc3)
		return
	case "syscall":
		code = Bytes(0x0f, 0x05)
		return
	case "leave":
		code = Bytes(0xc9)
		return
	case "jmp": // JMP rel8 or rel32s
		trgtSymbol := trgtOp.(*symbolExpr).name
		vrCode = &variableCode{
			trgtSymbol: trgtSymbol,
			// JMP rel8: EB cb
			rel8Code:   Bytes(0xeb, 0),
			rel8Offset: 1,
			// JMP rel32: E9 cd
			rel32Code:   Bytes(0xe9, 0, 0, 0, 0),
			rel32Offset: 1,
		}
		return
	case "je": // JE rel8 or rel32
		trgtSymbol := trgtOp.(*symbolExpr).name
		vrCode = &variableCode{
			trgtSymbol: trgtSymbol,
			// JE rel8: 74 cb
			rel8Code:   Bytes(0x74, 0),
			rel8Offset: 1,
			// JE rel32: 0F 84 cd
			rel32Code:   Bytes(0x0f, 0x84, 0, 0, 0, 0),
			rel32Offset: 2,
		}
		return
	case "jne":
		trgtSymbol := trgtOp.(*symbolExpr).name
		vrCode = &variableCode{
			trgtSymbol: trgtSymbol,
			// JNE rel8: 75 cb
			rel8Code:   Bytes(0x75, 0),
			rel8Offset: 1,
			// JE rel32: 0F 85 cd
			rel32Code:   Bytes(0x0f, 0x85, 0, 0, 0, 0),
			rel32Offset: 2,
		}
		return
	case "callq", "call":
		switch trgt := trgtOp.(type) {
		case *symbolExpr:
			trgtSymbol := trgt.name
			// call rel16
			code = Bytes(0xe8, 0, 0, 0, 0)
			ru = &relaTextUser{
				offset: 1,
				uses:   trgtSymbol,
				toJump: true,
			}
			debugf("registering unresolved callTarget: %s\n", trgtSymbol)
			ct = &callTarget{
				trgtSymbol: trgtSymbol,
				offset:     1,
				width:      4,
			}
			return
		case *indirectCallTarget:
			// CALL m16:32
			// FF /3
			// In 64-bit mode: If selector points to a gate, then RIP = 64-bit displacement taken from gate;
			// else RIP = zero extended 32-bit offset from far pointer referenced in the instruction.
			opcode := uint8(0xff)
			regi := trgt.regi.toBits()
			// RIP relative addressing
			modRM := composeModRM(ModRegi, 0b010, regi) // why regOp is 010 ??
			if trgt.regi.isExt() {
				code = Bytes(REX_B, opcode, modRM)
			} else {
				code = Bytes(opcode, modRM)
			}
			return
		}
	case "leaq":
		switch src := srcOp.(type) {
		case *indirection: // leaq foo(%regi), %regi
			srcRegi := src.regi
			trgtRegi := trgtOp.(*register)
			var opcode uint8 = 0x8d
			if srcRegi.name == "rip" {
				// RIP relative addressing
				mod := ModIndirectionWithNoDisplacement
				modRM := composeModRM(mod, trgtRegi.toBits(), RM_RIP_RELATIVE)
				code = Bytes(REX_W, opcode, modRM)

				symbol := src.expr.(*symbolExpr).name
				ru = &relaTextUser{
					offset: uintptr(len(code)),
					uses:   symbol,
				}

				code = append(code, 0, 0, 0, 0)
				return
			} else { // leaq NUM(%regi), %regi
				num := src.expr.(*numberLit).val
				displacement, err := strconv.ParseInt(num, 0, 32)
				if err != nil {
					panic(err)
				}

				var modRM, rm, reg byte
				var displacementBytes []byte
				if displacement == 0 {
					rm = srcRegi.toBits()
					if srcRegi.isStackPointer() {
						mod := ModIndirectionWithNoDisplacement
						reg = trgtRegi.toBits()
						modRM = composeModRM(mod, reg, rm)
						// There is no displacementBytes. For optimization ?
					} else {
						// same as isInInt8Range case below
						mod := ModIndirectionWithDisplacement8
						reg = trgtRegi.toBits()
						modRM = composeModRM(mod, reg, rm)
						displacementBytes = Bytes(0)
					}
				} else if isInInt8Range(int(displacement)) {
					mod := ModIndirectionWithDisplacement8
					reg = trgtRegi.toBits()
					rm = srcRegi.toBits()
					modRM = composeModRM(mod, reg, rm)
					displacementBytes = Bytes(uint8(displacement))
				} else {
					mod := ModIndirectionWithDisplacement32
					reg = trgtRegi.toBits()
					rm = srcRegi.toBits()
					modRM = composeModRM(mod, reg, rm)
					var disp32 int32 = int32(displacement)
					displacementBytes = (*[4]byte)(unsafe.Pointer(&disp32))[:]
				}

				if srcRegi.isStackPointer() {
					sib := composeSIB(0b00, SibIndexNone, SibBaseRSP)
					code = Bytes(REX_W, opcode, modRM, sib)
					code = append(code, displacementBytes...)
				} else {
					code = Bytes(REX_W, opcode, modRM)
					code = append(code, displacementBytes...)
				}

				return
			}
		default:
			panic(fmt.Sprintf("TBI: %T (%s)", srcOp, stmt.source))
		}
	case "movb":
		switch src := srcOp.(type) {
		case *register:
			opcode := uint8(0x88)
			switch trgt := trgtOp.(type) {
			case *indirection:
				// movb %al,0(%rsi)
				assert(evalNumExpr(trgt.expr) == 0, "expect offset 0")
				mod := ModIndirectionWithNoDisplacement
				reg := src.toBits()
				rm := trgt.regi.toBits()
				modRM := composeModRM(mod, reg, rm)
				code = Bytes(opcode, modRM)
				return
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
			opcode := uint8(0x89)
			switch trgt := trgtOp.(type) {
			case *indirection:
				// movw %ax,0(%rsi)
				assert(evalNumExpr(trgt.expr) == 0, "expect offset 0")
				mod := ModIndirectionWithNoDisplacement
				reg := src.toBits()
				rm := trgt.regi.toBits()
				modRM := composeModRM(mod, reg, rm)
				code = Bytes(PREFIX, opcode, modRM)
				return
			default:
				panic("TBI")
			}
		default:
			panic("TBI")
		}
	case "movl":
		switch src := srcOp.(type) {
		case *immediate: // movl $56, %eax
			intNum, err := strconv.ParseInt(src.expr.(*numberLit).val, 0, 32)
			if err != nil {
				panic(err)
			}
			num := int32(intNum)
			bytesNum := (*[4]byte)(unsafe.Pointer(&num))
			trgtRegi := trgtOp.(*register)
			regFieldN := trgtRegi.toBits()
			opcode := 0xb8 + regFieldN
			code = append(Bytes(opcode), bytesNum[:]...)
			return
		default:
			panic("TBI")
		}
	case "movq":
		switch src := srcOp.(type) {
		case *immediate: // movq $123, %REG
			intNum, err := strconv.ParseInt(src.expr.(*numberLit).val, 0, 32)
			if err != nil {
				panic(err)
			}
			num := int32(intNum)
			bytesNum := (*[4]byte)(unsafe.Pointer(&num))

			trgtRegi := trgtOp.(*register)
			//debugf("num=%d, trgtRegi=%s\n", num, trgtRegi.name)

			var rex byte
			if trgtRegi.isExt() {
				rex = REX_WB
			} else {
				rex = REX_W
			}
			opcode := uint8(0xc7)
			modRM := composeModRM(ModRegi, 0, trgtRegi.toBits())
			code = Bytes(rex, opcode, modRM)
			code = append(code, bytesNum[:]...)
			return
		case *register: // movq %rax, EXPR
			opcode := uint8(0x89)
			switch trgt := trgtOp.(type) {
			case *register:
				mod := ModRegi
				reg := src.toBits()
				rm := trgt.toBits()
				modRM := composeModRM(mod, reg, rm)
				code = Bytes(REX_W, opcode, modRM)
				return
			case *indirection: // movq %rax, N(EXPR)
				if trgt.isRipRelative() {
					switch expr := trgt.expr.(type) {
					case *binaryExpr:
						// REX.W 89 /r (MOV r/m64 r64, MR)
						// "movq %rbx, runtime.__argv__+8(%rip)"
						mod := ModIndirectionWithNoDisplacement
						reg := src.toBits() // src
						modRM := composeModRM(mod, reg, RM_RIP_RELATIVE)
						code = Bytes(REX_W, opcode, modRM)

						symbol := expr.left.(*symbolExpr).name
						ru = &relaTextUser{
							offset: uintptr(len(code)),
							uses:   symbol,
							adjust: int64(evalNumExpr(expr.right)),
						}
						code = append(code, 0, 0, 0, 0)
						return
					case *symbolExpr: // "movq %rax, runtime.main_main(%rip)"
						mod := ModIndirectionWithNoDisplacement
						reg := src.toBits() // src
						modRM := composeModRM(mod, reg, RM_RIP_RELATIVE)
						code = Bytes(REX_W, opcode, modRM)

						symbol := expr.name
						ru = &relaTextUser{
							offset: uintptr(len(code)),
							uses:   symbol,
							adjust: 0,
						}
						code = append(code, 0, 0, 0, 0)
						return
					default:
						panic(fmt.Sprintf("TBI: trgt.expr:%T %+v", trgt.expr, trgt.expr))
					}
				} else {
					// movq %rax, 32(%rsp)
					switch trgtExpr := trgt.expr.(type) {
					case nil:
						rm := trgt.regi.toBits()
						reg := src.toBits()
						if trgt.regi.isStackPointer() { // movq %rax, (%rsp)
							mod := ModIndirectionWithNoDisplacement
							modRM := composeModRM(mod, reg, rm)
							sib := composeSIB(0b00, SibIndexNone, SibBaseRSP)
							code = Bytes(REX_W, opcode, modRM, sib)
							return
						} else {
							// movq %rax, (%rcx)
							// this is the same as "movq %rax, 0(%rcx)" case in blow "else" block
							mod := ModIndirectionWithNoDisplacement
							modRM := composeModRM(mod, reg, rm)
							code = Bytes(REX_W, opcode, modRM)
							return
						}
					case *numberLit:
						reg := src.toBits()
						rm := trgt.regi.toBits()
						num := trgtExpr.val
						displacement, err := strconv.ParseInt(num, 0, 8)
						if err != nil {
							panic(err)
						}
						if trgt.regi.isStackPointer() {
							if displacement == 0 { // movq %rax, 0(%rsp) => movq %rax, (%rsp)
								mod := ModIndirectionWithNoDisplacement
								modRM := composeModRM(mod, reg, rm)
								sib := composeSIB(0b00, SibIndexNone, SibBaseRSP)
								code = Bytes(REX_W, opcode, modRM, sib)
							} else {
								// insert SIB byte
								mod := ModIndirectionWithDisplacement8
								modRM := composeModRM(mod, reg, rm)
								sib := composeSIB(0b00, SibIndexNone, SibBaseRSP)
								code = Bytes(REX_W, opcode, modRM, sib, uint8(displacement))
							}
						} else {
							if displacement == 0 {
								mod := ModIndirectionWithNoDisplacement
								modRM := composeModRM(mod, reg, rm)
								code = Bytes(REX_W, opcode, modRM)
							} else {
								mod := ModIndirectionWithDisplacement8
								modRM := composeModRM(mod, reg, rm)
								code = Bytes(REX_W, opcode, modRM, uint8(displacement))
							}
						}
					default:
						panic("unexpected target expr:" + fmt.Sprintf("%+v", trgtOp))
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
				code = Bytes(REX_W, opcode, modRM)

				symbol := src.expr.(*symbolExpr).name
				ru = &relaTextUser{
					offset: uintptr(len(code)),
					uses:   symbol,
				}

				code = append(code, 0, 0, 0, 0)
				return
			} else if srcRegi.name == "rsp" {
				var rexprefix uint8
				if trgtRegi.isExt() {
					rexprefix = REX_WR
				} else {
					rexprefix = REX_W
				}
				var opcode uint8 = 0x8b
				var rm = srcRegi.toBits()
				val := evalNumExpr(src.expr)
				if val == 0 {
					var mod = ModIndirectionWithNoDisplacement // indirection
					reg := trgtRegi.toBits()
					modRM := composeModRM(mod, reg, rm)
					sib := composeSIB(0b00, SibIndexNone, SibBaseRSP)
					code = Bytes(rexprefix, opcode, modRM, sib)
					return
				} else {
					var mod = ModIndirectionWithDisplacement8
					reg := trgtRegi.toBits()
					modRM := composeModRM(mod, reg, rm)
					sib := composeSIB(0b00, SibIndexNone, SibBaseRSP)
					if val > 256 {
						panic("TBI")
					}
					code = Bytes(rexprefix, opcode, modRM, sib, uint8(val))
					return
				}
			} else {
				var rexprefix uint8
				if trgtRegi.isExt() {
					rexprefix = REX_WR
				} else {
					rexprefix = REX_W
				}
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
					code = Bytes(rexprefix, opcode, modRM, uint8(ival))
					return
				} else {
					mod := ModIndirectionWithNoDisplacement
					rm := srcRegi.toBits()
					modRM := composeModRM(mod, reg, rm)
					code = Bytes(rexprefix, opcode, modRM)
					return
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
			code = Bytes(REX_W, 0x0f, 0xb6, modRM)
			return
		case *indirection:
			mod := ModIndirectionWithNoDisplacement
			rm := src.regi.toBits()
			reg := trgtOp.(*register).toBits()
			modRM := composeModRM(mod, reg, rm)
			if src.regi.isStackPointer() {
				// use SIB
				sib := composeSIB(0b00, SibIndexNone, SibBaseRSP)
				code = Bytes(REX_W, 0x0f, 0xb6, modRM, sib)
			} else {
				code = Bytes(REX_W, 0x0f, 0xb6, modRM)
			}
			return
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
			code = Bytes(REX_W, 0x0f, 0xb7, modRM)
			return
		default:
			panic("TBI")
		}
	case "addl":
		var opcode uint8 = 0x01
		regFieldN := trgtOp.(*register).toBits()
		var modRM uint8 = 0b11000000 + regFieldN
		code = Bytes(opcode, modRM)
		return
	case "addq":
		switch src := srcOp.(type) {
		case *register:
			opcode := uint8(0x01)
			regi := srcOp.(*register).toBits()
			rm := trgtOp.(*register).toBits()
			modRM := composeModRM(ModRegi, regi, rm)
			code = Bytes(REX_W, opcode, modRM)
			return
		case *immediate: // "addq $32, %regi"
			{
				rm := trgtOp.(*register).toBits()
				modRM := composeModRM(ModRegi, slash_0, rm)
				imValue := evalNumExpr(src.expr)
				switch {
				case isInInt8Range(imValue):
					code = Bytes(REX_W, 0x83, modRM, uint8(imValue))
					return
				case imValue < 1<<31:
					i32 := int32(imValue)
					hex := (*[4]uint8)(unsafe.Pointer(&i32))
					if trgtOp.(*register).name == "rax" {
						code = Bytes(REX_W, 0x05, hex[0], hex[1], hex[2], hex[3])
						return
					} else {
						code = Bytes(REX_W, 0x05, modRM, hex[0], hex[1], hex[2], hex[3])
						return
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
			code = Bytes(REX_W, opcode, modRM)
			return
		case *immediate:
			rm := trgtOp.(*register).toBits()
			modRM := composeModRM(ModRegi, slash_5, rm)
			imValue, err := strconv.ParseInt(src.expr.(*numberLit).val, 0, 32)
			if err != nil {
				panic(err)
			}
			switch {
			case imValue < 1<<7:
				code = Bytes(REX_W, 0x83, modRM, uint8(imValue))
				return
			case imValue < 1<<31:
				i32 := int32(imValue)
				hex := (*[4]uint8)(unsafe.Pointer(&i32))
				code = Bytes(REX_W, 0x81, modRM, hex[0], hex[1], hex[2], hex[3])
				return
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
			code = Bytes(REX_W, opcodes[0], opcodes[1], modRM)
			return
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
			code = Bytes(REX_W, opcode, modRM, uint8(imValue)) // REX.W, IMULQ, ModR/M, ib
			return
		default:
			panic("TBI")
		}
	case "divq":
		opcode := uint8(0xf7)
		rm := trgtOp.(*register).toBits()
		modRM := composeModRM(ModRegi, slash_6, rm)
		code = Bytes(REX_W, opcode, modRM)
		return
	case "cmpq":
		switch src := srcOp.(type) {
		case *register:
			opcode := uint8(0x39)
			regi := src.toBits()
			rm := trgtOp.(*register).toBits()
			modRM := composeModRM(ModRegi, regi, rm)
			code = Bytes(REX_W, opcode, modRM)
			return
		case *immediate:
			opcode := uint8(0x83)
			imValue, err := strconv.ParseInt(src.expr.(*numberLit).val, 0, 8)
			if err != nil {
				panic(err)
			}
			rm := trgtOp.(*register).toBits()
			modRM := composeModRM(ModRegi, 7, rm)
			code = Bytes(REX_W, opcode, modRM, uint8(imValue))
			return
		default:
			panic("TBI:" + stmt.source)
		}
	case "setl":
		reg := trgtOp.(*register).toBits()
		modRM := composeModRM(ModRegi, reg, 0)
		code = Bytes(0x0f, 0x9c, modRM)
		return
	case "setle":
		reg := trgtOp.(*register).toBits()
		modRM := composeModRM(ModRegi, reg, 0)
		code = Bytes(0x0f, 0x9e, modRM)
		return
	case "setg":
		reg := trgtOp.(*register).toBits()
		modRM := composeModRM(ModRegi, reg, 0)
		code = Bytes(0x0f, 0x9f, modRM)
		return
	case "setge":
		reg := trgtOp.(*register).toBits()
		modRM := composeModRM(ModRegi, reg, 0)
		code = Bytes(0x0f, 0x9d, modRM)
		return
	case "sete":
		reg := trgtOp.(*register).toBits()
		modRM := composeModRM(ModRegi, reg, 0)
		code = Bytes(0x0f, 0x94, modRM)
		return
	case "pushq":
		switch trgt := trgtOp.(type) {
		case *register:
			code = Bytes(0x50 + trgt.toBits())
			return
		case *immediate:
			imValue, err := strconv.ParseInt(trgt.expr.(*numberLit).val, 0, 32)
			if err != nil {
				panic(err)
			}
			switch {
			case imValue < 1<<7: //PUSH imm8 : 6a ib
				code = Bytes(0x6a, uint8(imValue))
				return
			//case imValue < 1<<14 : //PUSH imm16: 	68 iw
			//	ui16 := int16(imValue)
			//	hex := (*[2]uint8)(unsafe.Pointer(&ui16))
			//	r = Bytes(0x68, hex[0], hex[1])
			case imValue < 1<<31: // PUSH imm32 68 id
				ui32 := int32(imValue)
				hex := (*[4]uint8)(unsafe.Pointer(&ui32))
				code = Bytes(0x68, hex[0], hex[1], hex[2], hex[3])
				return
			default:
				panic("TBI")
			}
		default:
			panic("[encoder] TBI:" + stmt.source)
		}
	case "popq":
		switch trgt := trgtOp.(type) {
		case *register:
			// 58 +rd. POP r64.
			code = Bytes(0x58 + trgt.toBits())
			return
		default:
			panic("[encoder] TBI:" + stmt.source)
		}
	case "xor", "xorq":
		switch src := srcOp.(type) {
		case *immediate:
			// XOR r/m64, imm8
			// REX.W 83 /6 ib
			opcode := uint8(0x83)
			rm := trgtOp.(*register).toBits()
			modRM := composeModRM(ModRegi, slash_6, rm)
			imValue := evalNumExpr(src.expr)
			code = Bytes(REX_W, opcode, modRM, uint8(imValue))
			return
		case *register:
			regi := src.toBits()
			rm := trgtOp.(*register).toBits()
			modRM := composeModRM(ModRegi, regi, rm)
			code = Bytes(REX_W, 0x31, modRM)
			return
		default:
			panic("TBI")

		}
	case "andq":
		// AND r/m64, r64
		// REX.W 21
		regi := srcOp.(*register).toBits()
		rm := trgtOp.(*register).toBits()
		modRM := composeModRM(ModRegi, regi, rm)
		code = Bytes(REX_W, 0x21, modRM)
		return
	case "orq":
		regi := srcOp.(*register).toBits()
		rm := trgtOp.(*register).toBits()
		modRM := composeModRM(ModRegi, regi, rm)
		code = Bytes(REX_W, 0x09, modRM)
		return
	default:
		panic(fmt.Sprintf("[encoder] Unknown instruction: %s at line %d\n\n /tool/encode '%s'",
			stmt.source, 0, stmt.source))
	}

	return code, vrCode, ru, ct
}

func encodeData(s *Stmt, dataAddr uintptr, labeledSymbols map[string]*symbolDefinition) []byte {
	defer func() {
		if x := recover(); x != nil {
			panic(fmt.Sprintf("%s\n[encoder] %s at %s:%d\n\necho '%s' |./encode as",
				x,
				s.source, *s.filePath, s.lineno, s.source))
		}
	}()

	if s.labelSymbol != "" {
		labeledSymbols[s.labelSymbol].address = dataAddr
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
		val := op.(*strLit).val
		bytes := append([]byte(val), 0)
		return bytes
	default:
		panic("TBI:" + s.keySymbol)
	}
	return nil
}
