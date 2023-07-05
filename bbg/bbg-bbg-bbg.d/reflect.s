#=== Package reflect
#--- walk 
# Package types:
# type reflect.Type struct{typ *reflect.rtype;}
# type reflect.emptyInterface struct{typ *reflect.rtype;data unsafe.Pointer;}
# type reflect.rtype struct{id int;name string;}
#--- string literals
.data
#--- global vars (static values)

#--- global vars (dynamic value setting)
.text
.global reflect.__initGlobals
reflect.__initGlobals:
  ret

# Function reflect.TypeOf
.global reflect.TypeOf
reflect.TypeOf: # args 40, locals -8
  pushq %rbp
  movq %rsp, %rbp
  subq $8, %rsp # local area
  leaq -8(%rbp), %rax # local variable "eface"
  pushq %rax # variable address
  leaq 16(%rbp), %rax # local variable "x"
  pushq %rax # variable address
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq 32(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  subq $8, %rsp # alloc return vars area
  pushq $8
  callq runtime.malloc
  addq $8, %rsp # free parameters area
  #  totalReturnSize=8
  movq 0(%rsp), %rax # copy stack top value (address of struct heaad) 
  pushq %rax
  popq %rax
  addq $0, %rax
  pushq %rax
  leaq -8(%rbp), %rax # local variable "eface"
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
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leave
  ret
  leave
  ret

# Method reflect.$Type.String
.global reflect.$Type.String
reflect.$Type.String: # args 40, locals 0
  pushq %rbp
  movq %rsp, %rbp
  leaq 24(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  subq $16, %rsp # alloc return vars area
  subq $8, %rsp # alloc parameters area
  leaq 16(%rbp), %rax # local variable "t"
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
  callq reflect.$rtype.String
  addq $8, %rsp # free parameters area
  #  totalReturnSize=16
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

# Method reflect.$rtype.String
.global reflect.$rtype.String
reflect.$rtype.String: # args 40, locals 0
  pushq %rbp
  movq %rsp, %rbp
  leaq 24(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  leaq 16(%rbp), %rax # local variable "t"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax
  addq $8, %rax
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
  leave
  ret
# ------- Dynamic Types ------
.data


