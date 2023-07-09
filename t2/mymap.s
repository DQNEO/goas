#=== Package github.com/DQNEO/babygo/lib/mymap
#--- walk 
# Package types:
# type mymap.Map struct{first *mymap.item;length int;}
# type mymap.item struct{key interface{};Value interface{};next *mymap.item;}
#--- string literals
.data
.string_0:
  .string "Not supported key type"
.string_1:
  .string "Not supported key type"
#--- global vars (static values)

#--- global vars (dynamic value setting)
.text
.global mymap.__initGlobals
mymap.__initGlobals:
  ret

# Method mymap.$item.Next
.global mymap.$item.Next
mymap.$item.Next: # args 32, locals 0
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
  addq $32, %rax
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

# Method mymap.$item.GetKeyAsString
.global mymap.$item.GetKeyAsString
mymap.$item.GetKeyAsString: # args 40, locals 0
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
  addq $0, %rax
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
  je .L.cmpdtypes.74.true # jump if match
  cmpq $0, %rdx # check if A is nil
  je .L.cmpdtypes.74.false # jump if nil
  cmpq $0, %rcx # check if B is nil
  je .L.cmpdtypes.74.false # jump if nil
  jmp .L.cmpdtypes.74.cmp # jump to end
  .L.cmpdtypes.74.true:
  pushq $1
  jmp .L.cmpdtypes.74.end # jump to end
  .L.cmpdtypes.74.false:
  pushq $0
  jmp .L.cmpdtypes.74.end # jump to end
  .L.cmpdtypes.74.cmp:
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
  .L.cmpdtypes.74.end:
  popq %rax # result of type assertion ok value
  cmpq $1, %rax
  jne .L.unmatch.75 # jmp if false
  popq %rax # address of T_STRING
  movq 8(%rax), %rdx # len
  movq 0(%rax), %rax # ptr
  pushq %rdx # len
  pushq %rax # ptr
  jmp .L.end_type_assertion.75
  .L.unmatch.75:
  popq %rax # drop ifc.data
  pushq $0 # string len
  pushq $0 # string ptr
  .L.end_type_assertion.75:
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

# Method mymap.$item.match
.global mymap.$item.match
mymap.$item.match: # args 48, locals -40
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
  je .L.cmpdtypes.78.true # jump if match
  cmpq $0, %rdx # check if A is nil
  je .L.cmpdtypes.78.false # jump if nil
  cmpq $0, %rcx # check if B is nil
  je .L.cmpdtypes.78.false # jump if nil
  jmp .L.cmpdtypes.78.cmp # jump to end
  .L.cmpdtypes.78.true:
  pushq $1
  jmp .L.cmpdtypes.78.end # jump to end
  .L.cmpdtypes.78.false:
  pushq $0
  jmp .L.cmpdtypes.78.end # jump to end
  .L.cmpdtypes.78.cmp:
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
  .L.cmpdtypes.78.end:
  popq %rax # result of  of switch-case comparison
  cmpq $1, %rax
  je .L.case.77 # jump if match
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
  je .L.cmpdtypes.80.true # jump if match
  cmpq $0, %rdx # check if A is nil
  je .L.cmpdtypes.80.false # jump if nil
  cmpq $0, %rcx # check if B is nil
  je .L.cmpdtypes.80.false # jump if nil
  jmp .L.cmpdtypes.80.cmp # jump to end
  .L.cmpdtypes.80.true:
  pushq $1
  jmp .L.cmpdtypes.80.end # jump to end
  .L.cmpdtypes.80.false:
  pushq $0
  jmp .L.cmpdtypes.80.end # jump to end
  .L.cmpdtypes.80.cmp:
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
  .L.cmpdtypes.80.end:
  popq %rax # result of  of switch-case comparison
  cmpq $1, %rax
  je .L.case.79 # jump if match
  jmp .L.case.81
  .L.case.77:
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
  addq $0, %rax
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
  je .L.cmpdtypes.82.true # jump if match
  cmpq $0, %rdx # check if A is nil
  je .L.cmpdtypes.82.false # jump if nil
  cmpq $0, %rcx # check if B is nil
  je .L.cmpdtypes.82.false # jump if nil
  jmp .L.cmpdtypes.82.cmp # jump to end
  .L.cmpdtypes.82.true:
  pushq $1
  jmp .L.cmpdtypes.82.end # jump to end
  .L.cmpdtypes.82.false:
  pushq $0
  jmp .L.cmpdtypes.82.end # jump to end
  .L.cmpdtypes.82.cmp:
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
  .L.cmpdtypes.82.end:
  popq %rax # result of type assertion ok value
  cmpq $1, %rax
  jne .L.unmatch.83 # jmp if false
  popq %rax # address of T_STRING
  movq 8(%rax), %rdx # len
  movq 0(%rax), %rax # ptr
  pushq %rdx # len
  pushq %rax # ptr
  jmp .L.end_type_assertion.83
  .L.unmatch.83:
  popq %rax # drop ifc.data
  pushq $0 # string len
  pushq $0 # string ptr
  .L.end_type_assertion.83:
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
  jmp .L.typeswitch.76.exit
  .L.case.79:
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
  addq $0, %rax
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
  je .L.cmpdtypes.84.true # jump if match
  cmpq $0, %rdx # check if A is nil
  je .L.cmpdtypes.84.false # jump if nil
  cmpq $0, %rcx # check if B is nil
  je .L.cmpdtypes.84.false # jump if nil
  jmp .L.cmpdtypes.84.cmp # jump to end
  .L.cmpdtypes.84.true:
  pushq $1
  jmp .L.cmpdtypes.84.end # jump to end
  .L.cmpdtypes.84.false:
  pushq $0
  jmp .L.cmpdtypes.84.end # jump to end
  .L.cmpdtypes.84.cmp:
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
  .L.cmpdtypes.84.end:
  popq %rax # result of type assertion ok value
  cmpq $1, %rax
  jne .L.unmatch.85 # jmp if false
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  jmp .L.end_type_assertion.85
  .L.unmatch.85:
  popq %rax # drop ifc.data
  pushq $0 # T_POINTER zero value (nil pointer)
  .L.end_type_assertion.85:
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
  jmp .L.typeswitch.76.exit
  .L.case.81:
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
  jmp .L.typeswitch.76.exit
  .L.typeswitch.76.exit:
  subq $16, %rsp # alloc parameters area
  pushq $22 # str len
  leaq .string_1(%rip), %rax # str ptr
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
  leave
  ret

# Method mymap.$Map.Len
.global mymap.$Map.Len
mymap.$Map.Len: # args 32, locals 0
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

# Method mymap.$Map.First
.global mymap.$Map.First
mymap.$Map.First: # args 32, locals 0
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
  leave
  ret
  leave
  ret

# Method mymap.$Map.Get
.global mymap.$Map.Get
mymap.$Map.Get: # args 64, locals -8
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
  .L.for.cond.86:
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
  jne .L.for.exit.86 # jmp if false
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
  callq mymap.$item.match
  addq $24, %rsp # free parameters area
  #  totalReturnSize=8
  popq %rax # result of if condition
  cmpq $1, %rax
  jne .L.endif.87 # jmp if false
  leaq 40(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  leaq -8(%rbp), %rax # local variable "item"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax
  addq $16, %rax
  pushq %rax
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
  leaq 56(%rbp), %rax # local variable ".r1"
  pushq %rax # variable address
  pushq $1 # true
  popq %rax # result of T_BOOL
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leave
  ret
  .L.endif.87:
  .L.for.post.86:
  leaq -8(%rbp), %rax # local variable "item"
  pushq %rax # variable address
  leaq -8(%rbp), %rax # local variable "item"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax
  addq $32, %rax
  pushq %rax
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  jmp .L.for.cond.86
  .L.for.exit.86:
  leaq 40(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  pushq $0 # interface data
  pushq $0 # interface dtype
  popq %rax # eface.dtype
  popq %rcx # eface.data
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # store dtype
  movq %rcx, 8(%rsi) # store data
  leaq 56(%rbp), %rax # local variable ".r1"
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

# Method mymap.$Map.Delete
.global mymap.$Map.Delete
mymap.$Map.Delete: # args 40, locals -16
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
  jne .L.endif.88 # jmp if false
  leave
  ret
  .L.endif.88:
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
  callq mymap.$item.match
  addq $24, %rsp # free parameters area
  #  totalReturnSize=8
  popq %rax # result of if condition
  cmpq $1, %rax
  jne .L.endif.89 # jmp if false
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
  addq $32, %rax
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
  .L.endif.89:
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
  .L.for.cond.90:
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
  jne .L.for.exit.90 # jmp if false
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
  callq mymap.$item.match
  addq $24, %rsp # free parameters area
  #  totalReturnSize=8
  popq %rax # result of if condition
  cmpq $1, %rax
  jne .L.endif.91 # jmp if false
  leaq -8(%rbp), %rax # local variable "prev"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax
  addq $32, %rax
  pushq %rax
  leaq -16(%rbp), %rax # local variable "item"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax
  addq $32, %rax
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
  .L.endif.91:
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
  .L.for.post.90:
  leaq -16(%rbp), %rax # local variable "item"
  pushq %rax # variable address
  leaq -16(%rbp), %rax # local variable "item"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax
  addq $32, %rax
  pushq %rax
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  jmp .L.for.cond.90
  .L.for.exit.90:
  leave
  ret

# Method mymap.$Map.Set
.global mymap.$Map.Set
mymap.$Map.Set: # args 56, locals -24
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
  .L.for.cond.92:
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
  jne .L.for.exit.92 # jmp if false
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
  callq mymap.$item.match
  addq $24, %rsp # free parameters area
  #  totalReturnSize=8
  popq %rax # result of if condition
  cmpq $1, %rax
  jne .L.endif.93 # jmp if false
  leaq -16(%rbp), %rax # local variable "item"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax
  addq $16, %rax
  pushq %rax
  leaq 40(%rbp), %rax # local variable "value"
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
  leave
  ret
  .L.endif.93:
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
  .L.for.post.92:
  leaq -16(%rbp), %rax # local variable "item"
  pushq %rax # variable address
  leaq -16(%rbp), %rax # local variable "item"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax
  addq $32, %rax
  pushq %rax
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  jmp .L.for.cond.92
  .L.for.exit.92:
  leaq -24(%rbp), %rax # local variable "newItem"
  pushq %rax # variable address
  subq $8, %rsp # alloc return vars area
  pushq $40
  callq runtime.malloc
  addq $8, %rsp # free parameters area
  #  totalReturnSize=8
  movq 0(%rsp), %rax # copy stack top value (address of struct heaad) 
  pushq %rax
  popq %rax
  addq $0, %rax
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
  addq $16, %rax
  pushq %rax
  leaq 40(%rbp), %rax # local variable "value"
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
  jne .L.else.94 # jmp if false
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
  jmp .L.endif.94
  .L.else.94:
  leaq -8(%rbp), %rax # local variable "last"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax
  addq $32, %rax
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
  .L.endif.94:
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


