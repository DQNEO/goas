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
  .string "\n\n"
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
# emitFuncDecl
runtime.$item.match: # args 48, locals -40
  pushq %rbp
  movq %rsp, %rbp
  subq $40, %rsp # local area
  leaq -16(%rbp), %rax # local variable ".switch_expr"
  pushq %rax # variable address
  leaq 24(%rbp), %rax # local variable "key"
  pushq %rax # variable address
  popq %rax # address of T_INTERFACE
  movq 8(%rax), %rdx # data
  movq 0(%rax), %rax # dtype
  pushq %rdx # data
  pushq %rax # dtype
  popq %rax # eface.dtype
  popq %rcx # eface.data
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # store dtype
  movq %rcx, 8(%rsi) # store data
  leaq -16(%rbp), %rax # local variable ".switch_expr"
  pushq %rax # variable address
  popq %rax # address of type switch subject
  movq (%rax), %rax # dtype label addr
  pushq %rax # dtype label addr
  leaq runtime.dtype.1(%rip), %rax # dtype label address "string"
  pushq %rax           # dtype label address
  popq %rdx           # dtype label address A
  popq %rcx           # dtype label address B
  cmpq %rcx, %rdx
  je .L.cmpdtypes.3.true # jump if match
  cmpq $0, %rdx # check if A is nil
  je .L.cmpdtypes.3.false # jump if nil
  cmpq $0, %rcx # check if B is nil
  je .L.cmpdtypes.3.false # jump if nil
  jmp .L.cmpdtypes.3.cmp # jump to end
.L.cmpdtypes.3.true:
  pushq $1
  jmp .L.cmpdtypes.3.end # jump to end
.L.cmpdtypes.3.false:
  pushq $0
  jmp .L.cmpdtypes.3.end # jump to end
.L.cmpdtypes.3.cmp:
  subq $8, %rsp # alloc return vars area
  movq 16(%rax), %rdx           # str.len of dtype A
  pushq %rdx
  movq 8(%rax), %rdx           # str.ptr of dtype A
  pushq %rdx
  movq 16(%rcx), %rdx           # str.len of dtype B
  pushq %rdx
  movq 8(%rcx), %rdx           # str.ptr of dtype B
  pushq %rdx
  callq runtime.cmpstrings
  addq $32, %rsp # free parameters area
.L.cmpdtypes.3.end:
  popq %rax # result of  of switch-case comparison
  cmpq $1, %rax
  je .L.case.2 # jump if match
  leaq -16(%rbp), %rax # local variable ".switch_expr"
  pushq %rax # variable address
  popq %rax # address of type switch subject
  movq (%rax), %rax # dtype label addr
  pushq %rax # dtype label addr
  leaq runtime.dtype.2(%rip), %rax # dtype label address "unsafe.Pointer"
  pushq %rax           # dtype label address
  popq %rdx           # dtype label address A
  popq %rcx           # dtype label address B
  cmpq %rcx, %rdx
  je .L.cmpdtypes.5.true # jump if match
  cmpq $0, %rdx # check if A is nil
  je .L.cmpdtypes.5.false # jump if nil
  cmpq $0, %rcx # check if B is nil
  je .L.cmpdtypes.5.false # jump if nil
  jmp .L.cmpdtypes.5.cmp # jump to end
.L.cmpdtypes.5.true:
  pushq $1
  jmp .L.cmpdtypes.5.end # jump to end
.L.cmpdtypes.5.false:
  pushq $0
  jmp .L.cmpdtypes.5.end # jump to end
.L.cmpdtypes.5.cmp:
  subq $8, %rsp # alloc return vars area
  movq 16(%rax), %rdx           # str.len of dtype A
  pushq %rdx
  movq 8(%rax), %rdx           # str.ptr of dtype A
  pushq %rdx
  movq 16(%rcx), %rdx           # str.len of dtype B
  pushq %rdx
  movq 8(%rcx), %rdx           # str.ptr of dtype B
  pushq %rdx
  callq runtime.cmpstrings
  addq $32, %rsp # free parameters area
.L.cmpdtypes.5.end:
  popq %rax # result of  of switch-case comparison
  cmpq $1, %rax
  je .L.case.4 # jump if match
  jmp .L.case.6
.L.case.2:
  leaq -32(%rbp), %rax # local variable "k"
  pushq %rax # variable address
  leaq -16(%rbp), %rax # local variable ".switch_expr"
  pushq %rax # variable address
  popq %rax # address of T_INTERFACE
  movq 8(%rax), %rdx # data
  movq 0(%rax), %rax # dtype
  pushq %rdx # data
  pushq %rax # dtype
  popq %rax # ifc.dtype
  popq %rcx # ifc.data
  pushq %rcx # ifc.data
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
  leaq 40(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  subq $8, %rsp # alloc return vars area
  subq $32, %rsp # alloc parameters area
  leaq 16(%rbp), %rax # local variable "i"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64
  pushq %rax
  popq %rax
  addq $8, %rax
  pushq %rax
  popq %rax # address of T_INTERFACE
  movq 8(%rax), %rdx # data
  movq 0(%rax), %rax # dtype
  pushq %rdx # data
  pushq %rax # dtype
  leaq runtime.dtype.1(%rip), %rax # dtype label address "string"
  pushq %rax           # dtype label address
  popq %rdx           # dtype label address A
  popq %rcx           # dtype label address B
  cmpq %rcx, %rdx
  je .L.cmpdtypes.7.true # jump if match
  cmpq $0, %rdx # check if A is nil
  je .L.cmpdtypes.7.false # jump if nil
  cmpq $0, %rcx # check if B is nil
  je .L.cmpdtypes.7.false # jump if nil
  jmp .L.cmpdtypes.7.cmp # jump to end
.L.cmpdtypes.7.true:
  pushq $1
  jmp .L.cmpdtypes.7.end # jump to end
.L.cmpdtypes.7.false:
  pushq $0
  jmp .L.cmpdtypes.7.end # jump to end
.L.cmpdtypes.7.cmp:
  subq $8, %rsp # alloc return vars area
  movq 16(%rax), %rdx           # str.len of dtype A
  pushq %rdx
  movq 8(%rax), %rdx           # str.ptr of dtype A
  pushq %rdx
  movq 16(%rcx), %rdx           # str.len of dtype B
  pushq %rdx
  movq 8(%rcx), %rdx           # str.ptr of dtype B
  pushq %rdx
  callq runtime.cmpstrings
  addq $32, %rsp # free parameters area
.L.cmpdtypes.7.end:
  popq %rax # result of type assertion ok value
  cmpq $1, %rax
  jne .L.unmatch.8 # jmp if false
  popq %rax # address of T_STRING
  movq 8(%rax), %rdx # len
  movq 0(%rax), %rax # ptr
  pushq %rdx # len
  pushq %rax # ptr
  jmp .L.end_type_assertion.8
  .L.unmatch.8:
  popq %rax # drop ifc.data
  pushq $0 # string len
  pushq $0 # string ptr
  .L.end_type_assertion.8:
  popq %rax # string.ptr
  popq %rcx # string.len
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  leaq -32(%rbp), %rax # local variable "k"
  pushq %rax # variable address
  popq %rax # address of T_STRING
  movq 8(%rax), %rdx # len
  movq 0(%rax), %rax # ptr
  pushq %rdx # len
  pushq %rax # ptr
  popq %rax # string.ptr
  popq %rcx # string.len
  leaq 16(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  callq runtime.cmpstrings
  addq $32, %rsp # free parameters area
#  totalReturnSize=8
  popq %rax # result of T_BOOL
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign
  leave
  ret
  jmp .L.typeswitch.1.exit
.L.case.4:
  leaq -40(%rbp), %rax # local variable "k"
  pushq %rax # variable address
  leaq -16(%rbp), %rax # local variable ".switch_expr"
  pushq %rax # variable address
  popq %rax # address of T_INTERFACE
  movq 8(%rax), %rdx # data
  movq 0(%rax), %rax # dtype
  pushq %rdx # data
  pushq %rax # dtype
  popq %rax # ifc.dtype
  popq %rcx # ifc.data
  pushq %rcx # ifc.data
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64
  pushq %rax
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign
  leaq 40(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  leaq 16(%rbp), %rax # local variable "i"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64
  pushq %rax
  popq %rax
  addq $8, %rax
  pushq %rax
  popq %rax # address of T_INTERFACE
  movq 8(%rax), %rdx # data
  movq 0(%rax), %rax # dtype
  pushq %rdx # data
  pushq %rax # dtype
  leaq runtime.dtype.2(%rip), %rax # dtype label address "unsafe.Pointer"
  pushq %rax           # dtype label address
  popq %rdx           # dtype label address A
  popq %rcx           # dtype label address B
  cmpq %rcx, %rdx
  je .L.cmpdtypes.9.true # jump if match
  cmpq $0, %rdx # check if A is nil
  je .L.cmpdtypes.9.false # jump if nil
  cmpq $0, %rcx # check if B is nil
  je .L.cmpdtypes.9.false # jump if nil
  jmp .L.cmpdtypes.9.cmp # jump to end
.L.cmpdtypes.9.true:
  pushq $1
  jmp .L.cmpdtypes.9.end # jump to end
.L.cmpdtypes.9.false:
  pushq $0
  jmp .L.cmpdtypes.9.end # jump to end
.L.cmpdtypes.9.cmp:
  subq $8, %rsp # alloc return vars area
  movq 16(%rax), %rdx           # str.len of dtype A
  pushq %rdx
  movq 8(%rax), %rdx           # str.ptr of dtype A
  pushq %rdx
  movq 16(%rcx), %rdx           # str.len of dtype B
  pushq %rdx
  movq 8(%rcx), %rdx           # str.ptr of dtype B
  pushq %rdx
  callq runtime.cmpstrings
  addq $32, %rsp # free parameters area
.L.cmpdtypes.9.end:
  popq %rax # result of type assertion ok value
  cmpq $1, %rax
  jne .L.unmatch.10 # jmp if false
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64
  pushq %rax
  jmp .L.end_type_assertion.10
  .L.unmatch.10:
  popq %rax # drop ifc.data
  pushq $0 # T_POINTER zero value
  .L.end_type_assertion.10:
  leaq -40(%rbp), %rax # local variable "k"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64
  pushq %rax
  popq %rcx # right
  popq %rax # left
  cmpq %rcx, %rax
  sete %al
  movzbq %al, %rax
  pushq %rax
  popq %rax # result of T_BOOL
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign
  leave
  ret
  jmp .L.typeswitch.1.exit
.L.case.6:
  subq $16, %rsp # alloc parameters area
  pushq $22 # str len
  leaq .runtime.S0(%rip), %rax # str ptr
  pushq %rax # str ptr
  subq $8, %rsp # alloc return vars area
  pushq $16
  callq runtime.malloc
  addq $8, %rsp # free parameters area
#  totalReturnSize=8
  popq %rsi # lhs addr
  popq %rax # string.ptr
  popq %rcx # string.len
  pushq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  leaq runtime.dtype.1(%rip), %rax # dtype label address "string"
  pushq %rax           # dtype label address
  popq %rax # eface.dtype
  popq %rcx # eface.data
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # store dtype
  movq %rcx, 8(%rsi) # store data
  callq runtime.panic
  addq $16, %rsp # free parameters area
#  totalReturnSize=0
  jmp .L.typeswitch.1.exit
.L.typeswitch.1.exit:
  subq $16, %rsp # alloc parameters area
  pushq $22 # str len
  leaq .runtime.S1(%rip), %rax # str ptr
  pushq %rax # str ptr
  subq $8, %rsp # alloc return vars area
  pushq $16
  callq runtime.malloc
  addq $8, %rsp # free parameters area
#  totalReturnSize=8
  popq %rsi # lhs addr
  popq %rax # string.ptr
  popq %rcx # string.len
  pushq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  leaq runtime.dtype.1(%rip), %rax # dtype label address "string"
  pushq %rax           # dtype label address
  popq %rax # eface.dtype
  popq %rcx # eface.data
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # store dtype
  movq %rcx, 8(%rsi) # store data
  callq runtime.panic
  addq $16, %rsp # free parameters area
#  totalReturnSize=0
  leaq 40(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  pushq $0 # false
  popq %rax # result of T_BOOL
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign
  leave
  ret
  leave
  ret
