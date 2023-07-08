#=== Package runtime
#--- walk 
# Package types:
# type runtime.Map struct{first *runtime.item;length int;valueSize uintptr;}
# type runtime.item struct{next *runtime.item;key interface{};value uintptr;}
# type runtime.p struct{runq func;}
# type runtime.envEntry struct{key string;value string;}
#--- string literals
.data
.string_0:
  .string "Not supported key type"
.string_1:
  .string "hello, I am a cloned thread in mstart1\n"
.string_2:
  .string ""
.string_3:
  .string "panic: "
.string_4:
  .string "\n\n"
.string_5:
  .string "panic: "
.string_6:
  .string "Unknown type"
.string_7:
  .string "\n\n"
.string_8:
  .string "malloc exceeded heap max"
#--- global vars (static values)
.global runtime.heapHead
runtime.heapHead: # T T_UINTPTR
  .quad 0
.global runtime.heapCurrent
runtime.heapCurrent: # T T_UINTPTR
  .quad 0
.global runtime.heapTail
runtime.heapTail: # T T_UINTPTR
  .quad 0
.global runtime.argc
runtime.argc: # T T_INT
  .quad 0
.global runtime.argv
runtime.argv: # T T_POINTER
  .quad 0
.global runtime.argslice
runtime.argslice: # T T_SLICE
  .quad 0 # ptr
  .quad 0 # len
  .quad 0 # cap
.global runtime.mainStarted
runtime.mainStarted: # T T_BOOL
  .quad 0 # bool zero value
.global runtime.main_main
runtime.main_main: # T T_FUNC
  .quad 0
.global runtime.p0
runtime.p0: # T T_STRUCT
  .byte 0 # struct zero value
  .byte 0 # struct zero value
  .byte 0 # struct zero value
  .byte 0 # struct zero value
  .byte 0 # struct zero value
  .byte 0 # struct zero value
  .byte 0 # struct zero value
  .byte 0 # struct zero value
.global runtime.futexp
runtime.futexp: # T T_UINTPTR
  .quad 0
.global runtime.envp
runtime.envp: # T T_UINTPTR
  .quad 0
.global runtime.envlines
runtime.envlines: # T T_SLICE
  .quad 0 # ptr
  .quad 0 # len
  .quad 0 # cap
.global runtime.Envs
runtime.Envs: # T T_SLICE
  .quad 0 # ptr
  .quad 0 # len
  .quad 0 # cap

#--- global vars (dynamic value setting)
.text
.global runtime.__initGlobals
runtime.__initGlobals:
  ret

# Method runtime.$item.valueAddr
.global runtime.$item.valueAddr
runtime.$item.valueAddr: # args 32, locals 0
  pushq %rbp
  movq %rsp, %rbp
  leaq 24(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  leaq 16(%rbp), %rax # local variable "i"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax
  addq $24, %rax
  pushq %rax
  popq %rax # address of T_UINTPTR
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leave
  ret
  leave
  ret

# Method runtime.$item.match
.global runtime.$item.match
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
  leaq .dtype.1(%rip), %rax # dtype label address "string"
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
  leaq .dtype.2(%rip), %rax # dtype label address "unsafe.Pointer"
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
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax
  addq $8, %rax
  pushq %rax
  popq %rax # address of T_INTERFACE
  movq 8(%rax), %rdx # data
  movq 0(%rax), %rax # dtype
  pushq %rdx # data
  pushq %rax # dtype
  leaq .dtype.1(%rip), %rax # dtype label address "string"
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
  movq %rax, 0(%rsi) # assign quad
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
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq 40(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  leaq 16(%rbp), %rax # local variable "i"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax
  addq $8, %rax
  pushq %rax
  popq %rax # address of T_INTERFACE
  movq 8(%rax), %rdx # data
  movq 0(%rax), %rax # dtype
  pushq %rdx # data
  pushq %rax # dtype
  leaq .dtype.2(%rip), %rax # dtype label address "unsafe.Pointer"
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
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  jmp .L.end_type_assertion.10
  .L.unmatch.10:
  popq %rax # drop ifc.data
  pushq $0 # T_POINTER zero value (nil pointer)
  .L.end_type_assertion.10:
  leaq -40(%rbp), %rax # local variable "k"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
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
  movq %rax, 0(%rsi) # assign quad
  leave
  ret
  jmp .L.typeswitch.1.exit
  .L.case.6:
  subq $16, %rsp # alloc parameters area
  pushq $22 # str len
  leaq .string_0(%rip), %rax # str ptr
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
  leaq .dtype.1(%rip), %rax # dtype label address "string"
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
  leaq 40(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  pushq $0 # false
  popq %rax # result of T_BOOL
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leave
  ret
  leave
  ret

# Function runtime.makeMap
.global runtime.makeMap
runtime.makeMap: # args 40, locals -16
  pushq %rbp
  movq %rsp, %rbp
  subq $16, %rsp # local area
  leaq -8(%rbp), %rax # local variable "mp"
  pushq %rax # variable address
  subq $8, %rsp # alloc return vars area
  pushq $24
  callq runtime.malloc
  addq $8, %rsp # free parameters area
  #  totalReturnSize=8
  movq 0(%rsp), %rax # copy stack top value (address of struct heaad) 
  pushq %rax
  popq %rax
  addq $16, %rax
  pushq %rax
  leaq 24(%rbp), %rax # local variable "valueSize"
  pushq %rax # variable address
  popq %rax # address of T_UINTPTR
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_UINTPTR
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq -16(%rbp), %rax # local variable "addr"
  pushq %rax # variable address
  leaq -8(%rbp), %rax # local variable "mp"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_UINTPTR
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq 32(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  leaq -16(%rbp), %rax # local variable "addr"
  pushq %rax # variable address
  popq %rax # address of T_UINTPTR
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_UINTPTR
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leave
  ret
  leave
  ret

# Function runtime.lenMap
.global runtime.lenMap
runtime.lenMap: # args 32, locals 0
  pushq %rbp
  movq %rsp, %rbp
  leaq 24(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  leaq 16(%rbp), %rax # local variable "mp"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax
  addq $8, %rax
  pushq %rax
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leave
  ret
  leave
  ret

# Function runtime.deleteFromMap
.global runtime.deleteFromMap
runtime.deleteFromMap: # args 40, locals -16
  pushq %rbp
  movq %rsp, %rbp
  subq $16, %rsp # local area
  leaq 16(%rbp), %rax # local variable "mp"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax
  addq $0, %rax
  pushq %rax
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  pushq $0 # T_POINTER zero value (nil pointer)
  popq %rcx # right
  popq %rax # left
  cmpq %rcx, %rax
  sete %al
  movzbq %al, %rax
  pushq %rax
  popq %rax # result of if condition
  cmpq $1, %rax
  jne .L.endif.11 # jmp if false
  leave
  ret
  .L.endif.11:
  subq $8, %rsp # alloc return vars area
  subq $24, %rsp # alloc parameters area
  leaq 16(%rbp), %rax # local variable "mp"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax
  addq $0, %rax
  pushq %rax
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_POINTER
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq 24(%rbp), %rax # local variable "key"
  pushq %rax # variable address
  popq %rax # address of T_INTERFACE
  movq 8(%rax), %rdx # data
  movq 0(%rax), %rax # dtype
  pushq %rdx # data
  pushq %rax # dtype
  popq %rax # eface.dtype
  popq %rcx # eface.data
  leaq 8(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # store dtype
  movq %rcx, 8(%rsi) # store data
  callq runtime.$item.match
  addq $24, %rsp # free parameters area
  #  totalReturnSize=8
  popq %rax # result of if condition
  cmpq $1, %rax
  jne .L.endif.12 # jmp if false
  leaq 16(%rbp), %rax # local variable "mp"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax
  addq $0, %rax
  pushq %rax
  leaq 16(%rbp), %rax # local variable "mp"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax
  addq $0, %rax
  pushq %rax
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax
  addq $0, %rax
  pushq %rax
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq 16(%rbp), %rax # local variable "mp"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax
  addq $8, %rax
  pushq %rax
  leaq 16(%rbp), %rax # local variable "mp"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax
  addq $8, %rax
  pushq %rax
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  pushq $1 # number literal
  popq %rcx # right
  popq %rax # left
  subq %rcx, %rax
  pushq %rax
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leave
  ret
  .L.endif.12:
  leaq -8(%rbp), %rax # local variable "prev"
  pushq %rax # variable address
  pushq $0 # T_POINTER zero value (nil pointer)
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq -16(%rbp), %rax # local variable "itm"
  pushq %rax # variable address
  leaq 16(%rbp), %rax # local variable "mp"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax
  addq $0, %rax
  pushq %rax
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  .L.for.cond.13:
  leaq -16(%rbp), %rax # local variable "itm"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  pushq $0 # T_POINTER zero value (nil pointer)
  popq %rcx # right
  popq %rax # left
  cmpq %rcx, %rax
  sete %al
  movzbq %al, %rax
  pushq %rax
  popq %rax # result of 
  xor $1, %rax
  pushq %rax
  popq %rax # result of for condition
  cmpq $1, %rax
  jne .L.for.exit.13 # jmp if false
  subq $8, %rsp # alloc return vars area
  subq $24, %rsp # alloc parameters area
  leaq -16(%rbp), %rax # local variable "itm"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_POINTER
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq 24(%rbp), %rax # local variable "key"
  pushq %rax # variable address
  popq %rax # address of T_INTERFACE
  movq 8(%rax), %rdx # data
  movq 0(%rax), %rax # dtype
  pushq %rdx # data
  pushq %rax # dtype
  popq %rax # eface.dtype
  popq %rcx # eface.data
  leaq 8(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # store dtype
  movq %rcx, 8(%rsi) # store data
  callq runtime.$item.match
  addq $24, %rsp # free parameters area
  #  totalReturnSize=8
  popq %rax # result of if condition
  cmpq $1, %rax
  jne .L.endif.14 # jmp if false
  leaq -8(%rbp), %rax # local variable "prev"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax
  addq $0, %rax
  pushq %rax
  leaq -16(%rbp), %rax # local variable "itm"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax
  addq $0, %rax
  pushq %rax
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq 16(%rbp), %rax # local variable "mp"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax
  addq $8, %rax
  pushq %rax
  leaq 16(%rbp), %rax # local variable "mp"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax
  addq $8, %rax
  pushq %rax
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  pushq $1 # number literal
  popq %rcx # right
  popq %rax # left
  subq %rcx, %rax
  pushq %rax
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leave
  ret
  .L.endif.14:
  leaq -8(%rbp), %rax # local variable "prev"
  pushq %rax # variable address
  leaq -16(%rbp), %rax # local variable "itm"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  .L.for.post.13:
  leaq -16(%rbp), %rax # local variable "itm"
  pushq %rax # variable address
  leaq -16(%rbp), %rax # local variable "itm"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax
  addq $0, %rax
  pushq %rax
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  jmp .L.for.cond.13
  .L.for.exit.13:
  leave
  ret

# Function runtime.getAddrForMapSet
.global runtime.getAddrForMapSet
runtime.getAddrForMapSet: # args 48, locals -24
  pushq %rbp
  movq %rsp, %rbp
  subq $24, %rsp # local area
  leaq -8(%rbp), %rax # local variable "last"
  pushq %rax # variable address
  pushq $0 # T_POINTER zero value (nil pointer)
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq -16(%rbp), %rax # local variable "item"
  pushq %rax # variable address
  leaq 16(%rbp), %rax # local variable "mp"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax
  addq $0, %rax
  pushq %rax
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  .L.for.cond.15:
  leaq -16(%rbp), %rax # local variable "item"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  pushq $0 # T_POINTER zero value (nil pointer)
  popq %rcx # right
  popq %rax # left
  cmpq %rcx, %rax
  sete %al
  movzbq %al, %rax
  pushq %rax
  popq %rax # result of 
  xor $1, %rax
  pushq %rax
  popq %rax # result of for condition
  cmpq $1, %rax
  jne .L.for.exit.15 # jmp if false
  subq $8, %rsp # alloc return vars area
  subq $24, %rsp # alloc parameters area
  leaq -16(%rbp), %rax # local variable "item"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_POINTER
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq 24(%rbp), %rax # local variable "key"
  pushq %rax # variable address
  popq %rax # address of T_INTERFACE
  movq 8(%rax), %rdx # data
  movq 0(%rax), %rax # dtype
  pushq %rdx # data
  pushq %rax # dtype
  popq %rax # eface.dtype
  popq %rcx # eface.data
  leaq 8(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # store dtype
  movq %rcx, 8(%rsi) # store data
  callq runtime.$item.match
  addq $24, %rsp # free parameters area
  #  totalReturnSize=8
  popq %rax # result of if condition
  cmpq $1, %rax
  jne .L.endif.16 # jmp if false
  leaq 40(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  subq $8, %rsp # alloc return vars area
  subq $8, %rsp # alloc parameters area
  leaq -16(%rbp), %rax # local variable "item"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_POINTER
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  callq runtime.$item.valueAddr
  addq $8, %rsp # free parameters area
  #  totalReturnSize=8
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leave
  ret
  .L.endif.16:
  leaq -8(%rbp), %rax # local variable "last"
  pushq %rax # variable address
  leaq -16(%rbp), %rax # local variable "item"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  .L.for.post.15:
  leaq -16(%rbp), %rax # local variable "item"
  pushq %rax # variable address
  leaq -16(%rbp), %rax # local variable "item"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax
  addq $0, %rax
  pushq %rax
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  jmp .L.for.cond.15
  .L.for.exit.15:
  leaq -24(%rbp), %rax # local variable "newItem"
  pushq %rax # variable address
  subq $8, %rsp # alloc return vars area
  pushq $32
  callq runtime.malloc
  addq $8, %rsp # free parameters area
  #  totalReturnSize=8
  movq 0(%rsp), %rax # copy stack top value (address of struct heaad) 
  pushq %rax
  popq %rax
  addq $8, %rax
  pushq %rax
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
  movq 0(%rsp), %rax # copy stack top value (address of struct heaad) 
  pushq %rax
  popq %rax
  addq $24, %rax
  pushq %rax
  subq $8, %rsp # alloc return vars area
  subq $8, %rsp # alloc parameters area
  leaq 16(%rbp), %rax # local variable "mp"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax
  addq $16, %rax
  pushq %rax
  popq %rax # address of T_UINTPTR
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_UINTPTR
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  callq runtime.malloc
  addq $8, %rsp # free parameters area
  #  totalReturnSize=8
  popq %rax # result of T_UINTPTR
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq 16(%rbp), %rax # local variable "mp"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax
  addq $0, %rax
  pushq %rax
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  pushq $0 # T_POINTER zero value (nil pointer)
  popq %rcx # right
  popq %rax # left
  cmpq %rcx, %rax
  sete %al
  movzbq %al, %rax
  pushq %rax
  popq %rax # result of if condition
  cmpq $1, %rax
  jne .L.else.17 # jmp if false
  leaq 16(%rbp), %rax # local variable "mp"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax
  addq $0, %rax
  pushq %rax
  leaq -24(%rbp), %rax # local variable "newItem"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  jmp .L.endif.17
  .L.else.17:
  leaq -8(%rbp), %rax # local variable "last"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax
  addq $0, %rax
  pushq %rax
  leaq -24(%rbp), %rax # local variable "newItem"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  .L.endif.17:
  leaq 16(%rbp), %rax # local variable "mp"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax
  addq $8, %rax
  pushq %rax
  leaq 16(%rbp), %rax # local variable "mp"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax
  addq $8, %rax
  pushq %rax
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  pushq $1 # number literal
  popq %rcx # right
  popq %rax # left
  addq %rcx, %rax
  pushq %rax
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq 40(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  subq $8, %rsp # alloc return vars area
  subq $8, %rsp # alloc parameters area
  leaq -24(%rbp), %rax # local variable "newItem"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_POINTER
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  callq runtime.$item.valueAddr
  addq $8, %rsp # free parameters area
  #  totalReturnSize=8
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leave
  ret
  leave
  ret

# Function runtime.getAddrForMapGet
.global runtime.getAddrForMapGet
runtime.getAddrForMapGet: # args 56, locals -8
  pushq %rbp
  movq %rsp, %rbp
  subq $8, %rsp # local area
  leaq -8(%rbp), %rax # local variable "item"
  pushq %rax # variable address
  leaq 16(%rbp), %rax # local variable "mp"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax
  addq $0, %rax
  pushq %rax
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  .L.for.cond.18:
  leaq -8(%rbp), %rax # local variable "item"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  pushq $0 # T_POINTER zero value (nil pointer)
  popq %rcx # right
  popq %rax # left
  cmpq %rcx, %rax
  sete %al
  movzbq %al, %rax
  pushq %rax
  popq %rax # result of 
  xor $1, %rax
  pushq %rax
  popq %rax # result of for condition
  cmpq $1, %rax
  jne .L.for.exit.18 # jmp if false
  subq $8, %rsp # alloc return vars area
  subq $24, %rsp # alloc parameters area
  leaq -8(%rbp), %rax # local variable "item"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_POINTER
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq 24(%rbp), %rax # local variable "key"
  pushq %rax # variable address
  popq %rax # address of T_INTERFACE
  movq 8(%rax), %rdx # data
  movq 0(%rax), %rax # dtype
  pushq %rdx # data
  pushq %rax # dtype
  popq %rax # eface.dtype
  popq %rcx # eface.data
  leaq 8(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # store dtype
  movq %rcx, 8(%rsi) # store data
  callq runtime.$item.match
  addq $24, %rsp # free parameters area
  #  totalReturnSize=8
  popq %rax # result of if condition
  cmpq $1, %rax
  jne .L.endif.19 # jmp if false
  leaq 40(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  pushq $1 # true
  popq %rax # result of T_BOOL
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq 48(%rbp), %rax # local variable ".r1"
  pushq %rax # variable address
  subq $8, %rsp # alloc return vars area
  subq $8, %rsp # alloc parameters area
  leaq -8(%rbp), %rax # local variable "item"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_POINTER
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  callq runtime.$item.valueAddr
  addq $8, %rsp # free parameters area
  #  totalReturnSize=8
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leave
  ret
  .L.endif.19:
  .L.for.post.18:
  leaq -8(%rbp), %rax # local variable "item"
  pushq %rax # variable address
  leaq -8(%rbp), %rax # local variable "item"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax
  addq $0, %rax
  pushq %rax
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  jmp .L.for.cond.18
  .L.for.exit.18:
  leaq 40(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  pushq $0 # false
  popq %rax # result of T_BOOL
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq 48(%rbp), %rax # local variable ".r1"
  pushq %rax # variable address
  pushq $0 # T_POINTER zero value (nil pointer)
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leave
  ret
  leave
  ret

# Function runtime.deleteMap
.global runtime.deleteMap
runtime.deleteMap: # args 40, locals -16
  pushq %rbp
  movq %rsp, %rbp
  subq $16, %rsp # local area
  leaq 16(%rbp), %rax # local variable "mp"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax
  addq $0, %rax
  pushq %rax
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  pushq $0 # T_POINTER zero value (nil pointer)
  popq %rcx # right
  popq %rax # left
  cmpq %rcx, %rax
  sete %al
  movzbq %al, %rax
  pushq %rax
  popq %rax # result of if condition
  cmpq $1, %rax
  jne .L.endif.20 # jmp if false
  leave
  ret
  .L.endif.20:
  subq $8, %rsp # alloc return vars area
  subq $24, %rsp # alloc parameters area
  leaq 16(%rbp), %rax # local variable "mp"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax
  addq $0, %rax
  pushq %rax
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_POINTER
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq 24(%rbp), %rax # local variable "key"
  pushq %rax # variable address
  popq %rax # address of T_INTERFACE
  movq 8(%rax), %rdx # data
  movq 0(%rax), %rax # dtype
  pushq %rdx # data
  pushq %rax # dtype
  popq %rax # eface.dtype
  popq %rcx # eface.data
  leaq 8(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # store dtype
  movq %rcx, 8(%rsi) # store data
  callq runtime.$item.match
  addq $24, %rsp # free parameters area
  #  totalReturnSize=8
  popq %rax # result of if condition
  cmpq $1, %rax
  jne .L.endif.21 # jmp if false
  leaq 16(%rbp), %rax # local variable "mp"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax
  addq $0, %rax
  pushq %rax
  leaq 16(%rbp), %rax # local variable "mp"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax
  addq $0, %rax
  pushq %rax
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax
  addq $0, %rax
  pushq %rax
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq 16(%rbp), %rax # local variable "mp"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax
  addq $8, %rax
  pushq %rax
  leaq 16(%rbp), %rax # local variable "mp"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax
  addq $8, %rax
  pushq %rax
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  pushq $1 # number literal
  popq %rcx # right
  popq %rax # left
  subq %rcx, %rax
  pushq %rax
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leave
  ret
  .L.endif.21:
  leaq -8(%rbp), %rax # local variable "prev"
  pushq %rax # variable address
  pushq $0 # T_POINTER zero value (nil pointer)
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq -16(%rbp), %rax # local variable "item"
  pushq %rax # variable address
  leaq 16(%rbp), %rax # local variable "mp"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax
  addq $0, %rax
  pushq %rax
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  .L.for.cond.22:
  leaq -16(%rbp), %rax # local variable "item"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  pushq $0 # T_POINTER zero value (nil pointer)
  popq %rcx # right
  popq %rax # left
  cmpq %rcx, %rax
  sete %al
  movzbq %al, %rax
  pushq %rax
  popq %rax # result of 
  xor $1, %rax
  pushq %rax
  popq %rax # result of for condition
  cmpq $1, %rax
  jne .L.for.exit.22 # jmp if false
  subq $8, %rsp # alloc return vars area
  subq $24, %rsp # alloc parameters area
  leaq -16(%rbp), %rax # local variable "item"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_POINTER
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq 24(%rbp), %rax # local variable "key"
  pushq %rax # variable address
  popq %rax # address of T_INTERFACE
  movq 8(%rax), %rdx # data
  movq 0(%rax), %rax # dtype
  pushq %rdx # data
  pushq %rax # dtype
  popq %rax # eface.dtype
  popq %rcx # eface.data
  leaq 8(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # store dtype
  movq %rcx, 8(%rsi) # store data
  callq runtime.$item.match
  addq $24, %rsp # free parameters area
  #  totalReturnSize=8
  popq %rax # result of if condition
  cmpq $1, %rax
  jne .L.endif.23 # jmp if false
  leaq -8(%rbp), %rax # local variable "prev"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax
  addq $0, %rax
  pushq %rax
  leaq -16(%rbp), %rax # local variable "item"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax
  addq $0, %rax
  pushq %rax
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq 16(%rbp), %rax # local variable "mp"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax
  addq $8, %rax
  pushq %rax
  leaq 16(%rbp), %rax # local variable "mp"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax
  addq $8, %rax
  pushq %rax
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  pushq $1 # number literal
  popq %rcx # right
  popq %rax # left
  subq %rcx, %rax
  pushq %rax
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leave
  ret
  .L.endif.23:
  leaq -8(%rbp), %rax # local variable "prev"
  pushq %rax # variable address
  leaq -16(%rbp), %rax # local variable "item"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  .L.for.post.22:
  leaq -16(%rbp), %rax # local variable "item"
  pushq %rax # variable address
  leaq -16(%rbp), %rax # local variable "item"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax
  addq $0, %rax
  pushq %rax
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  jmp .L.for.cond.22
  .L.for.exit.22:
  leave
  ret

# Function runtime.argv_index
.global runtime.argv_index
runtime.argv_index: # args 40, locals 0
  pushq %rbp
  movq %rsp, %rbp
  leaq 32(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  leaq 16(%rbp), %rax # local variable "argv"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  leaq 24(%rbp), %rax # local variable "i"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  pushq $8 # number literal
  popq %rcx # right
  popq %rax # left
  imulq %rcx, %rax
  pushq %rax
  popq %rcx # right
  popq %rax # left
  addq %rcx, %rax
  pushq %rax
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leave
  ret
  leave
  ret

# Function runtime.args
.global runtime.args
runtime.args: # args 32, locals 0
  pushq %rbp
  movq %rsp, %rbp
  leaq runtime.argc(%rip), %rax # global variable "argc"
  pushq %rax # variable address
  leaq 16(%rbp), %rax # local variable "c"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq runtime.argv(%rip), %rax # global variable "argv"
  pushq %rax # variable address
  leaq 24(%rbp), %rax # local variable "v"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leave
  ret

# Function runtime.goargs
.global runtime.goargs
runtime.goargs: # args 16, locals -8
  pushq %rbp
  movq %rsp, %rbp
  subq $8, %rsp # local area
  leaq runtime.argslice(%rip), %rax # global variable "argslice"
  pushq %rax # variable address
  subq $24, %rsp # alloc return vars area
  subq $24, %rsp # alloc parameters area
  pushq $16 # number literal
  popq %rax # result of T_INT
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq runtime.argc(%rip), %rax # global variable "argc"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rax # result of T_INT
  leaq 8(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq runtime.argc(%rip), %rax # global variable "argc"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rax # result of T_INT
  leaq 16(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  callq runtime.makeSlice
  addq $24, %rsp # free parameters area
  #  totalReturnSize=24
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  movq %rdx, 16(%rsi) # cap to cap
  leaq -8(%rbp), %rax # local variable "i"
  pushq %rax # variable address
  pushq $0 # number literal
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  .L.for.cond.24:
  leaq -8(%rbp), %rax # local variable "i"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  leaq runtime.argc(%rip), %rax # global variable "argc"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rcx # right
  popq %rax # left
  cmpq %rcx, %rax
  setl %al
  movzbq %al, %rax
  pushq %rax
  popq %rax # result of for condition
  cmpq $1, %rax
  jne .L.for.exit.24 # jmp if false
  leaq -8(%rbp), %rax # local variable "i"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  leaq runtime.argslice(%rip), %rax # global variable "argslice"
  pushq %rax # variable address
  popq %rax # address of T_SLICE
  movq 16(%rax), %rdx
  movq 8(%rax), %rcx
  movq 0(%rax), %rax
  pushq %rdx # cap
  pushq %rcx # len
  pushq %rax # ptr
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  pushq %rax # slice.ptr
  popq %rax # address of list head
  popq %rcx # index id
  movq $16, %rdx # elm size
  imulq %rdx, %rcx
  addq %rcx, %rax
  pushq %rax # addr of element
  subq $16, %rsp # alloc return vars area
  subq $8, %rsp # alloc parameters area
  subq $8, %rsp # alloc return vars area
  subq $16, %rsp # alloc parameters area
  leaq runtime.argv(%rip), %rax # global variable "argv"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_POINTER
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq -8(%rbp), %rax # local variable "i"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rax # result of T_INT
  leaq 8(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  callq runtime.argv_index
  addq $16, %rsp # free parameters area
  #  totalReturnSize=8
  popq %rax # result of T_POINTER
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  callq runtime.cstring2string
  addq $8, %rsp # free parameters area
  #  totalReturnSize=16
  popq %rax # string.ptr
  popq %rcx # string.len
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  .L.for.post.24:
  leaq -8(%rbp), %rax # local variable "i"
  pushq %rax # variable address
  leaq -8(%rbp), %rax # local variable "i"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rax
  addq $1, %rax
  pushq %rax
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  jmp .L.for.cond.24
  .L.for.exit.24:
  leave
  ret

# Function runtime.schedinit
.global runtime.schedinit
runtime.schedinit: # args 16, locals 0
  pushq %rbp
  movq %rsp, %rbp
  subq $0, %rsp # alloc parameters area
  callq runtime.heapInit
  #  totalReturnSize=0
  leaq runtime.futexp(%rip), %rax # global variable "futexp"
  pushq %rax # variable address
  subq $8, %rsp # alloc return vars area
  subq $8, %rsp # alloc parameters area
  pushq $4 # number literal
  popq %rax # result of T_UINTPTR
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  callq runtime.malloc
  addq $8, %rsp # free parameters area
  #  totalReturnSize=8
  popq %rax # result of T_UINTPTR
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  subq $0, %rsp # alloc parameters area
  callq runtime.goargs
  #  totalReturnSize=0
  subq $0, %rsp # alloc parameters area
  callq runtime.envInit
  #  totalReturnSize=0
  leave
  ret

# Function runtime.main
.global runtime.main
runtime.main: # args 16, locals -8
  pushq %rbp
  movq %rsp, %rbp
  subq $8, %rsp # local area
  leaq runtime.mainStarted(%rip), %rax # global variable "mainStarted"
  pushq %rax # variable address
  pushq $1 # true
  popq %rax # result of T_BOOL
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -8(%rbp), %rax # local variable "fn"
  pushq %rax # variable address
  leaq runtime.main_main(%rip), %rax # global variable "main_main"
  pushq %rax # variable address
  popq %rax # address of T_FUNC
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_FUNC
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  subq $0, %rsp # alloc parameters area
  leaq -8(%rbp), %rax # local variable "fn"
  pushq %rax # variable address
  popq %rax # address of T_FUNC
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax
  callq *%rax
  #  totalReturnSize=0
  subq $8, %rsp # alloc parameters area
  pushq $0 # number literal
  popq %rax # result of T_INT
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  callq runtime.exit
  addq $8, %rsp # free parameters area
  #  totalReturnSize=0
  leave
  ret

# Function runtime.newproc
.global runtime.newproc
runtime.newproc: # args 32, locals 0
  pushq %rbp
  movq %rsp, %rbp
  leaq runtime.p0(%rip), %rax # global variable "p0"
  pushq %rax # variable address
  popq %rax
  addq $0, %rax
  pushq %rax
  leaq 24(%rbp), %rax # local variable "fn"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # address of T_FUNC
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_FUNC
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leave
  ret

# Function runtime.futexsleep
.global runtime.futexsleep
runtime.futexsleep: # args 32, locals 0
  pushq %rbp
  movq %rsp, %rbp
  subq $24, %rsp # alloc parameters area
  leaq 16(%rbp), %rax # local variable "addr"
  pushq %rax # variable address
  popq %rax # address of T_UINTPTR
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_POINTER
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  pushq $0 # number literal
  pushq $128 # number literal
  popq %rcx # right
  popq %rax # left
  orq %rcx, %rax # bitwise or
  pushq %rax
  popq %rax # result of T_INT
  leaq 8(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq 24(%rbp), %rax # local variable "val"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rax # result of T_INT
  leaq 16(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  callq runtime.futex
  addq $24, %rsp # free parameters area
  #  totalReturnSize=0
  leave
  ret

# Function runtime.mstart1
.global runtime.mstart1
runtime.mstart1: # args 16, locals 0
  pushq %rbp
  movq %rsp, %rbp
  subq $8, %rsp # alloc return vars area
  subq $32, %rsp # alloc parameters area
  pushq $2 # number literal
  popq %rax # result of T_INT
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  pushq $39 # str len
  leaq .string_1(%rip), %rax # str ptr
  pushq %rax # str ptr
  popq %rax # string.ptr
  popq %rcx # string.len
  pushq %rcx # cap
  pushq %rcx # len
  pushq %rax # ptr
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  leaq 8(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  movq %rdx, 16(%rsi) # cap to cap
  callq runtime.Write
  addq $32, %rsp # free parameters area
  #  totalReturnSize=8
  subq $16, %rsp # alloc parameters area
  leaq runtime.futexp(%rip), %rax # global variable "futexp"
  pushq %rax # variable address
  popq %rax # address of T_UINTPTR
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_UINTPTR
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  pushq $0 # number literal
  popq %rax # result of T_INT
  leaq 8(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  callq runtime.futexsleep
  addq $16, %rsp # free parameters area
  #  totalReturnSize=0
  subq $0, %rsp # alloc parameters area
  callq runtime.exitThread
  #  totalReturnSize=0
  leave
  ret

# Function runtime.newosproc
.global runtime.newosproc
runtime.newosproc: # args 16, locals -32
  pushq %rbp
  movq %rsp, %rbp
  subq $32, %rsp # local area
  leaq -8(%rbp), %rax # local variable "cloneFlags"
  pushq %rax # variable address
  pushq $256 # number literal
  pushq $512 # number literal
  popq %rcx # right
  popq %rax # left
  orq %rcx, %rax # bitwise or
  pushq %rax
  pushq $1024 # number literal
  popq %rcx # right
  popq %rax # left
  orq %rcx, %rax # bitwise or
  pushq %rax
  pushq $2048 # number literal
  popq %rcx # right
  popq %rax # left
  orq %rcx, %rax # bitwise or
  pushq %rax
  pushq $65536 # number literal
  popq %rcx # right
  popq %rax # left
  orq %rcx, %rax # bitwise or
  pushq %rax
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -16(%rbp), %rax # local variable "fn"
  pushq %rax # variable address
  leaq runtime.mstart1(%rip), %rax # func addr
  pushq %rax # func addr
  popq %rax # result of T_FUNC
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq -24(%rbp), %rax # local variable "stackSize"
  pushq %rax # variable address
  pushq $1024 # number literal
  popq %rax # result of T_UINTPTR
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq -32(%rbp), %rax # local variable "stack"
  pushq %rax # variable address
  subq $8, %rsp # alloc return vars area
  subq $8, %rsp # alloc parameters area
  leaq -24(%rbp), %rax # local variable "stackSize"
  pushq %rax # variable address
  popq %rax # address of T_UINTPTR
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  pushq $8 # number literal
  popq %rcx # right
  popq %rax # left
  addq %rcx, %rax
  pushq %rax
  popq %rax # result of T_UINTPTR
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  callq runtime.malloc
  addq $8, %rsp # free parameters area
  #  totalReturnSize=8
  popq %rax # result of T_UINTPTR
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  subq $24, %rsp # alloc parameters area
  leaq -8(%rbp), %rax # local variable "cloneFlags"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rax # result of T_INT
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -32(%rbp), %rax # local variable "stack"
  pushq %rax # variable address
  popq %rax # address of T_UINTPTR
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  leaq -24(%rbp), %rax # local variable "stackSize"
  pushq %rax # variable address
  popq %rax # address of T_UINTPTR
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rcx # right
  popq %rax # left
  addq %rcx, %rax
  pushq %rax
  popq %rax # result of T_UINTPTR
  leaq 8(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq -16(%rbp), %rax # local variable "fn"
  pushq %rax # variable address
  popq %rax # address of T_FUNC
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_FUNC
  leaq 16(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  callq runtime.clone
  addq $24, %rsp # free parameters area
  #  totalReturnSize=0
  leave
  ret

# Function runtime.mstart0
.global runtime.mstart0
runtime.mstart0: # args 16, locals -8
  pushq %rbp
  movq %rsp, %rbp
  subq $8, %rsp # local area
  leaq -8(%rbp), %rax # local variable "g"
  pushq %rax # variable address
  leaq runtime.p0(%rip), %rax # global variable "p0"
  pushq %rax # variable address
  popq %rax
  addq $0, %rax
  pushq %rax
  popq %rax # address of T_FUNC
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_FUNC
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  subq $0, %rsp # alloc parameters area
  leaq -8(%rbp), %rax # local variable "g"
  pushq %rax # variable address
  popq %rax # address of T_FUNC
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax
  callq *%rax
  #  totalReturnSize=0
  leave
  ret

# Function runtime.heapInit
.global runtime.heapInit
runtime.heapInit: # args 16, locals 0
  pushq %rbp
  movq %rsp, %rbp
  leaq runtime.heapHead(%rip), %rax # global variable "heapHead"
  pushq %rax # variable address
  subq $8, %rsp # alloc return vars area
  subq $8, %rsp # alloc parameters area
  pushq $0 # number literal
  popq %rax # result of T_UINTPTR
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  callq runtime.brk
  addq $8, %rsp # free parameters area
  #  totalReturnSize=8
  popq %rax # result of T_UINTPTR
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq runtime.heapTail(%rip), %rax # global variable "heapTail"
  pushq %rax # variable address
  subq $8, %rsp # alloc return vars area
  subq $8, %rsp # alloc parameters area
  leaq runtime.heapHead(%rip), %rax # global variable "heapHead"
  pushq %rax # variable address
  popq %rax # address of T_UINTPTR
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  pushq $620205360 # number literal
  popq %rcx # right
  popq %rax # left
  addq %rcx, %rax
  pushq %rax
  popq %rax # result of T_UINTPTR
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  callq runtime.brk
  addq $8, %rsp # free parameters area
  #  totalReturnSize=8
  popq %rax # result of T_UINTPTR
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq runtime.heapHead(%rip), %rax # global variable "heapHead"
  pushq %rax # variable address
  popq %rax # address of T_UINTPTR
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  pushq $8 # number literal
  popq %rcx # right
  popq %rax # left
  movq $0, %rdx # init %rdx
  divq %rcx
  movq %rdx, %rax
  pushq %rax
  pushq $0 # number literal
  popq %rcx # right
  popq %rax # left
  cmpq %rcx, %rax
  sete %al
  movzbq %al, %rax
  pushq %rax
  popq %rax # result of if condition
  cmpq $1, %rax
  jne .L.else.25 # jmp if false
  leaq runtime.heapCurrent(%rip), %rax # global variable "heapCurrent"
  pushq %rax # variable address
  leaq runtime.heapHead(%rip), %rax # global variable "heapHead"
  pushq %rax # variable address
  popq %rax # address of T_UINTPTR
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_UINTPTR
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  jmp .L.endif.25
  .L.else.25:
  leaq runtime.heapCurrent(%rip), %rax # global variable "heapCurrent"
  pushq %rax # variable address
  leaq runtime.heapHead(%rip), %rax # global variable "heapHead"
  pushq %rax # variable address
  popq %rax # address of T_UINTPTR
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  pushq $8 # number literal
  leaq runtime.heapHead(%rip), %rax # global variable "heapHead"
  pushq %rax # variable address
  popq %rax # address of T_UINTPTR
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  pushq $8 # number literal
  popq %rcx # right
  popq %rax # left
  movq $0, %rdx # init %rdx
  divq %rcx
  movq %rdx, %rax
  pushq %rax
  popq %rcx # right
  popq %rax # left
  subq %rcx, %rax
  pushq %rax
  popq %rcx # right
  popq %rax # left
  addq %rcx, %rax
  pushq %rax
  popq %rax # result of T_UINTPTR
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  .L.endif.25:
  leave
  ret

# Function runtime.envInit
.global runtime.envInit
runtime.envInit: # args 16, locals -121
  pushq %rbp
  movq %rsp, %rbp
  subq $121, %rsp # local area
  leaq -8(%rbp), %rax # local variable "p"
  pushq %rax # variable address
  pushq $0 # T_UINTPTR zero value (nil pointer)
  popq %rax # result of T_UINTPTR
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq -8(%rbp), %rax # local variable "p"
  pushq %rax # variable address
  leaq runtime.envp(%rip), %rax # global variable "envp"
  pushq %rax # variable address
  popq %rax # address of T_UINTPTR
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_UINTPTR
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  .L.for.cond.26:
  pushq $1 # true
  popq %rax # result of for condition
  cmpq $1, %rax
  jne .L.for.exit.26 # jmp if false
  leaq -16(%rbp), %rax # local variable "bpp"
  pushq %rax # variable address
  leaq -8(%rbp), %rax # local variable "p"
  pushq %rax # variable address
  popq %rax # address of T_UINTPTR
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq -16(%rbp), %rax # local variable "bpp"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  pushq $0 # T_POINTER zero value (nil pointer)
  popq %rcx # right
  popq %rax # left
  cmpq %rcx, %rax
  sete %al
  movzbq %al, %rax
  pushq %rax
  popq %rax # result of if condition
  cmpq $1, %rax
  jne .L.endif.27 # jmp if false
  jmp .L.for.exit.26 # break
  .L.endif.27:
  leaq runtime.envlines(%rip), %rax # global variable "envlines"
  pushq %rax # variable address
  subq $24, %rsp # alloc return vars area
  subq $40, %rsp # alloc parameters area
  leaq runtime.envlines(%rip), %rax # global variable "envlines"
  pushq %rax # variable address
  popq %rax # address of T_SLICE
  movq 16(%rax), %rdx
  movq 8(%rax), %rcx
  movq 0(%rax), %rax
  pushq %rdx # cap
  pushq %rcx # len
  pushq %rax # ptr
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  movq %rdx, 16(%rsi) # cap to cap
  subq $16, %rsp # alloc return vars area
  subq $8, %rsp # alloc parameters area
  leaq -16(%rbp), %rax # local variable "bpp"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_POINTER
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  callq runtime.cstring2string
  addq $8, %rsp # free parameters area
  #  totalReturnSize=16
  popq %rax # string.ptr
  popq %rcx # string.len
  leaq 24(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  callq runtime.append16
  addq $40, %rsp # free parameters area
  #  totalReturnSize=24
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  movq %rdx, 16(%rsi) # cap to cap
  .L.for.post.26:
  leaq -8(%rbp), %rax # local variable "p"
  pushq %rax # variable address
  leaq -8(%rbp), %rax # local variable "p"
  pushq %rax # variable address
  popq %rax # address of T_UINTPTR
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  pushq $8 # number literal
  popq %rcx # right
  popq %rax # left
  addq %rcx, %rax
  pushq %rax
  popq %rax # result of T_UINTPTR
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  jmp .L.for.cond.26
  .L.for.exit.26:
  leaq -89(%rbp), %rax # local variable ".range.len"
  pushq %rax # variable address
  leaq runtime.envlines(%rip), %rax # global variable "envlines"
  pushq %rax # variable address
  popq %rax # address of T_SLICE
  movq 16(%rax), %rdx
  movq 8(%rax), %rcx
  movq 0(%rax), %rax
  pushq %rdx # cap
  pushq %rcx # len
  pushq %rax # ptr
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  pushq %rcx # len
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -97(%rbp), %rax # local variable ".range.index"
  pushq %rax # variable address
  pushq $0 # T_INT zero value (number)
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  .L.range.cond.28:
  leaq -97(%rbp), %rax # local variable ".range.index"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  leaq -89(%rbp), %rax # local variable ".range.len"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rcx # right
  popq %rax # left
  cmpq %rcx, %rax
  setl %al
  movzbq %al, %rax
  pushq %rax
  popq %rax # result of  indexvar < lenvar
  cmpq $1, %rax
  jne .L.range.exit.28 # jmp if false
  leaq -121(%rbp), %rax # local variable "envline"
  pushq %rax # variable address
  leaq -97(%rbp), %rax # local variable ".range.index"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  leaq runtime.envlines(%rip), %rax # global variable "envlines"
  pushq %rax # variable address
  popq %rax # address of T_SLICE
  movq 16(%rax), %rdx
  movq 8(%rax), %rcx
  movq 0(%rax), %rax
  pushq %rdx # cap
  pushq %rcx # len
  pushq %rax # ptr
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  pushq %rax # slice.ptr
  popq %rax # address of list head
  popq %rcx # index id
  movq $16, %rdx # elm size
  imulq %rdx, %rcx
  addq %rcx, %rax
  pushq %rax # addr of element
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
  leaq -24(%rbp), %rax # local variable "i"
  pushq %rax # variable address
  pushq $0 # T_INT zero value (number)
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -25(%rbp), %rax # local variable "c"
  pushq %rax # variable address
  pushq $0 # T_UINT8 zero value (number)
  popq %rax # result of T_UINT8
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movb %al, 0(%rsi) # assign byte
  leaq -33(%rbp), %rax # local variable ".range.len"
  pushq %rax # variable address
  leaq -121(%rbp), %rax # local variable "envline"
  pushq %rax # variable address
  popq %rax # address of T_STRING
  movq 8(%rax), %rdx # len
  movq 0(%rax), %rax # ptr
  pushq %rdx # len
  pushq %rax # ptr
  popq %rax # string.ptr
  popq %rcx # string.len
  pushq %rcx # cap
  pushq %rcx # len
  pushq %rax # ptr
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  pushq %rcx # len
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -41(%rbp), %rax # local variable ".range.index"
  pushq %rax # variable address
  pushq $0 # T_INT zero value (number)
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -24(%rbp), %rax # local variable "i"
  pushq %rax # variable address
  pushq $0 # T_INT zero value (number)
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  .L.range.cond.29:
  leaq -41(%rbp), %rax # local variable ".range.index"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  leaq -33(%rbp), %rax # local variable ".range.len"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rcx # right
  popq %rax # left
  cmpq %rcx, %rax
  setl %al
  movzbq %al, %rax
  pushq %rax
  popq %rax # result of  indexvar < lenvar
  cmpq $1, %rax
  jne .L.range.exit.29 # jmp if false
  leaq -25(%rbp), %rax # local variable "c"
  pushq %rax # variable address
  leaq -41(%rbp), %rax # local variable ".range.index"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  leaq -121(%rbp), %rax # local variable "envline"
  pushq %rax # variable address
  popq %rax # address of T_STRING
  movq 8(%rax), %rdx # len
  movq 0(%rax), %rax # ptr
  pushq %rdx # len
  pushq %rax # ptr
  popq %rax # string.ptr
  popq %rcx # string.len
  pushq %rcx # cap
  pushq %rcx # len
  pushq %rax # ptr
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  pushq %rax # slice.ptr
  popq %rax # address of list head
  popq %rcx # index id
  movq $1, %rdx # elm size
  imulq %rdx, %rcx
  addq %rcx, %rax
  pushq %rax # addr of element
  popq %rax # address of T_UINT8
  movzbq 0(%rax), %rax # load uint8
  pushq %rax
  popq %rax # result of T_UINT8
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movb %al, 0(%rsi) # assign byte
  leaq -25(%rbp), %rax # local variable "c"
  pushq %rax # variable address
  popq %rax # address of T_UINT8
  movzbq 0(%rax), %rax # load uint8
  pushq %rax
  pushq $61 # convert char literal to int
  popq %rcx # right
  popq %rax # left
  cmpq %rcx, %rax
  sete %al
  movzbq %al, %rax
  pushq %rax
  popq %rax # result of if condition
  cmpq $1, %rax
  jne .L.endif.30 # jmp if false
  jmp .L.range.exit.29 # break
  .L.endif.30:
  .L.range.post.29:
  leaq -41(%rbp), %rax # local variable ".range.index"
  pushq %rax # variable address
  leaq -41(%rbp), %rax # local variable ".range.index"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rax
  addq $1, %rax
  pushq %rax
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -24(%rbp), %rax # local variable "i"
  pushq %rax # variable address
  leaq -41(%rbp), %rax # local variable ".range.index"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  jmp .L.range.cond.29
  .L.range.exit.29:
  leaq -57(%rbp), %rax # local variable "key"
  pushq %rax # variable address
  leaq -24(%rbp), %rax # local variable "i"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  pushq $0 # number literal
  popq %rcx # low
  popq %rax # high
  subq %rcx, %rax # high - low
  pushq %rax # len
  pushq $0 # number literal
  leaq -121(%rbp), %rax # local variable "envline"
  pushq %rax # variable address
  popq %rax # address of T_STRING
  movq 8(%rax), %rdx # len
  movq 0(%rax), %rax # ptr
  pushq %rdx # len
  pushq %rax # ptr
  popq %rax # string.ptr
  popq %rcx # string.len
  pushq %rax # string.ptr
  popq %rax # address of list head
  popq %rcx # index id
  movq $1, %rdx # elm size
  imulq %rdx, %rcx
  addq %rcx, %rax
  pushq %rax # addr of element
  popq %rax # string.ptr
  popq %rcx # string.len
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  leaq -73(%rbp), %rax # local variable "value"
  pushq %rax # variable address
  leaq -121(%rbp), %rax # local variable "envline"
  pushq %rax # variable address
  popq %rax # address of T_STRING
  movq 8(%rax), %rdx # len
  movq 0(%rax), %rax # ptr
  pushq %rdx # len
  pushq %rax # ptr
  popq %rax # string.ptr
  popq %rcx # string.len
  pushq %rcx # len
  leaq -24(%rbp), %rax # local variable "i"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  pushq $1 # number literal
  popq %rcx # right
  popq %rax # left
  addq %rcx, %rax
  pushq %rax
  popq %rcx # low
  popq %rax # high
  subq %rcx, %rax # high - low
  pushq %rax # len
  leaq -24(%rbp), %rax # local variable "i"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  pushq $1 # number literal
  popq %rcx # right
  popq %rax # left
  addq %rcx, %rax
  pushq %rax
  leaq -121(%rbp), %rax # local variable "envline"
  pushq %rax # variable address
  popq %rax # address of T_STRING
  movq 8(%rax), %rdx # len
  movq 0(%rax), %rax # ptr
  pushq %rdx # len
  pushq %rax # ptr
  popq %rax # string.ptr
  popq %rcx # string.len
  pushq %rax # string.ptr
  popq %rax # address of list head
  popq %rcx # index id
  movq $1, %rdx # elm size
  imulq %rdx, %rcx
  addq %rcx, %rax
  pushq %rax # addr of element
  popq %rax # string.ptr
  popq %rcx # string.len
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  leaq -81(%rbp), %rax # local variable "entry"
  pushq %rax # variable address
  subq $8, %rsp # alloc return vars area
  pushq $32
  callq runtime.malloc
  addq $8, %rsp # free parameters area
  #  totalReturnSize=8
  movq 0(%rsp), %rax # copy stack top value (address of struct heaad) 
  pushq %rax
  popq %rax
  addq $0, %rax
  pushq %rax
  leaq -57(%rbp), %rax # local variable "key"
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
  movq 0(%rsp), %rax # copy stack top value (address of struct heaad) 
  pushq %rax
  popq %rax
  addq $16, %rax
  pushq %rax
  leaq -73(%rbp), %rax # local variable "value"
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
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq runtime.Envs(%rip), %rax # global variable "Envs"
  pushq %rax # variable address
  subq $24, %rsp # alloc return vars area
  subq $32, %rsp # alloc parameters area
  leaq runtime.Envs(%rip), %rax # global variable "Envs"
  pushq %rax # variable address
  popq %rax # address of T_SLICE
  movq 16(%rax), %rdx
  movq 8(%rax), %rcx
  movq 0(%rax), %rax
  pushq %rdx # cap
  pushq %rcx # len
  pushq %rax # ptr
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  movq %rdx, 16(%rsi) # cap to cap
  leaq -81(%rbp), %rax # local variable "entry"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_POINTER
  leaq 24(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  callq runtime.append8
  addq $32, %rsp # free parameters area
  #  totalReturnSize=24
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  movq %rdx, 16(%rsi) # cap to cap
  .L.range.post.28:
  leaq -97(%rbp), %rax # local variable ".range.index"
  pushq %rax # variable address
  leaq -97(%rbp), %rax # local variable ".range.index"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rax
  addq $1, %rax
  pushq %rax
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  jmp .L.range.cond.28
  .L.range.exit.28:
  leave
  ret

# Function runtime.runtime_getenv
.global runtime.runtime_getenv
runtime.runtime_getenv: # args 48, locals -32
  pushq %rbp
  movq %rsp, %rbp
  subq $32, %rsp # local area
  leaq -8(%rbp), %rax # local variable ".range.len"
  pushq %rax # variable address
  leaq runtime.Envs(%rip), %rax # global variable "Envs"
  pushq %rax # variable address
  popq %rax # address of T_SLICE
  movq 16(%rax), %rdx
  movq 8(%rax), %rcx
  movq 0(%rax), %rax
  pushq %rdx # cap
  pushq %rcx # len
  pushq %rax # ptr
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  pushq %rcx # len
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -16(%rbp), %rax # local variable ".range.index"
  pushq %rax # variable address
  pushq $0 # T_INT zero value (number)
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  .L.range.cond.31:
  leaq -16(%rbp), %rax # local variable ".range.index"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  leaq -8(%rbp), %rax # local variable ".range.len"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rcx # right
  popq %rax # left
  cmpq %rcx, %rax
  setl %al
  movzbq %al, %rax
  pushq %rax
  popq %rax # result of  indexvar < lenvar
  cmpq $1, %rax
  jne .L.range.exit.31 # jmp if false
  leaq -32(%rbp), %rax # local variable "e"
  pushq %rax # variable address
  leaq -16(%rbp), %rax # local variable ".range.index"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  leaq runtime.Envs(%rip), %rax # global variable "Envs"
  pushq %rax # variable address
  popq %rax # address of T_SLICE
  movq 16(%rax), %rdx
  movq 8(%rax), %rcx
  movq 0(%rax), %rax
  pushq %rdx # cap
  pushq %rcx # len
  pushq %rax # ptr
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  pushq %rax # slice.ptr
  popq %rax # address of list head
  popq %rcx # index id
  movq $8, %rdx # elm size
  imulq %rdx, %rcx
  addq %rcx, %rax
  pushq %rax # addr of element
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  subq $8, %rsp # alloc return vars area
  subq $32, %rsp # alloc parameters area
  leaq -32(%rbp), %rax # local variable "e"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax
  addq $0, %rax
  pushq %rax
  popq %rax # address of T_STRING
  movq 8(%rax), %rdx # len
  movq 0(%rax), %rax # ptr
  pushq %rdx # len
  pushq %rax # ptr
  popq %rax # string.ptr
  popq %rcx # string.len
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  leaq 16(%rbp), %rax # local variable "key"
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
  popq %rax # result of if condition
  cmpq $1, %rax
  jne .L.endif.32 # jmp if false
  leaq 32(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  leaq -32(%rbp), %rax # local variable "e"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax
  addq $16, %rax
  pushq %rax
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
  .L.endif.32:
  .L.range.post.31:
  leaq -16(%rbp), %rax # local variable ".range.index"
  pushq %rax # variable address
  leaq -16(%rbp), %rax # local variable ".range.index"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rax
  addq $1, %rax
  pushq %rax
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  jmp .L.range.cond.31
  .L.range.exit.31:
  leaq 32(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  pushq $0 # string len
  pushq $0 # string ptr
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

# Function runtime.cstring2string
.global runtime.cstring2string
runtime.cstring2string: # args 40, locals -32
  pushq %rbp
  movq %rsp, %rbp
  subq $32, %rsp # local area
  leaq -24(%rbp), %rax # local variable "buf"
  pushq %rax # variable address
  pushq $0 # slice cap
  pushq $0 # slice len
  pushq $0 # slice ptr
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  movq %rdx, 16(%rsi) # cap to cap
  .L.for.cond.33:
  leaq 16(%rbp), %rax # local variable "b"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  pushq $0 # T_POINTER zero value (nil pointer)
  popq %rcx # right
  popq %rax # left
  cmpq %rcx, %rax
  sete %al
  movzbq %al, %rax
  pushq %rax
  popq %rax # result of left
  cmpq $1, %rax
  je .L.35.true
  leaq 16(%rbp), %rax # local variable "b"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # address of T_UINT8
  movzbq 0(%rax), %rax # load uint8
  pushq %rax
  pushq $0 # number literal
  popq %rcx # right
  popq %rax # left
  cmpq %rcx, %rax
  sete %al
  movzbq %al, %rax
  pushq %rax
  jmp .L.35.exit
  .L.35.true:
  pushq $1 # true
  .L.35.exit:
  popq %rax # result of if condition
  cmpq $1, %rax
  jne .L.endif.34 # jmp if false
  jmp .L.for.exit.33 # break
  .L.endif.34:
  leaq -24(%rbp), %rax # local variable "buf"
  pushq %rax # variable address
  subq $24, %rsp # alloc return vars area
  subq $25, %rsp # alloc parameters area
  leaq -24(%rbp), %rax # local variable "buf"
  pushq %rax # variable address
  popq %rax # address of T_SLICE
  movq 16(%rax), %rdx
  movq 8(%rax), %rcx
  movq 0(%rax), %rax
  pushq %rdx # cap
  pushq %rcx # len
  pushq %rax # ptr
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  movq %rdx, 16(%rsi) # cap to cap
  leaq 16(%rbp), %rax # local variable "b"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # address of T_UINT8
  movzbq 0(%rax), %rax # load uint8
  pushq %rax
  popq %rax # result of T_UINT8
  leaq 24(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movb %al, 0(%rsi) # assign byte
  callq runtime.append1
  addq $25, %rsp # free parameters area
  #  totalReturnSize=24
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  movq %rdx, 16(%rsi) # cap to cap
  leaq -32(%rbp), %rax # local variable "p"
  pushq %rax # variable address
  leaq 16(%rbp), %rax # local variable "b"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  pushq $1 # number literal
  popq %rcx # right
  popq %rax # left
  addq %rcx, %rax
  pushq %rax
  popq %rax # result of T_UINTPTR
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq 16(%rbp), %rax # local variable "b"
  pushq %rax # variable address
  leaq -32(%rbp), %rax # local variable "p"
  pushq %rax # variable address
  popq %rax # address of T_UINTPTR
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  .L.for.post.33:
  jmp .L.for.cond.33
  .L.for.exit.33:
  leaq 24(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  leaq -24(%rbp), %rax # local variable "buf"
  pushq %rax # variable address
  popq %rax # address of T_SLICE
  movq 16(%rax), %rdx
  movq 8(%rax), %rcx
  movq 0(%rax), %rax
  pushq %rdx # cap
  pushq %rcx # len
  pushq %rax # ptr
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  pushq %rcx # str len
  pushq %rax # str ptr
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

# Function runtime.runtime_args
.global runtime.runtime_args
runtime.runtime_args: # args 40, locals 0
  pushq %rbp
  movq %rsp, %rbp
  leaq 16(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  leaq runtime.argslice(%rip), %rax # global variable "argslice"
  pushq %rax # variable address
  popq %rax # address of T_SLICE
  movq 16(%rax), %rdx
  movq 8(%rax), %rcx
  movq 0(%rax), %rax
  pushq %rdx # cap
  pushq %rcx # len
  pushq %rax # ptr
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  movq %rdx, 16(%rsi) # cap to cap
  leave
  ret
  leave
  ret

# Function runtime.brk
.global runtime.brk
runtime.brk: # args 32, locals -8
  pushq %rbp
  movq %rsp, %rbp
  subq $8, %rsp # local area
  leaq -8(%rbp), %rax # local variable "ret"
  pushq %rax # variable address
  pushq $0 # T_UINTPTR zero value (nil pointer)
  popq %rax # result of T_UINTPTR
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq -8(%rbp), %rax # local variable "ret"
  pushq %rax # variable address
  subq $8, %rsp # alloc return vars area
  subq $32, %rsp # alloc parameters area
  pushq $12 # number literal
  popq %rax # result of T_UINTPTR
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq 16(%rbp), %rax # local variable "addr"
  pushq %rax # variable address
  popq %rax # address of T_UINTPTR
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_UINTPTR
  leaq 8(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  pushq $0 # number literal
  popq %rax # result of T_UINTPTR
  leaq 16(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  pushq $0 # number literal
  popq %rax # result of T_UINTPTR
  leaq 24(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  callq runtime.Syscall
  addq $32, %rsp # free parameters area
  #  totalReturnSize=8
  popq %rax # result of T_UINTPTR
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq 24(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  leaq -8(%rbp), %rax # local variable "ret"
  pushq %rax # variable address
  popq %rax # address of T_UINTPTR
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_UINTPTR
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leave
  ret
  leave
  ret

# Function runtime.panic
.global runtime.panic
runtime.panic: # args 32, locals -64
  pushq %rbp
  movq %rsp, %rbp
  subq $64, %rsp # local area
  leaq -16(%rbp), %rax # local variable ".switch_expr"
  pushq %rax # variable address
  leaq 16(%rbp), %rax # local variable "ifc"
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
  leaq .dtype.1(%rip), %rax # dtype label address "string"
  pushq %rax           # dtype label address
  popq %rdx           # dtype label address A
  popq %rcx           # dtype label address B
  cmpq %rcx, %rdx
  je .L.cmpdtypes.38.true # jump if match
  cmpq $0, %rdx # check if A is nil
  je .L.cmpdtypes.38.false # jump if nil
  cmpq $0, %rcx # check if B is nil
  je .L.cmpdtypes.38.false # jump if nil
  jmp .L.cmpdtypes.38.cmp # jump to end
  .L.cmpdtypes.38.true:
  pushq $1
  jmp .L.cmpdtypes.38.end # jump to end
  .L.cmpdtypes.38.false:
  pushq $0
  jmp .L.cmpdtypes.38.end # jump to end
  .L.cmpdtypes.38.cmp:
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
  .L.cmpdtypes.38.end:
  popq %rax # result of  of switch-case comparison
  cmpq $1, %rax
  je .L.case.37 # jump if match
  jmp .L.case.39
  .L.case.37:
  leaq -32(%rbp), %rax # local variable "x"
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
  leaq -48(%rbp), %rax # local variable "s"
  pushq %rax # variable address
  subq $16, %rsp # alloc return vars area
  subq $32, %rsp # alloc parameters area
  subq $16, %rsp # alloc return vars area
  subq $32, %rsp # alloc parameters area
  pushq $7 # str len
  leaq .string_3(%rip), %rax # str ptr
  pushq %rax # str ptr
  popq %rax # string.ptr
  popq %rcx # string.len
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  leaq -32(%rbp), %rax # local variable "x"
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
  callq runtime.catstrings
  addq $32, %rsp # free parameters area
  #  totalReturnSize=16
  popq %rax # string.ptr
  popq %rcx # string.len
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  pushq $2 # str len
  leaq .string_4(%rip), %rax # str ptr
  pushq %rax # str ptr
  popq %rax # string.ptr
  popq %rcx # string.len
  leaq 16(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  callq runtime.catstrings
  addq $32, %rsp # free parameters area
  #  totalReturnSize=16
  popq %rax # string.ptr
  popq %rcx # string.len
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  leaq -32(%rbp), %rax # local variable "x"
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
  subq $8, %rsp # alloc return vars area
  subq $32, %rsp # alloc parameters area
  pushq $2 # number literal
  popq %rax # result of T_INT
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -48(%rbp), %rax # local variable "s"
  pushq %rax # variable address
  popq %rax # address of T_STRING
  movq 8(%rax), %rdx # len
  movq 0(%rax), %rax # ptr
  pushq %rdx # len
  pushq %rax # ptr
  popq %rax # string.ptr
  popq %rcx # string.len
  pushq %rcx # cap
  pushq %rcx # len
  pushq %rax # ptr
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  leaq 8(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  movq %rdx, 16(%rsi) # cap to cap
  callq runtime.Write
  addq $32, %rsp # free parameters area
  #  totalReturnSize=8
  leaq -32(%rbp), %rax # local variable "x"
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
  subq $8, %rsp # alloc return vars area
  subq $32, %rsp # alloc parameters area
  pushq $60 # number literal
  popq %rax # result of T_UINTPTR
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  pushq $1 # number literal
  popq %rax # result of T_UINTPTR
  leaq 8(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  pushq $0 # number literal
  popq %rax # result of T_UINTPTR
  leaq 16(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  pushq $0 # number literal
  popq %rax # result of T_UINTPTR
  leaq 24(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  callq runtime.Syscall
  addq $32, %rsp # free parameters area
  #  totalReturnSize=8
  jmp .L.typeswitch.36.exit
  .L.case.39:
  leaq -64(%rbp), %rax # local variable "s"
  pushq %rax # variable address
  subq $16, %rsp # alloc return vars area
  subq $32, %rsp # alloc parameters area
  subq $16, %rsp # alloc return vars area
  subq $32, %rsp # alloc parameters area
  pushq $7 # str len
  leaq .string_5(%rip), %rax # str ptr
  pushq %rax # str ptr
  popq %rax # string.ptr
  popq %rcx # string.len
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  pushq $12 # str len
  leaq .string_6(%rip), %rax # str ptr
  pushq %rax # str ptr
  popq %rax # string.ptr
  popq %rcx # string.len
  leaq 16(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  callq runtime.catstrings
  addq $32, %rsp # free parameters area
  #  totalReturnSize=16
  popq %rax # string.ptr
  popq %rcx # string.len
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  pushq $2 # str len
  leaq .string_7(%rip), %rax # str ptr
  pushq %rax # str ptr
  popq %rax # string.ptr
  popq %rcx # string.len
  leaq 16(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  callq runtime.catstrings
  addq $32, %rsp # free parameters area
  #  totalReturnSize=16
  popq %rax # string.ptr
  popq %rcx # string.len
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  subq $8, %rsp # alloc return vars area
  subq $32, %rsp # alloc parameters area
  pushq $2 # number literal
  popq %rax # result of T_INT
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -64(%rbp), %rax # local variable "s"
  pushq %rax # variable address
  popq %rax # address of T_STRING
  movq 8(%rax), %rdx # len
  movq 0(%rax), %rax # ptr
  pushq %rdx # len
  pushq %rax # ptr
  popq %rax # string.ptr
  popq %rcx # string.len
  pushq %rcx # cap
  pushq %rcx # len
  pushq %rax # ptr
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  leaq 8(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  movq %rdx, 16(%rsi) # cap to cap
  callq runtime.Write
  addq $32, %rsp # free parameters area
  #  totalReturnSize=8
  subq $8, %rsp # alloc return vars area
  subq $32, %rsp # alloc parameters area
  pushq $60 # number literal
  popq %rax # result of T_UINTPTR
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  pushq $1 # number literal
  popq %rax # result of T_UINTPTR
  leaq 8(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  pushq $0 # number literal
  popq %rax # result of T_UINTPTR
  leaq 16(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  pushq $0 # number literal
  popq %rax # result of T_UINTPTR
  leaq 24(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  callq runtime.Syscall
  addq $32, %rsp # free parameters area
  #  totalReturnSize=8
  jmp .L.typeswitch.36.exit
  .L.typeswitch.36.exit:
  leave
  ret

# Function runtime.memzeropad
.global runtime.memzeropad
runtime.memzeropad: # args 32, locals -32
  pushq %rbp
  movq %rsp, %rbp
  subq $32, %rsp # local area
  leaq -8(%rbp), %rax # local variable "p"
  pushq %rax # variable address
  leaq 16(%rbp), %rax # local variable "addr1"
  pushq %rax # variable address
  popq %rax # address of T_UINTPTR
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq -16(%rbp), %rax # local variable "isize"
  pushq %rax # variable address
  leaq 24(%rbp), %rax # local variable "size"
  pushq %rax # variable address
  popq %rax # address of T_UINTPTR
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -24(%rbp), %rax # local variable "i"
  pushq %rax # variable address
  pushq $0 # T_INT zero value (number)
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -32(%rbp), %rax # local variable "up"
  pushq %rax # variable address
  pushq $0 # T_UINTPTR zero value (nil pointer)
  popq %rax # result of T_UINTPTR
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq -24(%rbp), %rax # local variable "i"
  pushq %rax # variable address
  pushq $0 # number literal
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  .L.for.cond.40:
  leaq -24(%rbp), %rax # local variable "i"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  leaq -16(%rbp), %rax # local variable "isize"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rcx # right
  popq %rax # left
  cmpq %rcx, %rax
  setl %al
  movzbq %al, %rax
  pushq %rax
  popq %rax # result of for condition
  cmpq $1, %rax
  jne .L.for.exit.40 # jmp if false
  leaq -8(%rbp), %rax # local variable "p"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  pushq $0 # number literal
  popq %rax # result of T_UINT8
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movb %al, 0(%rsi) # assign byte
  leaq -32(%rbp), %rax # local variable "up"
  pushq %rax # variable address
  leaq -8(%rbp), %rax # local variable "p"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  pushq $1 # number literal
  popq %rcx # right
  popq %rax # left
  addq %rcx, %rax
  pushq %rax
  popq %rax # result of T_UINTPTR
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq -8(%rbp), %rax # local variable "p"
  pushq %rax # variable address
  leaq -32(%rbp), %rax # local variable "up"
  pushq %rax # variable address
  popq %rax # address of T_UINTPTR
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  .L.for.post.40:
  leaq -24(%rbp), %rax # local variable "i"
  pushq %rax # variable address
  leaq -24(%rbp), %rax # local variable "i"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rax
  addq $1, %rax
  pushq %rax
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  jmp .L.for.cond.40
  .L.for.exit.40:
  leave
  ret

# Function runtime.memcopy
.global runtime.memcopy
runtime.memcopy: # args 40, locals -24
  pushq %rbp
  movq %rsp, %rbp
  subq $24, %rsp # local area
  leaq -8(%rbp), %rax # local variable "i"
  pushq %rax # variable address
  pushq $0 # T_INT zero value (number)
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -16(%rbp), %rax # local variable "srcp"
  pushq %rax # variable address
  pushq $0 # T_POINTER zero value (nil pointer)
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq -24(%rbp), %rax # local variable "dstp"
  pushq %rax # variable address
  pushq $0 # T_POINTER zero value (nil pointer)
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq -8(%rbp), %rax # local variable "i"
  pushq %rax # variable address
  pushq $0 # number literal
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  .L.for.cond.41:
  leaq -8(%rbp), %rax # local variable "i"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  leaq 32(%rbp), %rax # local variable "length"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rcx # right
  popq %rax # left
  cmpq %rcx, %rax
  setl %al
  movzbq %al, %rax
  pushq %rax
  popq %rax # result of for condition
  cmpq $1, %rax
  jne .L.for.exit.41 # jmp if false
  leaq -16(%rbp), %rax # local variable "srcp"
  pushq %rax # variable address
  leaq 16(%rbp), %rax # local variable "src"
  pushq %rax # variable address
  popq %rax # address of T_UINTPTR
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  leaq -8(%rbp), %rax # local variable "i"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rcx # right
  popq %rax # left
  addq %rcx, %rax
  pushq %rax
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq -24(%rbp), %rax # local variable "dstp"
  pushq %rax # variable address
  leaq 24(%rbp), %rax # local variable "dst"
  pushq %rax # variable address
  popq %rax # address of T_UINTPTR
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  leaq -8(%rbp), %rax # local variable "i"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rcx # right
  popq %rax # left
  addq %rcx, %rax
  pushq %rax
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq -24(%rbp), %rax # local variable "dstp"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  leaq -16(%rbp), %rax # local variable "srcp"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # address of T_UINT8
  movzbq 0(%rax), %rax # load uint8
  pushq %rax
  popq %rax # result of T_UINT8
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movb %al, 0(%rsi) # assign byte
  .L.for.post.41:
  leaq -8(%rbp), %rax # local variable "i"
  pushq %rax # variable address
  leaq -8(%rbp), %rax # local variable "i"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rax
  addq $1, %rax
  pushq %rax
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  jmp .L.for.cond.41
  .L.for.exit.41:
  leave
  ret

# Function runtime.malloc
.global runtime.malloc
runtime.malloc: # args 32, locals -8
  pushq %rbp
  movq %rsp, %rbp
  subq $8, %rsp # local area
  leaq runtime.heapCurrent(%rip), %rax # global variable "heapCurrent"
  pushq %rax # variable address
  popq %rax # address of T_UINTPTR
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  leaq 16(%rbp), %rax # local variable "size"
  pushq %rax # variable address
  popq %rax # address of T_UINTPTR
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rcx # right
  popq %rax # left
  addq %rcx, %rax
  pushq %rax
  leaq runtime.heapTail(%rip), %rax # global variable "heapTail"
  pushq %rax # variable address
  popq %rax # address of T_UINTPTR
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rcx # right
  popq %rax # left
  cmpq %rcx, %rax
  setg %al
  movzbq %al, %rax
  pushq %rax
  popq %rax # result of if condition
  cmpq $1, %rax
  jne .L.endif.42 # jmp if false
  subq $8, %rsp # alloc return vars area
  subq $32, %rsp # alloc parameters area
  pushq $2 # number literal
  popq %rax # result of T_INT
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  pushq $24 # str len
  leaq .string_8(%rip), %rax # str ptr
  pushq %rax # str ptr
  popq %rax # string.ptr
  popq %rcx # string.len
  pushq %rcx # cap
  pushq %rcx # len
  pushq %rax # ptr
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  leaq 8(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  movq %rdx, 16(%rsi) # cap to cap
  callq runtime.Write
  addq $32, %rsp # free parameters area
  #  totalReturnSize=8
  subq $8, %rsp # alloc return vars area
  subq $32, %rsp # alloc parameters area
  pushq $60 # number literal
  popq %rax # result of T_UINTPTR
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  pushq $1 # number literal
  popq %rax # result of T_UINTPTR
  leaq 8(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  pushq $0 # number literal
  popq %rax # result of T_UINTPTR
  leaq 16(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  pushq $0 # number literal
  popq %rax # result of T_UINTPTR
  leaq 24(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  callq runtime.Syscall
  addq $32, %rsp # free parameters area
  #  totalReturnSize=8
  leaq 24(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  pushq $0 # number literal
  popq %rax # result of T_UINTPTR
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leave
  ret
  .L.endif.42:
  leaq -8(%rbp), %rax # local variable "r"
  pushq %rax # variable address
  pushq $0 # T_UINTPTR zero value (nil pointer)
  popq %rax # result of T_UINTPTR
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq -8(%rbp), %rax # local variable "r"
  pushq %rax # variable address
  leaq runtime.heapCurrent(%rip), %rax # global variable "heapCurrent"
  pushq %rax # variable address
  popq %rax # address of T_UINTPTR
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_UINTPTR
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq runtime.heapCurrent(%rip), %rax # global variable "heapCurrent"
  pushq %rax # variable address
  leaq runtime.heapCurrent(%rip), %rax # global variable "heapCurrent"
  pushq %rax # variable address
  popq %rax # address of T_UINTPTR
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  leaq 16(%rbp), %rax # local variable "size"
  pushq %rax # variable address
  popq %rax # address of T_UINTPTR
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rcx # right
  popq %rax # left
  addq %rcx, %rax
  pushq %rax
  popq %rax # result of T_UINTPTR
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  subq $16, %rsp # alloc parameters area
  leaq -8(%rbp), %rax # local variable "r"
  pushq %rax # variable address
  popq %rax # address of T_UINTPTR
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_UINTPTR
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq 16(%rbp), %rax # local variable "size"
  pushq %rax # variable address
  popq %rax # address of T_UINTPTR
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_UINTPTR
  leaq 8(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  callq runtime.memzeropad
  addq $16, %rsp # free parameters area
  #  totalReturnSize=0
  leaq 24(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  leaq -8(%rbp), %rax # local variable "r"
  pushq %rax # variable address
  popq %rax # address of T_UINTPTR
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_UINTPTR
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leave
  ret
  leave
  ret

# Function runtime.makeSlice
.global runtime.makeSlice
runtime.makeSlice: # args 64, locals -16
  pushq %rbp
  movq %rsp, %rbp
  subq $16, %rsp # local area
  leaq -8(%rbp), %rax # local variable "size"
  pushq %rax # variable address
  leaq 16(%rbp), %rax # local variable "elmSize"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  leaq 32(%rbp), %rax # local variable "scap"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rcx # right
  popq %rax # left
  imulq %rcx, %rax
  pushq %rax
  popq %rax # result of T_UINTPTR
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq -16(%rbp), %rax # local variable "addr"
  pushq %rax # variable address
  subq $8, %rsp # alloc return vars area
  subq $8, %rsp # alloc parameters area
  leaq -8(%rbp), %rax # local variable "size"
  pushq %rax # variable address
  popq %rax # address of T_UINTPTR
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_UINTPTR
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  callq runtime.malloc
  addq $8, %rsp # free parameters area
  #  totalReturnSize=8
  popq %rax # result of T_UINTPTR
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq 40(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  leaq -16(%rbp), %rax # local variable "addr"
  pushq %rax # variable address
  popq %rax # address of T_UINTPTR
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_UINTPTR
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq 48(%rbp), %rax # local variable ".r1"
  pushq %rax # variable address
  leaq 24(%rbp), %rax # local variable "slen"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq 56(%rbp), %rax # local variable ".r2"
  pushq %rax # variable address
  leaq 32(%rbp), %rax # local variable "scap"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leave
  ret
  leave
  ret

# Function runtime.append1
.global runtime.append1
runtime.append1: # args 65, locals -64
  pushq %rbp
  movq %rsp, %rbp
  subq $64, %rsp # local area
  leaq -24(%rbp), %rax # local variable "new_"
  pushq %rax # variable address
  pushq $0 # slice cap
  pushq $0 # slice len
  pushq $0 # slice ptr
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  movq %rdx, 16(%rsi) # cap to cap
  leaq -32(%rbp), %rax # local variable "elmSize"
  pushq %rax # variable address
  pushq $1 # number literal
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -40(%rbp), %rax # local variable "oldlen"
  pushq %rax # variable address
  leaq 16(%rbp), %rax # local variable "old"
  pushq %rax # variable address
  popq %rax # address of T_SLICE
  movq 16(%rax), %rdx
  movq 8(%rax), %rcx
  movq 0(%rax), %rax
  pushq %rdx # cap
  pushq %rcx # len
  pushq %rax # ptr
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  pushq %rcx # len
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -48(%rbp), %rax # local variable "newlen"
  pushq %rax # variable address
  leaq -40(%rbp), %rax # local variable "oldlen"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  pushq $1 # number literal
  popq %rcx # right
  popq %rax # left
  addq %rcx, %rax
  pushq %rax
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq 16(%rbp), %rax # local variable "old"
  pushq %rax # variable address
  popq %rax # address of T_SLICE
  movq 16(%rax), %rdx
  movq 8(%rax), %rcx
  movq 0(%rax), %rax
  pushq %rdx # cap
  pushq %rcx # len
  pushq %rax # ptr
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  pushq %rdx # cap
  leaq -48(%rbp), %rax # local variable "newlen"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rcx # right
  popq %rax # left
  cmpq %rcx, %rax
  setge %al
  movzbq %al, %rax
  pushq %rax
  popq %rax # result of if condition
  cmpq $1, %rax
  jne .L.else.43 # jmp if false
  leaq -24(%rbp), %rax # local variable "new_"
  pushq %rax # variable address
  leaq 16(%rbp), %rax # local variable "old"
  pushq %rax # variable address
  popq %rax # address of T_SLICE
  movq 16(%rax), %rdx
  movq 8(%rax), %rcx
  movq 0(%rax), %rax
  pushq %rdx # cap
  pushq %rcx # len
  pushq %rax # ptr
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  pushq %rdx # cap
  pushq $0 # number literal
  popq %rcx # low
  popq %rax # orig_cap
  subq %rcx, %rax # orig_cap - low
  pushq %rax # new cap
  leaq -48(%rbp), %rax # local variable "newlen"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  pushq $0 # number literal
  popq %rcx # low
  popq %rax # high
  subq %rcx, %rax # high - low
  pushq %rax # new len
  pushq $0 # number literal
  leaq 16(%rbp), %rax # local variable "old"
  pushq %rax # variable address
  popq %rax # address of T_SLICE
  movq 16(%rax), %rdx
  movq 8(%rax), %rcx
  movq 0(%rax), %rax
  pushq %rdx # cap
  pushq %rcx # len
  pushq %rax # ptr
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  pushq %rax # slice.ptr
  popq %rax # address of list head
  popq %rcx # index id
  movq $1, %rdx # elm size
  imulq %rdx, %rcx
  addq %rcx, %rax
  pushq %rax # addr of element
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  movq %rdx, 16(%rsi) # cap to cap
  jmp .L.endif.43
  .L.else.43:
  leaq -56(%rbp), %rax # local variable "newcap"
  pushq %rax # variable address
  pushq $0 # T_INT zero value (number)
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -40(%rbp), %rax # local variable "oldlen"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  pushq $0 # number literal
  popq %rcx # right
  popq %rax # left
  cmpq %rcx, %rax
  sete %al
  movzbq %al, %rax
  pushq %rax
  popq %rax # result of if condition
  cmpq $1, %rax
  jne .L.else.44 # jmp if false
  leaq -56(%rbp), %rax # local variable "newcap"
  pushq %rax # variable address
  pushq $1 # number literal
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  jmp .L.endif.44
  .L.else.44:
  leaq -56(%rbp), %rax # local variable "newcap"
  pushq %rax # variable address
  leaq -40(%rbp), %rax # local variable "oldlen"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  pushq $2 # number literal
  popq %rcx # right
  popq %rax # left
  imulq %rcx, %rax
  pushq %rax
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  .L.endif.44:
  leaq -24(%rbp), %rax # local variable "new_"
  pushq %rax # variable address
  subq $24, %rsp # alloc return vars area
  subq $24, %rsp # alloc parameters area
  leaq -32(%rbp), %rax # local variable "elmSize"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rax # result of T_INT
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -48(%rbp), %rax # local variable "newlen"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rax # result of T_INT
  leaq 8(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -56(%rbp), %rax # local variable "newcap"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rax # result of T_INT
  leaq 16(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  callq runtime.makeSlice
  addq $24, %rsp # free parameters area
  #  totalReturnSize=24
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  movq %rdx, 16(%rsi) # cap to cap
  leaq -64(%rbp), %rax # local variable "oldSize"
  pushq %rax # variable address
  leaq -40(%rbp), %rax # local variable "oldlen"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  leaq -32(%rbp), %rax # local variable "elmSize"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rcx # right
  popq %rax # left
  imulq %rcx, %rax
  pushq %rax
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -40(%rbp), %rax # local variable "oldlen"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  pushq $0 # number literal
  popq %rcx # right
  popq %rax # left
  cmpq %rcx, %rax
  setg %al
  movzbq %al, %rax
  pushq %rax
  popq %rax # result of if condition
  cmpq $1, %rax
  jne .L.endif.45 # jmp if false
  subq $24, %rsp # alloc parameters area
  pushq $0 # number literal
  leaq 16(%rbp), %rax # local variable "old"
  pushq %rax # variable address
  popq %rax # address of T_SLICE
  movq 16(%rax), %rdx
  movq 8(%rax), %rcx
  movq 0(%rax), %rax
  pushq %rdx # cap
  pushq %rcx # len
  pushq %rax # ptr
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  pushq %rax # slice.ptr
  popq %rax # address of list head
  popq %rcx # index id
  movq $1, %rdx # elm size
  imulq %rdx, %rcx
  addq %rcx, %rax
  pushq %rax # addr of element
  popq %rax # result of T_UINTPTR
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  pushq $0 # number literal
  leaq -24(%rbp), %rax # local variable "new_"
  pushq %rax # variable address
  popq %rax # address of T_SLICE
  movq 16(%rax), %rdx
  movq 8(%rax), %rcx
  movq 0(%rax), %rax
  pushq %rdx # cap
  pushq %rcx # len
  pushq %rax # ptr
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  pushq %rax # slice.ptr
  popq %rax # address of list head
  popq %rcx # index id
  movq $1, %rdx # elm size
  imulq %rdx, %rcx
  addq %rcx, %rax
  pushq %rax # addr of element
  popq %rax # result of T_UINTPTR
  leaq 8(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq -64(%rbp), %rax # local variable "oldSize"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rax # result of T_INT
  leaq 16(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  callq runtime.memcopy
  addq $24, %rsp # free parameters area
  #  totalReturnSize=0
  .L.endif.45:
  .L.endif.43:
  leaq -40(%rbp), %rax # local variable "oldlen"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  leaq -24(%rbp), %rax # local variable "new_"
  pushq %rax # variable address
  popq %rax # address of T_SLICE
  movq 16(%rax), %rdx
  movq 8(%rax), %rcx
  movq 0(%rax), %rax
  pushq %rdx # cap
  pushq %rcx # len
  pushq %rax # ptr
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  pushq %rax # slice.ptr
  popq %rax # address of list head
  popq %rcx # index id
  movq $1, %rdx # elm size
  imulq %rdx, %rcx
  addq %rcx, %rax
  pushq %rax # addr of element
  leaq 40(%rbp), %rax # local variable "elm"
  pushq %rax # variable address
  popq %rax # address of T_UINT8
  movzbq 0(%rax), %rax # load uint8
  pushq %rax
  popq %rax # result of T_UINT8
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movb %al, 0(%rsi) # assign byte
  leaq 41(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  pushq $0 # number literal
  leaq -24(%rbp), %rax # local variable "new_"
  pushq %rax # variable address
  popq %rax # address of T_SLICE
  movq 16(%rax), %rdx
  movq 8(%rax), %rcx
  movq 0(%rax), %rax
  pushq %rdx # cap
  pushq %rcx # len
  pushq %rax # ptr
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  pushq %rax # slice.ptr
  popq %rax # address of list head
  popq %rcx # index id
  movq $1, %rdx # elm size
  imulq %rdx, %rcx
  addq %rcx, %rax
  pushq %rax # addr of element
  popq %rax # result of T_UINTPTR
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq 49(%rbp), %rax # local variable ".r1"
  pushq %rax # variable address
  leaq -48(%rbp), %rax # local variable "newlen"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq 57(%rbp), %rax # local variable ".r2"
  pushq %rax # variable address
  leaq -24(%rbp), %rax # local variable "new_"
  pushq %rax # variable address
  popq %rax # address of T_SLICE
  movq 16(%rax), %rdx
  movq 8(%rax), %rcx
  movq 0(%rax), %rax
  pushq %rdx # cap
  pushq %rcx # len
  pushq %rax # ptr
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  pushq %rdx # cap
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leave
  ret
  leave
  ret

# Function runtime.append8
.global runtime.append8
runtime.append8: # args 72, locals -64
  pushq %rbp
  movq %rsp, %rbp
  subq $64, %rsp # local area
  leaq -24(%rbp), %rax # local variable "new_"
  pushq %rax # variable address
  pushq $0 # slice cap
  pushq $0 # slice len
  pushq $0 # slice ptr
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  movq %rdx, 16(%rsi) # cap to cap
  leaq -32(%rbp), %rax # local variable "elmSize"
  pushq %rax # variable address
  pushq $8 # number literal
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -40(%rbp), %rax # local variable "oldlen"
  pushq %rax # variable address
  leaq 16(%rbp), %rax # local variable "old"
  pushq %rax # variable address
  popq %rax # address of T_SLICE
  movq 16(%rax), %rdx
  movq 8(%rax), %rcx
  movq 0(%rax), %rax
  pushq %rdx # cap
  pushq %rcx # len
  pushq %rax # ptr
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  pushq %rcx # len
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -48(%rbp), %rax # local variable "newlen"
  pushq %rax # variable address
  leaq -40(%rbp), %rax # local variable "oldlen"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  pushq $1 # number literal
  popq %rcx # right
  popq %rax # left
  addq %rcx, %rax
  pushq %rax
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq 16(%rbp), %rax # local variable "old"
  pushq %rax # variable address
  popq %rax # address of T_SLICE
  movq 16(%rax), %rdx
  movq 8(%rax), %rcx
  movq 0(%rax), %rax
  pushq %rdx # cap
  pushq %rcx # len
  pushq %rax # ptr
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  pushq %rdx # cap
  leaq -48(%rbp), %rax # local variable "newlen"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rcx # right
  popq %rax # left
  cmpq %rcx, %rax
  setge %al
  movzbq %al, %rax
  pushq %rax
  popq %rax # result of if condition
  cmpq $1, %rax
  jne .L.else.46 # jmp if false
  leaq -24(%rbp), %rax # local variable "new_"
  pushq %rax # variable address
  leaq 16(%rbp), %rax # local variable "old"
  pushq %rax # variable address
  popq %rax # address of T_SLICE
  movq 16(%rax), %rdx
  movq 8(%rax), %rcx
  movq 0(%rax), %rax
  pushq %rdx # cap
  pushq %rcx # len
  pushq %rax # ptr
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  pushq %rdx # cap
  pushq $0 # number literal
  popq %rcx # low
  popq %rax # orig_cap
  subq %rcx, %rax # orig_cap - low
  pushq %rax # new cap
  leaq -48(%rbp), %rax # local variable "newlen"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  pushq $0 # number literal
  popq %rcx # low
  popq %rax # high
  subq %rcx, %rax # high - low
  pushq %rax # new len
  pushq $0 # number literal
  leaq 16(%rbp), %rax # local variable "old"
  pushq %rax # variable address
  popq %rax # address of T_SLICE
  movq 16(%rax), %rdx
  movq 8(%rax), %rcx
  movq 0(%rax), %rax
  pushq %rdx # cap
  pushq %rcx # len
  pushq %rax # ptr
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  pushq %rax # slice.ptr
  popq %rax # address of list head
  popq %rcx # index id
  movq $8, %rdx # elm size
  imulq %rdx, %rcx
  addq %rcx, %rax
  pushq %rax # addr of element
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  movq %rdx, 16(%rsi) # cap to cap
  jmp .L.endif.46
  .L.else.46:
  leaq -56(%rbp), %rax # local variable "newcap"
  pushq %rax # variable address
  pushq $0 # T_INT zero value (number)
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -40(%rbp), %rax # local variable "oldlen"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  pushq $0 # number literal
  popq %rcx # right
  popq %rax # left
  cmpq %rcx, %rax
  sete %al
  movzbq %al, %rax
  pushq %rax
  popq %rax # result of if condition
  cmpq $1, %rax
  jne .L.else.47 # jmp if false
  leaq -56(%rbp), %rax # local variable "newcap"
  pushq %rax # variable address
  pushq $1 # number literal
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  jmp .L.endif.47
  .L.else.47:
  leaq -56(%rbp), %rax # local variable "newcap"
  pushq %rax # variable address
  leaq -40(%rbp), %rax # local variable "oldlen"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  pushq $2 # number literal
  popq %rcx # right
  popq %rax # left
  imulq %rcx, %rax
  pushq %rax
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  .L.endif.47:
  leaq -24(%rbp), %rax # local variable "new_"
  pushq %rax # variable address
  subq $24, %rsp # alloc return vars area
  subq $24, %rsp # alloc parameters area
  leaq -32(%rbp), %rax # local variable "elmSize"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rax # result of T_INT
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -48(%rbp), %rax # local variable "newlen"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rax # result of T_INT
  leaq 8(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -56(%rbp), %rax # local variable "newcap"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rax # result of T_INT
  leaq 16(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  callq runtime.makeSlice
  addq $24, %rsp # free parameters area
  #  totalReturnSize=24
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  movq %rdx, 16(%rsi) # cap to cap
  leaq -64(%rbp), %rax # local variable "oldSize"
  pushq %rax # variable address
  leaq -40(%rbp), %rax # local variable "oldlen"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  leaq -32(%rbp), %rax # local variable "elmSize"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rcx # right
  popq %rax # left
  imulq %rcx, %rax
  pushq %rax
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -40(%rbp), %rax # local variable "oldlen"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  pushq $0 # number literal
  popq %rcx # right
  popq %rax # left
  cmpq %rcx, %rax
  setg %al
  movzbq %al, %rax
  pushq %rax
  popq %rax # result of if condition
  cmpq $1, %rax
  jne .L.endif.48 # jmp if false
  subq $24, %rsp # alloc parameters area
  pushq $0 # number literal
  leaq 16(%rbp), %rax # local variable "old"
  pushq %rax # variable address
  popq %rax # address of T_SLICE
  movq 16(%rax), %rdx
  movq 8(%rax), %rcx
  movq 0(%rax), %rax
  pushq %rdx # cap
  pushq %rcx # len
  pushq %rax # ptr
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  pushq %rax # slice.ptr
  popq %rax # address of list head
  popq %rcx # index id
  movq $8, %rdx # elm size
  imulq %rdx, %rcx
  addq %rcx, %rax
  pushq %rax # addr of element
  popq %rax # result of T_UINTPTR
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  pushq $0 # number literal
  leaq -24(%rbp), %rax # local variable "new_"
  pushq %rax # variable address
  popq %rax # address of T_SLICE
  movq 16(%rax), %rdx
  movq 8(%rax), %rcx
  movq 0(%rax), %rax
  pushq %rdx # cap
  pushq %rcx # len
  pushq %rax # ptr
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  pushq %rax # slice.ptr
  popq %rax # address of list head
  popq %rcx # index id
  movq $8, %rdx # elm size
  imulq %rdx, %rcx
  addq %rcx, %rax
  pushq %rax # addr of element
  popq %rax # result of T_UINTPTR
  leaq 8(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq -64(%rbp), %rax # local variable "oldSize"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rax # result of T_INT
  leaq 16(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  callq runtime.memcopy
  addq $24, %rsp # free parameters area
  #  totalReturnSize=0
  .L.endif.48:
  .L.endif.46:
  leaq -40(%rbp), %rax # local variable "oldlen"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  leaq -24(%rbp), %rax # local variable "new_"
  pushq %rax # variable address
  popq %rax # address of T_SLICE
  movq 16(%rax), %rdx
  movq 8(%rax), %rcx
  movq 0(%rax), %rax
  pushq %rdx # cap
  pushq %rcx # len
  pushq %rax # ptr
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  pushq %rax # slice.ptr
  popq %rax # address of list head
  popq %rcx # index id
  movq $8, %rdx # elm size
  imulq %rdx, %rcx
  addq %rcx, %rax
  pushq %rax # addr of element
  leaq 40(%rbp), %rax # local variable "elm"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq 48(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  pushq $0 # number literal
  leaq -24(%rbp), %rax # local variable "new_"
  pushq %rax # variable address
  popq %rax # address of T_SLICE
  movq 16(%rax), %rdx
  movq 8(%rax), %rcx
  movq 0(%rax), %rax
  pushq %rdx # cap
  pushq %rcx # len
  pushq %rax # ptr
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  pushq %rax # slice.ptr
  popq %rax # address of list head
  popq %rcx # index id
  movq $8, %rdx # elm size
  imulq %rdx, %rcx
  addq %rcx, %rax
  pushq %rax # addr of element
  popq %rax # result of T_UINTPTR
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq 56(%rbp), %rax # local variable ".r1"
  pushq %rax # variable address
  leaq -48(%rbp), %rax # local variable "newlen"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq 64(%rbp), %rax # local variable ".r2"
  pushq %rax # variable address
  leaq -24(%rbp), %rax # local variable "new_"
  pushq %rax # variable address
  popq %rax # address of T_SLICE
  movq 16(%rax), %rdx
  movq 8(%rax), %rcx
  movq 0(%rax), %rax
  pushq %rdx # cap
  pushq %rcx # len
  pushq %rax # ptr
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  pushq %rdx # cap
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leave
  ret
  leave
  ret

# Function runtime.append16
.global runtime.append16
runtime.append16: # args 80, locals -64
  pushq %rbp
  movq %rsp, %rbp
  subq $64, %rsp # local area
  leaq -24(%rbp), %rax # local variable "new_"
  pushq %rax # variable address
  pushq $0 # slice cap
  pushq $0 # slice len
  pushq $0 # slice ptr
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  movq %rdx, 16(%rsi) # cap to cap
  leaq -32(%rbp), %rax # local variable "elmSize"
  pushq %rax # variable address
  pushq $16 # number literal
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -40(%rbp), %rax # local variable "oldlen"
  pushq %rax # variable address
  leaq 16(%rbp), %rax # local variable "old"
  pushq %rax # variable address
  popq %rax # address of T_SLICE
  movq 16(%rax), %rdx
  movq 8(%rax), %rcx
  movq 0(%rax), %rax
  pushq %rdx # cap
  pushq %rcx # len
  pushq %rax # ptr
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  pushq %rcx # len
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -48(%rbp), %rax # local variable "newlen"
  pushq %rax # variable address
  leaq -40(%rbp), %rax # local variable "oldlen"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  pushq $1 # number literal
  popq %rcx # right
  popq %rax # left
  addq %rcx, %rax
  pushq %rax
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq 16(%rbp), %rax # local variable "old"
  pushq %rax # variable address
  popq %rax # address of T_SLICE
  movq 16(%rax), %rdx
  movq 8(%rax), %rcx
  movq 0(%rax), %rax
  pushq %rdx # cap
  pushq %rcx # len
  pushq %rax # ptr
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  pushq %rdx # cap
  leaq -48(%rbp), %rax # local variable "newlen"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rcx # right
  popq %rax # left
  cmpq %rcx, %rax
  setge %al
  movzbq %al, %rax
  pushq %rax
  popq %rax # result of if condition
  cmpq $1, %rax
  jne .L.else.49 # jmp if false
  leaq -24(%rbp), %rax # local variable "new_"
  pushq %rax # variable address
  leaq 16(%rbp), %rax # local variable "old"
  pushq %rax # variable address
  popq %rax # address of T_SLICE
  movq 16(%rax), %rdx
  movq 8(%rax), %rcx
  movq 0(%rax), %rax
  pushq %rdx # cap
  pushq %rcx # len
  pushq %rax # ptr
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  pushq %rdx # cap
  pushq $0 # number literal
  popq %rcx # low
  popq %rax # orig_cap
  subq %rcx, %rax # orig_cap - low
  pushq %rax # new cap
  leaq -48(%rbp), %rax # local variable "newlen"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  pushq $0 # number literal
  popq %rcx # low
  popq %rax # high
  subq %rcx, %rax # high - low
  pushq %rax # new len
  pushq $0 # number literal
  leaq 16(%rbp), %rax # local variable "old"
  pushq %rax # variable address
  popq %rax # address of T_SLICE
  movq 16(%rax), %rdx
  movq 8(%rax), %rcx
  movq 0(%rax), %rax
  pushq %rdx # cap
  pushq %rcx # len
  pushq %rax # ptr
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  pushq %rax # slice.ptr
  popq %rax # address of list head
  popq %rcx # index id
  movq $16, %rdx # elm size
  imulq %rdx, %rcx
  addq %rcx, %rax
  pushq %rax # addr of element
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  movq %rdx, 16(%rsi) # cap to cap
  jmp .L.endif.49
  .L.else.49:
  leaq -56(%rbp), %rax # local variable "newcap"
  pushq %rax # variable address
  pushq $0 # T_INT zero value (number)
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -40(%rbp), %rax # local variable "oldlen"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  pushq $0 # number literal
  popq %rcx # right
  popq %rax # left
  cmpq %rcx, %rax
  sete %al
  movzbq %al, %rax
  pushq %rax
  popq %rax # result of if condition
  cmpq $1, %rax
  jne .L.else.50 # jmp if false
  leaq -56(%rbp), %rax # local variable "newcap"
  pushq %rax # variable address
  pushq $1 # number literal
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  jmp .L.endif.50
  .L.else.50:
  leaq -56(%rbp), %rax # local variable "newcap"
  pushq %rax # variable address
  leaq -40(%rbp), %rax # local variable "oldlen"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  pushq $2 # number literal
  popq %rcx # right
  popq %rax # left
  imulq %rcx, %rax
  pushq %rax
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  .L.endif.50:
  leaq -24(%rbp), %rax # local variable "new_"
  pushq %rax # variable address
  subq $24, %rsp # alloc return vars area
  subq $24, %rsp # alloc parameters area
  leaq -32(%rbp), %rax # local variable "elmSize"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rax # result of T_INT
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -48(%rbp), %rax # local variable "newlen"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rax # result of T_INT
  leaq 8(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -56(%rbp), %rax # local variable "newcap"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rax # result of T_INT
  leaq 16(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  callq runtime.makeSlice
  addq $24, %rsp # free parameters area
  #  totalReturnSize=24
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  movq %rdx, 16(%rsi) # cap to cap
  leaq -64(%rbp), %rax # local variable "oldSize"
  pushq %rax # variable address
  leaq -40(%rbp), %rax # local variable "oldlen"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  leaq -32(%rbp), %rax # local variable "elmSize"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rcx # right
  popq %rax # left
  imulq %rcx, %rax
  pushq %rax
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -40(%rbp), %rax # local variable "oldlen"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  pushq $0 # number literal
  popq %rcx # right
  popq %rax # left
  cmpq %rcx, %rax
  setg %al
  movzbq %al, %rax
  pushq %rax
  popq %rax # result of if condition
  cmpq $1, %rax
  jne .L.endif.51 # jmp if false
  subq $24, %rsp # alloc parameters area
  pushq $0 # number literal
  leaq 16(%rbp), %rax # local variable "old"
  pushq %rax # variable address
  popq %rax # address of T_SLICE
  movq 16(%rax), %rdx
  movq 8(%rax), %rcx
  movq 0(%rax), %rax
  pushq %rdx # cap
  pushq %rcx # len
  pushq %rax # ptr
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  pushq %rax # slice.ptr
  popq %rax # address of list head
  popq %rcx # index id
  movq $16, %rdx # elm size
  imulq %rdx, %rcx
  addq %rcx, %rax
  pushq %rax # addr of element
  popq %rax # result of T_UINTPTR
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  pushq $0 # number literal
  leaq -24(%rbp), %rax # local variable "new_"
  pushq %rax # variable address
  popq %rax # address of T_SLICE
  movq 16(%rax), %rdx
  movq 8(%rax), %rcx
  movq 0(%rax), %rax
  pushq %rdx # cap
  pushq %rcx # len
  pushq %rax # ptr
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  pushq %rax # slice.ptr
  popq %rax # address of list head
  popq %rcx # index id
  movq $16, %rdx # elm size
  imulq %rdx, %rcx
  addq %rcx, %rax
  pushq %rax # addr of element
  popq %rax # result of T_UINTPTR
  leaq 8(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq -64(%rbp), %rax # local variable "oldSize"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rax # result of T_INT
  leaq 16(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  callq runtime.memcopy
  addq $24, %rsp # free parameters area
  #  totalReturnSize=0
  .L.endif.51:
  .L.endif.49:
  leaq -40(%rbp), %rax # local variable "oldlen"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  leaq -24(%rbp), %rax # local variable "new_"
  pushq %rax # variable address
  popq %rax # address of T_SLICE
  movq 16(%rax), %rdx
  movq 8(%rax), %rcx
  movq 0(%rax), %rax
  pushq %rdx # cap
  pushq %rcx # len
  pushq %rax # ptr
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  pushq %rax # slice.ptr
  popq %rax # address of list head
  popq %rcx # index id
  movq $16, %rdx # elm size
  imulq %rdx, %rcx
  addq %rcx, %rax
  pushq %rax # addr of element
  leaq 40(%rbp), %rax # local variable "elm"
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
  leaq 56(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  pushq $0 # number literal
  leaq -24(%rbp), %rax # local variable "new_"
  pushq %rax # variable address
  popq %rax # address of T_SLICE
  movq 16(%rax), %rdx
  movq 8(%rax), %rcx
  movq 0(%rax), %rax
  pushq %rdx # cap
  pushq %rcx # len
  pushq %rax # ptr
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  pushq %rax # slice.ptr
  popq %rax # address of list head
  popq %rcx # index id
  movq $16, %rdx # elm size
  imulq %rdx, %rcx
  addq %rcx, %rax
  pushq %rax # addr of element
  popq %rax # result of T_UINTPTR
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq 64(%rbp), %rax # local variable ".r1"
  pushq %rax # variable address
  leaq -48(%rbp), %rax # local variable "newlen"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq 72(%rbp), %rax # local variable ".r2"
  pushq %rax # variable address
  leaq -24(%rbp), %rax # local variable "new_"
  pushq %rax # variable address
  popq %rax # address of T_SLICE
  movq 16(%rax), %rdx
  movq 8(%rax), %rcx
  movq 0(%rax), %rax
  pushq %rdx # cap
  pushq %rcx # len
  pushq %rax # ptr
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  pushq %rdx # cap
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leave
  ret
  leave
  ret

# Function runtime.append24
.global runtime.append24
runtime.append24: # args 88, locals -64
  pushq %rbp
  movq %rsp, %rbp
  subq $64, %rsp # local area
  leaq -24(%rbp), %rax # local variable "new_"
  pushq %rax # variable address
  pushq $0 # slice cap
  pushq $0 # slice len
  pushq $0 # slice ptr
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  movq %rdx, 16(%rsi) # cap to cap
  leaq -32(%rbp), %rax # local variable "elmSize"
  pushq %rax # variable address
  pushq $24 # number literal
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -40(%rbp), %rax # local variable "oldlen"
  pushq %rax # variable address
  leaq 16(%rbp), %rax # local variable "old"
  pushq %rax # variable address
  popq %rax # address of T_SLICE
  movq 16(%rax), %rdx
  movq 8(%rax), %rcx
  movq 0(%rax), %rax
  pushq %rdx # cap
  pushq %rcx # len
  pushq %rax # ptr
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  pushq %rcx # len
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -48(%rbp), %rax # local variable "newlen"
  pushq %rax # variable address
  leaq -40(%rbp), %rax # local variable "oldlen"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  pushq $1 # number literal
  popq %rcx # right
  popq %rax # left
  addq %rcx, %rax
  pushq %rax
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq 16(%rbp), %rax # local variable "old"
  pushq %rax # variable address
  popq %rax # address of T_SLICE
  movq 16(%rax), %rdx
  movq 8(%rax), %rcx
  movq 0(%rax), %rax
  pushq %rdx # cap
  pushq %rcx # len
  pushq %rax # ptr
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  pushq %rdx # cap
  leaq -48(%rbp), %rax # local variable "newlen"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rcx # right
  popq %rax # left
  cmpq %rcx, %rax
  setge %al
  movzbq %al, %rax
  pushq %rax
  popq %rax # result of if condition
  cmpq $1, %rax
  jne .L.else.52 # jmp if false
  leaq -24(%rbp), %rax # local variable "new_"
  pushq %rax # variable address
  leaq 16(%rbp), %rax # local variable "old"
  pushq %rax # variable address
  popq %rax # address of T_SLICE
  movq 16(%rax), %rdx
  movq 8(%rax), %rcx
  movq 0(%rax), %rax
  pushq %rdx # cap
  pushq %rcx # len
  pushq %rax # ptr
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  pushq %rdx # cap
  pushq $0 # number literal
  popq %rcx # low
  popq %rax # orig_cap
  subq %rcx, %rax # orig_cap - low
  pushq %rax # new cap
  leaq -48(%rbp), %rax # local variable "newlen"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  pushq $0 # number literal
  popq %rcx # low
  popq %rax # high
  subq %rcx, %rax # high - low
  pushq %rax # new len
  pushq $0 # number literal
  leaq 16(%rbp), %rax # local variable "old"
  pushq %rax # variable address
  popq %rax # address of T_SLICE
  movq 16(%rax), %rdx
  movq 8(%rax), %rcx
  movq 0(%rax), %rax
  pushq %rdx # cap
  pushq %rcx # len
  pushq %rax # ptr
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  pushq %rax # slice.ptr
  popq %rax # address of list head
  popq %rcx # index id
  movq $24, %rdx # elm size
  imulq %rdx, %rcx
  addq %rcx, %rax
  pushq %rax # addr of element
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  movq %rdx, 16(%rsi) # cap to cap
  jmp .L.endif.52
  .L.else.52:
  leaq -56(%rbp), %rax # local variable "newcap"
  pushq %rax # variable address
  pushq $0 # T_INT zero value (number)
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -40(%rbp), %rax # local variable "oldlen"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  pushq $0 # number literal
  popq %rcx # right
  popq %rax # left
  cmpq %rcx, %rax
  sete %al
  movzbq %al, %rax
  pushq %rax
  popq %rax # result of if condition
  cmpq $1, %rax
  jne .L.else.53 # jmp if false
  leaq -56(%rbp), %rax # local variable "newcap"
  pushq %rax # variable address
  pushq $1 # number literal
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  jmp .L.endif.53
  .L.else.53:
  leaq -56(%rbp), %rax # local variable "newcap"
  pushq %rax # variable address
  leaq -40(%rbp), %rax # local variable "oldlen"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  pushq $2 # number literal
  popq %rcx # right
  popq %rax # left
  imulq %rcx, %rax
  pushq %rax
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  .L.endif.53:
  leaq -24(%rbp), %rax # local variable "new_"
  pushq %rax # variable address
  subq $24, %rsp # alloc return vars area
  subq $24, %rsp # alloc parameters area
  leaq -32(%rbp), %rax # local variable "elmSize"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rax # result of T_INT
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -48(%rbp), %rax # local variable "newlen"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rax # result of T_INT
  leaq 8(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -56(%rbp), %rax # local variable "newcap"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rax # result of T_INT
  leaq 16(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  callq runtime.makeSlice
  addq $24, %rsp # free parameters area
  #  totalReturnSize=24
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  movq %rdx, 16(%rsi) # cap to cap
  leaq -64(%rbp), %rax # local variable "oldSize"
  pushq %rax # variable address
  leaq -40(%rbp), %rax # local variable "oldlen"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  leaq -32(%rbp), %rax # local variable "elmSize"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rcx # right
  popq %rax # left
  imulq %rcx, %rax
  pushq %rax
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -40(%rbp), %rax # local variable "oldlen"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  pushq $0 # number literal
  popq %rcx # right
  popq %rax # left
  cmpq %rcx, %rax
  setg %al
  movzbq %al, %rax
  pushq %rax
  popq %rax # result of if condition
  cmpq $1, %rax
  jne .L.endif.54 # jmp if false
  subq $24, %rsp # alloc parameters area
  pushq $0 # number literal
  leaq 16(%rbp), %rax # local variable "old"
  pushq %rax # variable address
  popq %rax # address of T_SLICE
  movq 16(%rax), %rdx
  movq 8(%rax), %rcx
  movq 0(%rax), %rax
  pushq %rdx # cap
  pushq %rcx # len
  pushq %rax # ptr
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  pushq %rax # slice.ptr
  popq %rax # address of list head
  popq %rcx # index id
  movq $24, %rdx # elm size
  imulq %rdx, %rcx
  addq %rcx, %rax
  pushq %rax # addr of element
  popq %rax # result of T_UINTPTR
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  pushq $0 # number literal
  leaq -24(%rbp), %rax # local variable "new_"
  pushq %rax # variable address
  popq %rax # address of T_SLICE
  movq 16(%rax), %rdx
  movq 8(%rax), %rcx
  movq 0(%rax), %rax
  pushq %rdx # cap
  pushq %rcx # len
  pushq %rax # ptr
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  pushq %rax # slice.ptr
  popq %rax # address of list head
  popq %rcx # index id
  movq $24, %rdx # elm size
  imulq %rdx, %rcx
  addq %rcx, %rax
  pushq %rax # addr of element
  popq %rax # result of T_UINTPTR
  leaq 8(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq -64(%rbp), %rax # local variable "oldSize"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rax # result of T_INT
  leaq 16(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  callq runtime.memcopy
  addq $24, %rsp # free parameters area
  #  totalReturnSize=0
  .L.endif.54:
  .L.endif.52:
  leaq -40(%rbp), %rax # local variable "oldlen"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  leaq -24(%rbp), %rax # local variable "new_"
  pushq %rax # variable address
  popq %rax # address of T_SLICE
  movq 16(%rax), %rdx
  movq 8(%rax), %rcx
  movq 0(%rax), %rax
  pushq %rdx # cap
  pushq %rcx # len
  pushq %rax # ptr
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  pushq %rax # slice.ptr
  popq %rax # address of list head
  popq %rcx # index id
  movq $24, %rdx # elm size
  imulq %rdx, %rcx
  addq %rcx, %rax
  pushq %rax # addr of element
  leaq 40(%rbp), %rax # local variable "elm"
  pushq %rax # variable address
  popq %rax # address of T_SLICE
  movq 16(%rax), %rdx
  movq 8(%rax), %rcx
  movq 0(%rax), %rax
  pushq %rdx # cap
  pushq %rcx # len
  pushq %rax # ptr
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  movq %rdx, 16(%rsi) # cap to cap
  leaq 64(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  pushq $0 # number literal
  leaq -24(%rbp), %rax # local variable "new_"
  pushq %rax # variable address
  popq %rax # address of T_SLICE
  movq 16(%rax), %rdx
  movq 8(%rax), %rcx
  movq 0(%rax), %rax
  pushq %rdx # cap
  pushq %rcx # len
  pushq %rax # ptr
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  pushq %rax # slice.ptr
  popq %rax # address of list head
  popq %rcx # index id
  movq $24, %rdx # elm size
  imulq %rdx, %rcx
  addq %rcx, %rax
  pushq %rax # addr of element
  popq %rax # result of T_UINTPTR
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq 72(%rbp), %rax # local variable ".r1"
  pushq %rax # variable address
  leaq -48(%rbp), %rax # local variable "newlen"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq 80(%rbp), %rax # local variable ".r2"
  pushq %rax # variable address
  leaq -24(%rbp), %rax # local variable "new_"
  pushq %rax # variable address
  popq %rax # address of T_SLICE
  movq 16(%rax), %rdx
  movq 8(%rax), %rcx
  movq 0(%rax), %rax
  pushq %rdx # cap
  pushq %rcx # len
  pushq %rax # ptr
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  pushq %rdx # cap
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leave
  ret
  leave
  ret

# Function runtime.catstrings
.global runtime.catstrings
runtime.catstrings: # args 64, locals -48
  pushq %rbp
  movq %rsp, %rbp
  subq $48, %rsp # local area
  leaq -8(%rbp), %rax # local variable "totallen"
  pushq %rax # variable address
  leaq 16(%rbp), %rax # local variable "a"
  pushq %rax # variable address
  popq %rax # address of T_STRING
  movq 8(%rax), %rdx # len
  movq 0(%rax), %rax # ptr
  pushq %rdx # len
  pushq %rax # ptr
  popq %rax # string.ptr
  popq %rcx # string.len
  pushq %rcx # len
  leaq 32(%rbp), %rax # local variable "b"
  pushq %rax # variable address
  popq %rax # address of T_STRING
  movq 8(%rax), %rdx # len
  movq 0(%rax), %rax # ptr
  pushq %rdx # len
  pushq %rax # ptr
  popq %rax # string.ptr
  popq %rcx # string.len
  pushq %rcx # len
  popq %rcx # right
  popq %rax # left
  addq %rcx, %rax
  pushq %rax
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -32(%rbp), %rax # local variable "r"
  pushq %rax # variable address
  subq $24, %rsp # alloc return vars area
  subq $24, %rsp # alloc parameters area
  pushq $1 # number literal
  popq %rax # result of T_INT
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -8(%rbp), %rax # local variable "totallen"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rax # result of T_INT
  leaq 8(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -8(%rbp), %rax # local variable "totallen"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  pushq $1 # number literal
  popq %rcx # right
  popq %rax # left
  addq %rcx, %rax
  pushq %rax
  popq %rax # result of T_INT
  leaq 16(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  callq runtime.makeSlice
  addq $24, %rsp # free parameters area
  #  totalReturnSize=24
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  movq %rdx, 16(%rsi) # cap to cap
  leaq -40(%rbp), %rax # local variable "i"
  pushq %rax # variable address
  pushq $0 # T_INT zero value (number)
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -40(%rbp), %rax # local variable "i"
  pushq %rax # variable address
  pushq $0 # number literal
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  .L.for.cond.55:
  leaq -40(%rbp), %rax # local variable "i"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  leaq 16(%rbp), %rax # local variable "a"
  pushq %rax # variable address
  popq %rax # address of T_STRING
  movq 8(%rax), %rdx # len
  movq 0(%rax), %rax # ptr
  pushq %rdx # len
  pushq %rax # ptr
  popq %rax # string.ptr
  popq %rcx # string.len
  pushq %rcx # len
  popq %rcx # right
  popq %rax # left
  cmpq %rcx, %rax
  setl %al
  movzbq %al, %rax
  pushq %rax
  popq %rax # result of for condition
  cmpq $1, %rax
  jne .L.for.exit.55 # jmp if false
  leaq -40(%rbp), %rax # local variable "i"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  leaq -32(%rbp), %rax # local variable "r"
  pushq %rax # variable address
  popq %rax # address of T_SLICE
  movq 16(%rax), %rdx
  movq 8(%rax), %rcx
  movq 0(%rax), %rax
  pushq %rdx # cap
  pushq %rcx # len
  pushq %rax # ptr
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  pushq %rax # slice.ptr
  popq %rax # address of list head
  popq %rcx # index id
  movq $1, %rdx # elm size
  imulq %rdx, %rcx
  addq %rcx, %rax
  pushq %rax # addr of element
  leaq -40(%rbp), %rax # local variable "i"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  leaq 16(%rbp), %rax # local variable "a"
  pushq %rax # variable address
  popq %rax # address of T_STRING
  movq 8(%rax), %rdx # len
  movq 0(%rax), %rax # ptr
  pushq %rdx # len
  pushq %rax # ptr
  popq %rax # string.ptr
  popq %rcx # string.len
  pushq %rax # string.ptr
  popq %rax # address of list head
  popq %rcx # index id
  movq $1, %rdx # elm size
  imulq %rdx, %rcx
  addq %rcx, %rax
  pushq %rax # addr of element
  popq %rax # address of T_UINT8
  movzbq 0(%rax), %rax # load uint8
  pushq %rax
  popq %rax # result of T_UINT8
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movb %al, 0(%rsi) # assign byte
  .L.for.post.55:
  leaq -40(%rbp), %rax # local variable "i"
  pushq %rax # variable address
  leaq -40(%rbp), %rax # local variable "i"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  pushq $1 # number literal
  popq %rcx # right
  popq %rax # left
  addq %rcx, %rax
  pushq %rax
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  jmp .L.for.cond.55
  .L.for.exit.55:
  leaq -48(%rbp), %rax # local variable "j"
  pushq %rax # variable address
  pushq $0 # T_INT zero value (number)
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -48(%rbp), %rax # local variable "j"
  pushq %rax # variable address
  pushq $0 # number literal
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  .L.for.cond.56:
  leaq -48(%rbp), %rax # local variable "j"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  leaq 32(%rbp), %rax # local variable "b"
  pushq %rax # variable address
  popq %rax # address of T_STRING
  movq 8(%rax), %rdx # len
  movq 0(%rax), %rax # ptr
  pushq %rdx # len
  pushq %rax # ptr
  popq %rax # string.ptr
  popq %rcx # string.len
  pushq %rcx # len
  popq %rcx # right
  popq %rax # left
  cmpq %rcx, %rax
  setl %al
  movzbq %al, %rax
  pushq %rax
  popq %rax # result of for condition
  cmpq $1, %rax
  jne .L.for.exit.56 # jmp if false
  leaq -40(%rbp), %rax # local variable "i"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  leaq -48(%rbp), %rax # local variable "j"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rcx # right
  popq %rax # left
  addq %rcx, %rax
  pushq %rax
  leaq -32(%rbp), %rax # local variable "r"
  pushq %rax # variable address
  popq %rax # address of T_SLICE
  movq 16(%rax), %rdx
  movq 8(%rax), %rcx
  movq 0(%rax), %rax
  pushq %rdx # cap
  pushq %rcx # len
  pushq %rax # ptr
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  pushq %rax # slice.ptr
  popq %rax # address of list head
  popq %rcx # index id
  movq $1, %rdx # elm size
  imulq %rdx, %rcx
  addq %rcx, %rax
  pushq %rax # addr of element
  leaq -48(%rbp), %rax # local variable "j"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  leaq 32(%rbp), %rax # local variable "b"
  pushq %rax # variable address
  popq %rax # address of T_STRING
  movq 8(%rax), %rdx # len
  movq 0(%rax), %rax # ptr
  pushq %rdx # len
  pushq %rax # ptr
  popq %rax # string.ptr
  popq %rcx # string.len
  pushq %rax # string.ptr
  popq %rax # address of list head
  popq %rcx # index id
  movq $1, %rdx # elm size
  imulq %rdx, %rcx
  addq %rcx, %rax
  pushq %rax # addr of element
  popq %rax # address of T_UINT8
  movzbq 0(%rax), %rax # load uint8
  pushq %rax
  popq %rax # result of T_UINT8
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movb %al, 0(%rsi) # assign byte
  .L.for.post.56:
  leaq -48(%rbp), %rax # local variable "j"
  pushq %rax # variable address
  leaq -48(%rbp), %rax # local variable "j"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  pushq $1 # number literal
  popq %rcx # right
  popq %rax # left
  addq %rcx, %rax
  pushq %rax
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  jmp .L.for.cond.56
  .L.for.exit.56:
  leaq 48(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  leaq -32(%rbp), %rax # local variable "r"
  pushq %rax # variable address
  popq %rax # address of T_SLICE
  movq 16(%rax), %rdx
  movq 8(%rax), %rcx
  movq 0(%rax), %rax
  pushq %rdx # cap
  pushq %rcx # len
  pushq %rax # ptr
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  pushq %rcx # str len
  pushq %rax # str ptr
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

# Function runtime.cmpstrings
.global runtime.cmpstrings
runtime.cmpstrings: # args 56, locals -8
  pushq %rbp
  movq %rsp, %rbp
  subq $8, %rsp # local area
  leaq 16(%rbp), %rax # local variable "a"
  pushq %rax # variable address
  popq %rax # address of T_STRING
  movq 8(%rax), %rdx # len
  movq 0(%rax), %rax # ptr
  pushq %rdx # len
  pushq %rax # ptr
  popq %rax # string.ptr
  popq %rcx # string.len
  pushq %rcx # len
  leaq 32(%rbp), %rax # local variable "b"
  pushq %rax # variable address
  popq %rax # address of T_STRING
  movq 8(%rax), %rdx # len
  movq 0(%rax), %rax # ptr
  pushq %rdx # len
  pushq %rax # ptr
  popq %rax # string.ptr
  popq %rcx # string.len
  pushq %rcx # len
  popq %rcx # right
  popq %rax # left
  cmpq %rcx, %rax
  sete %al
  movzbq %al, %rax
  pushq %rax
  popq %rax # result of 
  xor $1, %rax
  pushq %rax
  popq %rax # result of if condition
  cmpq $1, %rax
  jne .L.endif.57 # jmp if false
  leaq 48(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  pushq $0 # false
  popq %rax # result of T_BOOL
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leave
  ret
  .L.endif.57:
  leaq -8(%rbp), %rax # local variable "i"
  pushq %rax # variable address
  pushq $0 # T_INT zero value (number)
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -8(%rbp), %rax # local variable "i"
  pushq %rax # variable address
  pushq $0 # number literal
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  .L.for.cond.58:
  leaq -8(%rbp), %rax # local variable "i"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  leaq 16(%rbp), %rax # local variable "a"
  pushq %rax # variable address
  popq %rax # address of T_STRING
  movq 8(%rax), %rdx # len
  movq 0(%rax), %rax # ptr
  pushq %rdx # len
  pushq %rax # ptr
  popq %rax # string.ptr
  popq %rcx # string.len
  pushq %rcx # len
  popq %rcx # right
  popq %rax # left
  cmpq %rcx, %rax
  setl %al
  movzbq %al, %rax
  pushq %rax
  popq %rax # result of for condition
  cmpq $1, %rax
  jne .L.for.exit.58 # jmp if false
  leaq -8(%rbp), %rax # local variable "i"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  leaq 16(%rbp), %rax # local variable "a"
  pushq %rax # variable address
  popq %rax # address of T_STRING
  movq 8(%rax), %rdx # len
  movq 0(%rax), %rax # ptr
  pushq %rdx # len
  pushq %rax # ptr
  popq %rax # string.ptr
  popq %rcx # string.len
  pushq %rax # string.ptr
  popq %rax # address of list head
  popq %rcx # index id
  movq $1, %rdx # elm size
  imulq %rdx, %rcx
  addq %rcx, %rax
  pushq %rax # addr of element
  popq %rax # address of T_UINT8
  movzbq 0(%rax), %rax # load uint8
  pushq %rax
  leaq -8(%rbp), %rax # local variable "i"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  leaq 32(%rbp), %rax # local variable "b"
  pushq %rax # variable address
  popq %rax # address of T_STRING
  movq 8(%rax), %rdx # len
  movq 0(%rax), %rax # ptr
  pushq %rdx # len
  pushq %rax # ptr
  popq %rax # string.ptr
  popq %rcx # string.len
  pushq %rax # string.ptr
  popq %rax # address of list head
  popq %rcx # index id
  movq $1, %rdx # elm size
  imulq %rdx, %rcx
  addq %rcx, %rax
  pushq %rax # addr of element
  popq %rax # address of T_UINT8
  movzbq 0(%rax), %rax # load uint8
  pushq %rax
  popq %rcx # right
  popq %rax # left
  cmpq %rcx, %rax
  sete %al
  movzbq %al, %rax
  pushq %rax
  popq %rax # result of 
  xor $1, %rax
  pushq %rax
  popq %rax # result of if condition
  cmpq $1, %rax
  jne .L.endif.59 # jmp if false
  leaq 48(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  pushq $0 # false
  popq %rax # result of T_BOOL
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leave
  ret
  .L.endif.59:
  .L.for.post.58:
  leaq -8(%rbp), %rax # local variable "i"
  pushq %rax # variable address
  leaq -8(%rbp), %rax # local variable "i"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rax
  addq $1, %rax
  pushq %rax
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  jmp .L.for.cond.58
  .L.for.exit.58:
  leaq 48(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  pushq $1 # true
  popq %rax # result of T_BOOL
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leave
  ret
  leave
  ret

# Function runtime.cmpinterface
.global runtime.cmpinterface
runtime.cmpinterface: # args 56, locals 0
  pushq %rbp
  movq %rsp, %rbp
  leaq 16(%rbp), %rax # local variable "a"
  pushq %rax # variable address
  popq %rax # address of T_UINTPTR
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  leaq 32(%rbp), %rax # local variable "c"
  pushq %rax # variable address
  popq %rax # address of T_UINTPTR
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rcx # right
  popq %rax # left
  cmpq %rcx, %rax
  sete %al
  movzbq %al, %rax
  pushq %rax
  popq %rax # result of left
  cmpq $1, %rax
  jne .L.61.false
  leaq 24(%rbp), %rax # local variable "b"
  pushq %rax # variable address
  popq %rax # address of T_UINTPTR
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  leaq 40(%rbp), %rax # local variable "d"
  pushq %rax # variable address
  popq %rax # address of T_UINTPTR
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rcx # right
  popq %rax # left
  cmpq %rcx, %rax
  sete %al
  movzbq %al, %rax
  pushq %rax
  jmp .L.61.exit
  .L.61.false:
  pushq $0 # false
  .L.61.exit:
  popq %rax # result of if condition
  cmpq $1, %rax
  jne .L.endif.60 # jmp if false
  leaq 48(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  pushq $1 # true
  popq %rax # result of T_BOOL
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leave
  ret
  .L.endif.60:
  leaq 48(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  pushq $0 # false
  popq %rax # result of T_BOOL
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leave
  ret
  leave
  ret
# ------- Dynamic Types ------
.data
.dtype.1: # string
  .quad 1
  .quad .string.dtype.1
  .quad 6
.string.dtype.1:
  .string "string"
.dtype.2: # unsafe.Pointer
  .quad 2
  .quad .string.dtype.2
  .quad 14
.string.dtype.2:
  .string "unsafe.Pointer"


# === static assembly /root/go/src/github.com/DQNEO/babygo/src/runtime/asm_amd64.s ====
.data

runtime.mainPC:
  .quad runtime.main

.text

runtime.rt0_go:
  # copy arguments
  movq %rdi, %rax # argc
  movq %rsi, %rbx # argv
  subq $32, %rsp
  movq %rax, 16(%rsp) # argc
  movq %rbx, 24(%rsp) # argv

  movq 16(%rsp), %rax  # copy argc
  movq %rax, 0(%rsp)
  movq 24(%rsp), %rax  # copy argv
  movq %rax, 8(%rsp)
  callq runtime.args

  addq $32, %rsp

  movq %rdi, %rax # argc
  imulq $8,  %rax # argc * 8
  addq %rsp, %rax # stack top addr + (argc * 8)
  addq $16,  %rax # + 16 (skip null and go to next) => envp
  movq %rax, runtime.envp+0(%rip) # envp

  # register main_main
  leaq main.main(%rip), %rax
  movq %rax, runtime.main_main(%rip)

  callq runtime.__initGlobals
  callq runtime.schedinit
  callq main.__initGlobals
  callq os.init # set os.Args

  // wrapper to runtime.main
  leaq runtime.mainPC(%rip), %rax # entry
  pushq %rax
  pushq $0 # arg size
  callq runtime.newproc
  popq %rax
  popq %rax

  callq runtime.newosproc
  callq runtime.mstart
  ret # not reached

runtime.mstart:
  callq runtime.mstart0
  ret # not reached

runtime.exit:
  movq 8(%rsp), %rdi  # status
  movq $231, %rax # exit_group
  syscall

runtime.exitThread:
  movq $0, %rdi  # status
  movq $60, %rax # exit
  syscall

# === static assembly /root/go/src/github.com/DQNEO/babygo/src/runtime/rt0_linux_amd64.s ====
.text

.global _start
.global _rt0_amd64_linux

# Start of the program
_start:
_rt0_amd64_linux:
  jmp _rt0_amd64

# === static assembly /root/go/src/github.com/DQNEO/babygo/src/runtime/runtime.s ====
# runtime.s
.text

# (runtime/asm_amd64.s)
_rt0_amd64:
  movq 0(%rsp), %rdi # argc
  leaq 8(%rsp), %rsi # argv
  jmp runtime.rt0_go


// func Write(fd int, p []byte) int
.global runtime.Write
runtime.Write:
  movq  8(%rsp), %rax # arg0:fd
  movq 16(%rsp), %rdi # arg1:ptr
  movq 24(%rsp), %rsi # arg2:len
  subq $8, %rsp
  pushq %rsi
  pushq %rdi
  pushq %rax
  pushq $1  # sys_write
  callq runtime.Syscall
  addq $8 * 4, %rsp # reset args area
  popq %rax # retval
  movq %rax, 32(%rsp) # r0 int
  ret

.global runtime.printstring
runtime.printstring:
  movq  8(%rsp), %rdi # arg0:ptr
  movq 16(%rsp), %rsi # arg1:len
  subq $8, %rsp
  pushq %rsi
  pushq %rdi
  pushq $2 # stderr
  pushq $1 # sys_write
  callq runtime.Syscall
  addq $8 * 4, %rsp
  popq %rax # retval
  ret

// func futex(addr unsafe.Pointer, op int, val int)
runtime.futex:
  # https://man7.org/linux/man-pages/man2/futex.2.html
  # long futex(uint32_t *uaddr, int futex_op, uint32_t val,
  #                      const struct timespec *timeout,   /* or: uint32_t val2 */
  #                     uint32_t *uaddr2, uint32_t val3);
  # The uaddr : On all platforms, futexes are four-byte integers that must be aligned on a four-byte boundary.
  movq 8(%rsp), %rdi
  movq 16(%rsp), %rsi
  movq 24(%rsp), %rdx
  movq $0, %r10
  movq $0, %r8
  movq $0, %r9
  movq $202, %rax
  syscall
  ret

# see https://man7.org/linux/man-pages/man2/clone.2.html
#  long clone(
#       unsigned long flags,
#       void *stack,
#       int *parent_tid,
#       int *child_tid,
#       unsigned long tls);

// func clone(flags int, stack uintptr, fn func())
runtime.clone:
  movq 24(%rsp), %r12
  movl $56, %eax # sys_clone
  movq 8(%rsp), %rdi # flags
  movq 16(%rsp), %rsi # stack
  movq $0, %rdx # ptid
  movq $0, %r10 # chtid
  movq $0, %r8 # tls
  syscall

  cmpq $0, %rax # rax is pid for parent, 0 for child
  je .L.child # jump if child

  ret # return if parent

.L.child:
  movq %rsi , %rsp # start from new stack
  callq *%r12
  ret

// func Syscall(trap, a1, a2, a3 uintptr) uintptr
.global runtime.Syscall
runtime.Syscall:
  movq   8(%rsp), %rax # syscall number
  movq  16(%rsp), %rdi # arg0
  movq  24(%rsp), %rsi # arg1
  movq  32(%rsp), %rdx # arg2
  syscall
  movq %rax, 40(%rsp) # r0 uintptr
  ret

// func Syscall(trap, a1, a2, a3 uintptr) uintptr
.global syscall.Syscall
syscall.Syscall:
  movq   8(%rsp), %rax # syscall number
  movq  16(%rsp), %rdi # arg0
  movq  24(%rsp), %rsi # arg1
  movq  32(%rsp), %rdx # arg2
  syscall
  movq %rax, 40(%rsp) # r0 uintptr
  ret

