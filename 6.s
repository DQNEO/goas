#===================== generateCode unsafe =====================
.data

.text
unsafe.__initGlobals:
  ret

# ------- Dynamic Types ------
.data

#===================== generateCode runtime =====================
.data
.runtime.S0:
  .string "Not supported key type"
.runtime.S1:
  .string "Not supported key type"
.runtime.S2:
  .string ""
.runtime.S3:
  .string "panic: "
.runtime.S4:
  .string "NEWLINE\n\nNEWLINE"
.runtime.S5:
  .string "panic: "
.runtime.S6:
  .string "Unknown type"
.runtime.S7:
  .string "\n\n"
.runtime.S8:
  .string "malloc exceeded heap max"
runtime.heapHead: # T T_UINTPTR
  .quad 0
runtime.heapCurrent: # T T_UINTPTR
  .quad 0
runtime.heapTail: # T T_UINTPTR
  .quad 0
runtime.__argv__: # T T_SLICE
  .quad 0 # ptr
  .quad 0 # len
  .quad 0 # cap
runtime.envp: # T T_UINTPTR
  .quad 0
runtime.envlines: # T T_SLICE
  .quad 0 # ptr
  .quad 0 # len
  .quad 0 # cap
runtime.Envs: # T T_SLICE
  .quad 0 # ptr
  .quad 0 # len
  .quad 0 # cap

.text
runtime.__initGlobals:
  ret
# emitFuncDecl
runtime.$item.valueAddr: # args 32, locals 0
  pushq %rbp
  movq %rsp, %rbp
  leaq 24(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  leaq 16(%rbp), %rax # local variable "i"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64
  pushq %rax
  popq %rax
  addq $24, %rax
  pushq %rax
  popq %rax # address of T_UINTPTR
  movq 0(%rax), %rax # load 64
  pushq %rax
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign
  leave
  ret
  leave
  ret
