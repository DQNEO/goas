#=== Package github.com/DQNEO/babygo/lib/token
#--- walk 
# Package types:
# type token.Token string
# type token.Pos int
# type token.FileSet struct{base int;}
#--- string literals
.data
.string_0:
  .string "INT"
.string_1:
  .string "STRING"
.string_2:
  .string "+"
.string_3:
  .string "-"
.string_4:
  .string "&"
#--- global vars (static values)
.global token.INT
token.INT: # T T_STRING
  .quad .string_0
  .quad 3
.global token.STRING
token.STRING: # T T_STRING
  .quad .string_1
  .quad 6
.global token.NoPos
token.NoPos: # T T_INT
  .quad 0
.global token.ADD
token.ADD: # T T_STRING
  .quad .string_2
  .quad 1
.global token.SUB
token.SUB: # T T_STRING
  .quad .string_3
  .quad 1
.global token.AND
token.AND: # T T_STRING
  .quad .string_4
  .quad 1

#--- global vars (dynamic value setting)
.text
.global token.__initGlobals
token.__initGlobals:
  ret

# Method token.Token.String
.global token.Token.String
token.Token.String: # args 48, locals 0
  pushq %rbp
  movq %rsp, %rbp
  leaq 32(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  leaq 16(%rbp), %rax # local variable "tok"
  pushq %rax # variable address
  popq %rax # address of T_STRING
  movq 8(%rax), %rdx # len
  movq 0(%rax), %rax # ptr
  pushq %rdx # len
  pushq %rax # ptr
  popq %rax # string.ptr
  popq %rcx # string.len
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  leave
  ret
  leave
  ret
# ------- Dynamic Types ------
.data


