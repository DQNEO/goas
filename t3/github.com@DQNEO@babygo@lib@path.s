#=== Package github.com/DQNEO/babygo/lib/path
#--- walk 
# Package types:
#--- string literals
.data
.string_0:
  .string "."
.string_1:
  .string "/"
.string_2:
  .string "/"
.string_3:
  .string "."
.string_4:
  .string "/"
.string_5:
  .string "/"
#--- global vars (static values)

#--- global vars (dynamic value setting)
.text
.global path.__initGlobals
path.__initGlobals:
  ret

# Function path.Dir
.global path.Dir
path.Dir: # args 48, locals -8
  pushq %rbp
  movq %rsp, %rbp
  subq $8, %rsp # local area
  leaq 16(%rbp), %rax # local variable "path"
  pushq %rax # variable address
  popq %rax # address of T_STRING
  movq 8(%rax), %rdx # len
  movq 0(%rax), %rax # ptr
  pushq %rdx # len
  pushq %rax # ptr
  popq %rax # string.ptr
  popq %rcx # string.len
  pushq %rcx # len
  pushq $0 # number literal
  popq %rcx # right
  popq %rax # left
  cmpq %rcx, %rax
  sete %al
  movzbq %al, %rax
  pushq %rax
  popq %rax # result of if condition
  cmpq $1, %rax
  jne .L.endif.104 # jmp if false
  leaq 32(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  pushq $1 # str len
  leaq .string_0(%rip), %rax # str ptr
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
  .L.endif.104:
  subq $8, %rsp # alloc return vars area
  subq $32, %rsp # alloc parameters area
  leaq 16(%rbp), %rax # local variable "path"
  pushq %rax # variable address
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
  pushq $1 # str len
  leaq .string_1(%rip), %rax # str ptr
  pushq %rax # str ptr
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
  jne .L.endif.105 # jmp if false
  leaq 32(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  pushq $1 # str len
  leaq .string_2(%rip), %rax # str ptr
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
  .L.endif.105:
  leaq -8(%rbp), %rax # local variable "found"
  pushq %rax # variable address
  subq $8, %rsp # alloc return vars area
  subq $17, %rsp # alloc parameters area
  leaq 16(%rbp), %rax # local variable "path"
  pushq %rax # variable address
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
  pushq $47 # convert char literal to int
  popq %rax # result of T_UINT8
  leaq 16(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movb %al, 0(%rsi) # assign byte
  callq strings.LastIndexByte
  addq $17, %rsp # free parameters area
  #  totalReturnSize=8
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -8(%rbp), %rax # local variable "found"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  pushq $1 # number literal
  popq %rax # e.X
  imulq $-1, %rax
  pushq %rax
  popq %rcx # right
  popq %rax # left
  cmpq %rcx, %rax
  sete %al
  movzbq %al, %rax
  pushq %rax
  popq %rax # result of if condition
  cmpq $1, %rax
  jne .L.endif.106 # jmp if false
  leaq 32(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  leaq 16(%rbp), %rax # local variable "path"
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
  .L.endif.106:
  leaq 32(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  leaq -8(%rbp), %rax # local variable "found"
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
  leaq 16(%rbp), %rax # local variable "path"
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
  leave
  ret
  leave
  ret

# Function path.Base
.global path.Base
path.Base: # args 48, locals -8
  pushq %rbp
  movq %rsp, %rbp
  subq $8, %rsp # local area
  leaq 16(%rbp), %rax # local variable "path"
  pushq %rax # variable address
  popq %rax # address of T_STRING
  movq 8(%rax), %rdx # len
  movq 0(%rax), %rax # ptr
  pushq %rdx # len
  pushq %rax # ptr
  popq %rax # string.ptr
  popq %rcx # string.len
  pushq %rcx # len
  pushq $0 # number literal
  popq %rcx # right
  popq %rax # left
  cmpq %rcx, %rax
  sete %al
  movzbq %al, %rax
  pushq %rax
  popq %rax # result of if condition
  cmpq $1, %rax
  jne .L.endif.107 # jmp if false
  leaq 32(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  pushq $1 # str len
  leaq .string_3(%rip), %rax # str ptr
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
  .L.endif.107:
  subq $8, %rsp # alloc return vars area
  subq $32, %rsp # alloc parameters area
  leaq 16(%rbp), %rax # local variable "path"
  pushq %rax # variable address
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
  pushq $1 # str len
  leaq .string_4(%rip), %rax # str ptr
  pushq %rax # str ptr
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
  jne .L.endif.108 # jmp if false
  leaq 32(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  pushq $1 # str len
  leaq .string_5(%rip), %rax # str ptr
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
  .L.endif.108:
  leaq 16(%rbp), %rax # local variable "path"
  pushq %rax # variable address
  popq %rax # address of T_STRING
  movq 8(%rax), %rdx # len
  movq 0(%rax), %rax # ptr
  pushq %rdx # len
  pushq %rax # ptr
  popq %rax # string.ptr
  popq %rcx # string.len
  pushq %rcx # len
  pushq $1 # number literal
  popq %rcx # right
  popq %rax # left
  subq %rcx, %rax
  pushq %rax
  leaq 16(%rbp), %rax # local variable "path"
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
  pushq $47 # convert char literal to int
  popq %rcx # right
  popq %rax # left
  cmpq %rcx, %rax
  sete %al
  movzbq %al, %rax
  pushq %rax
  popq %rax # result of if condition
  cmpq $1, %rax
  jne .L.endif.109 # jmp if false
  leaq 16(%rbp), %rax # local variable "path"
  pushq %rax # variable address
  leaq 16(%rbp), %rax # local variable "path"
  pushq %rax # variable address
  popq %rax # address of T_STRING
  movq 8(%rax), %rdx # len
  movq 0(%rax), %rax # ptr
  pushq %rdx # len
  pushq %rax # ptr
  popq %rax # string.ptr
  popq %rcx # string.len
  pushq %rcx # len
  pushq $1 # number literal
  popq %rcx # right
  popq %rax # left
  subq %rcx, %rax
  pushq %rax
  pushq $0 # number literal
  popq %rcx # low
  popq %rax # high
  subq %rcx, %rax # high - low
  pushq %rax # len
  pushq $0 # number literal
  leaq 16(%rbp), %rax # local variable "path"
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
  .L.endif.109:
  leaq -8(%rbp), %rax # local variable "found"
  pushq %rax # variable address
  subq $8, %rsp # alloc return vars area
  subq $17, %rsp # alloc parameters area
  leaq 16(%rbp), %rax # local variable "path"
  pushq %rax # variable address
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
  pushq $47 # convert char literal to int
  popq %rax # result of T_UINT8
  leaq 16(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movb %al, 0(%rsi) # assign byte
  callq strings.LastIndexByte
  addq $17, %rsp # free parameters area
  #  totalReturnSize=8
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -8(%rbp), %rax # local variable "found"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  pushq $1 # number literal
  popq %rax # e.X
  imulq $-1, %rax
  pushq %rax
  popq %rcx # right
  popq %rax # left
  cmpq %rcx, %rax
  sete %al
  movzbq %al, %rax
  pushq %rax
  popq %rax # result of if condition
  cmpq $1, %rax
  jne .L.endif.110 # jmp if false
  leaq 32(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  leaq 16(%rbp), %rax # local variable "path"
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
  .L.endif.110:
  leaq 32(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  leaq 16(%rbp), %rax # local variable "path"
  pushq %rax # variable address
  popq %rax # address of T_STRING
  movq 8(%rax), %rdx # len
  movq 0(%rax), %rax # ptr
  pushq %rdx # len
  pushq %rax # ptr
  popq %rax # string.ptr
  popq %rcx # string.len
  pushq %rcx # len
  leaq -8(%rbp), %rax # local variable "found"
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
  leaq -8(%rbp), %rax # local variable "found"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  pushq $1 # number literal
  popq %rcx # right
  popq %rax # left
  addq %rcx, %rax
  pushq %rax
  leaq 16(%rbp), %rax # local variable "path"
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
  leave
  ret
  leave
  ret
# ------- Dynamic Types ------
.data


