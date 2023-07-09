#=== Package github.com/DQNEO/babygo/lib/strconv
#--- walk 
# Package types:
#--- string literals
.data
.string_0:
  .string "0"
#--- global vars (static values)

#--- global vars (dynamic value setting)
.text
.global strconv.__initGlobals
strconv.__initGlobals:
  ret

# Function strconv.Itoa
.global strconv.Itoa
strconv.Itoa: # args 40, locals -89
  pushq %rbp
  movq %rsp, %rbp
  subq $89, %rsp # local area
  leaq 16(%rbp), %rax # local variable "ival"
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
  jne .L.endif.95 # jmp if false
  leaq 24(%rbp), %rax # local variable ".r0"
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
  .L.endif.95:
  leaq -24(%rbp), %rax # local variable "buf"
  pushq %rax # variable address
  subq $24, %rsp # alloc return vars area
  subq $24, %rsp # alloc parameters area
  pushq $1 # number literal
  popq %rax # result of T_INT
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  pushq $100 # number literal
  popq %rax # result of T_INT
  leaq 8(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  pushq $100 # number literal
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
  leaq -48(%rbp), %rax # local variable "r"
  pushq %rax # variable address
  subq $24, %rsp # alloc return vars area
  subq $24, %rsp # alloc parameters area
  pushq $1 # number literal
  popq %rax # result of T_INT
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  pushq $100 # number literal
  popq %rax # result of T_INT
  leaq 8(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  pushq $100 # number literal
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
  leaq -56(%rbp), %rax # local variable "next"
  pushq %rax # variable address
  pushq $0 # T_INT zero value (number)
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -64(%rbp), %rax # local variable "right"
  pushq %rax # variable address
  pushq $0 # T_INT zero value (number)
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -72(%rbp), %rax # local variable "ix"
  pushq %rax # variable address
  pushq $0 # number literal
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -80(%rbp), %rax # local variable "minus"
  pushq %rax # variable address
  pushq $0 # T_BOOL zero value (number)
  popq %rax # result of T_BOOL
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -80(%rbp), %rax # local variable "minus"
  pushq %rax # variable address
  pushq $0 # false
  popq %rax # result of T_BOOL
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -72(%rbp), %rax # local variable "ix"
  pushq %rax # variable address
  pushq $0 # number literal
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  .L.for.cond.96:
  leaq 16(%rbp), %rax # local variable "ival"
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
  popq %rax # result of 
  xor $1, %rax
  pushq %rax
  popq %rax # result of for condition
  cmpq $1, %rax
  jne .L.for.exit.96 # jmp if false
  leaq 16(%rbp), %rax # local variable "ival"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  pushq $0 # number literal
  popq %rcx # right
  popq %rax # left
  cmpq %rcx, %rax
  setl %al
  movzbq %al, %rax
  pushq %rax
  popq %rax # result of if condition
  cmpq $1, %rax
  jne .L.else.97 # jmp if false
  leaq 16(%rbp), %rax # local variable "ival"
  pushq %rax # variable address
  pushq $1 # number literal
  popq %rax # e.X
  imulq $-1, %rax
  pushq %rax
  leaq 16(%rbp), %rax # local variable "ival"
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
  leaq -80(%rbp), %rax # local variable "minus"
  pushq %rax # variable address
  pushq $1 # true
  popq %rax # result of T_BOOL
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  pushq $0 # number literal
  leaq -48(%rbp), %rax # local variable "r"
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
  pushq $45 # convert char literal to int
  popq %rax # result of T_UINT8
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movb %al, 0(%rsi) # assign byte
  jmp .L.endif.97
  .L.else.97:
  leaq -56(%rbp), %rax # local variable "next"
  pushq %rax # variable address
  leaq 16(%rbp), %rax # local variable "ival"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  pushq $10 # number literal
  popq %rcx # right
  popq %rax # left
  movq $0, %rdx # init %rdx
  divq %rcx
  pushq %rax
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -64(%rbp), %rax # local variable "right"
  pushq %rax # variable address
  leaq 16(%rbp), %rax # local variable "ival"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  leaq -56(%rbp), %rax # local variable "next"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  pushq $10 # number literal
  popq %rcx # right
  popq %rax # left
  imulq %rcx, %rax
  pushq %rax
  popq %rcx # right
  popq %rax # left
  subq %rcx, %rax
  pushq %rax
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq 16(%rbp), %rax # local variable "ival"
  pushq %rax # variable address
  leaq -56(%rbp), %rax # local variable "next"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -72(%rbp), %rax # local variable "ix"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
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
  pushq %rax # slice.ptr
  popq %rax # address of list head
  popq %rcx # index id
  movq $1, %rdx # elm size
  imulq %rdx, %rcx
  addq %rcx, %rax
  pushq %rax # addr of element
  pushq $48 # convert char literal to int
  leaq -64(%rbp), %rax # local variable "right"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rcx # right
  popq %rax # left
  addq %rcx, %rax
  pushq %rax
  popq %rax # result of T_UINT8
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movb %al, 0(%rsi) # assign byte
  .L.endif.97:
  .L.for.post.96:
  leaq -72(%rbp), %rax # local variable "ix"
  pushq %rax # variable address
  leaq -72(%rbp), %rax # local variable "ix"
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
  jmp .L.for.cond.96
  .L.for.exit.96:
  leaq -88(%rbp), %rax # local variable "j"
  pushq %rax # variable address
  pushq $0 # T_INT zero value (number)
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -89(%rbp), %rax # local variable "c"
  pushq %rax # variable address
  pushq $0 # T_UINT8 zero value (number)
  popq %rax # result of T_UINT8
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movb %al, 0(%rsi) # assign byte
  leaq -88(%rbp), %rax # local variable "j"
  pushq %rax # variable address
  pushq $0 # number literal
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  .L.for.cond.98:
  leaq -88(%rbp), %rax # local variable "j"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  leaq -72(%rbp), %rax # local variable "ix"
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
  jne .L.for.exit.98 # jmp if false
  leaq -89(%rbp), %rax # local variable "c"
  pushq %rax # variable address
  leaq -72(%rbp), %rax # local variable "ix"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  leaq -88(%rbp), %rax # local variable "j"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rcx # right
  popq %rax # left
  subq %rcx, %rax
  pushq %rax
  pushq $1 # number literal
  popq %rcx # right
  popq %rax # left
  subq %rcx, %rax
  pushq %rax
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
  leaq -80(%rbp), %rax # local variable "minus"
  pushq %rax # variable address
  popq %rax # address of T_BOOL
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rax # result of if condition
  cmpq $1, %rax
  jne .L.else.99 # jmp if false
  leaq -88(%rbp), %rax # local variable "j"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  pushq $1 # number literal
  popq %rcx # right
  popq %rax # left
  addq %rcx, %rax
  pushq %rax
  leaq -48(%rbp), %rax # local variable "r"
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
  leaq -89(%rbp), %rax # local variable "c"
  pushq %rax # variable address
  popq %rax # address of T_UINT8
  movzbq 0(%rax), %rax # load uint8
  pushq %rax
  popq %rax # result of T_UINT8
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movb %al, 0(%rsi) # assign byte
  jmp .L.endif.99
  .L.else.99:
  leaq -88(%rbp), %rax # local variable "j"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  leaq -48(%rbp), %rax # local variable "r"
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
  leaq -89(%rbp), %rax # local variable "c"
  pushq %rax # variable address
  popq %rax # address of T_UINT8
  movzbq 0(%rax), %rax # load uint8
  pushq %rax
  popq %rax # result of T_UINT8
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movb %al, 0(%rsi) # assign byte
  .L.endif.99:
  .L.for.post.98:
  leaq -88(%rbp), %rax # local variable "j"
  pushq %rax # variable address
  leaq -88(%rbp), %rax # local variable "j"
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
  jmp .L.for.cond.98
  .L.for.exit.98:
  leaq 24(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  leaq -48(%rbp), %rax # local variable "r"
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
  leaq -72(%rbp), %rax # local variable "ix"
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
  leaq -48(%rbp), %rax # local variable "r"
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

# Function strconv.Atoi
.global strconv.Atoi
strconv.Atoi: # args 40, locals -42
  pushq %rbp
  movq %rsp, %rbp
  subq $42, %rsp # local area
  leaq 16(%rbp), %rax # local variable "gs"
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
  jne .L.endif.100 # jmp if false
  leaq 32(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  pushq $0 # number literal
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leave
  ret
  .L.endif.100:
  leaq -8(%rbp), %rax # local variable "n"
  pushq %rax # variable address
  pushq $0 # T_INT zero value (number)
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -16(%rbp), %rax # local variable "isMinus"
  pushq %rax # variable address
  pushq $0 # T_BOOL zero value (number)
  popq %rax # result of T_BOOL
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -25(%rbp), %rax # local variable ".range.len"
  pushq %rax # variable address
  leaq 16(%rbp), %rax # local variable "gs"
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
  leaq -33(%rbp), %rax # local variable ".range.index"
  pushq %rax # variable address
  pushq $0 # T_INT zero value (number)
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  .L.range.cond.101:
  leaq -33(%rbp), %rax # local variable ".range.index"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  leaq -25(%rbp), %rax # local variable ".range.len"
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
  jne .L.range.exit.101 # jmp if false
  leaq -42(%rbp), %rax # local variable "b"
  pushq %rax # variable address
  leaq -33(%rbp), %rax # local variable ".range.index"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  leaq 16(%rbp), %rax # local variable "gs"
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
  leaq -42(%rbp), %rax # local variable "b"
  pushq %rax # variable address
  popq %rax # address of T_UINT8
  movzbq 0(%rax), %rax # load uint8
  pushq %rax
  pushq $46 # convert char literal to int
  popq %rcx # right
  popq %rax # left
  cmpq %rcx, %rax
  sete %al
  movzbq %al, %rax
  pushq %rax
  popq %rax # result of if condition
  cmpq $1, %rax
  jne .L.endif.102 # jmp if false
  leaq 32(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  pushq $999 # number literal
  popq %rax # e.X
  imulq $-1, %rax
  pushq %rax
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leave
  ret
  .L.endif.102:
  leaq -42(%rbp), %rax # local variable "b"
  pushq %rax # variable address
  popq %rax # address of T_UINT8
  movzbq 0(%rax), %rax # load uint8
  pushq %rax
  pushq $45 # convert char literal to int
  popq %rcx # right
  popq %rax # left
  cmpq %rcx, %rax
  sete %al
  movzbq %al, %rax
  pushq %rax
  popq %rax # result of if condition
  cmpq $1, %rax
  jne .L.endif.103 # jmp if false
  leaq -16(%rbp), %rax # local variable "isMinus"
  pushq %rax # variable address
  pushq $1 # true
  popq %rax # result of T_BOOL
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  jmp .L.range.post.101 # continue
  .L.endif.103:
  leaq -17(%rbp), %rax # local variable "x"
  pushq %rax # variable address
  leaq -42(%rbp), %rax # local variable "b"
  pushq %rax # variable address
  popq %rax # address of T_UINT8
  movzbq 0(%rax), %rax # load uint8
  pushq %rax
  pushq $48 # convert char literal to int
  popq %rcx # right
  popq %rax # left
  subq %rcx, %rax
  pushq %rax
  popq %rax # result of T_UINT8
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movb %al, 0(%rsi) # assign byte
  leaq -8(%rbp), %rax # local variable "n"
  pushq %rax # variable address
  leaq -8(%rbp), %rax # local variable "n"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  pushq $10 # number literal
  popq %rcx # right
  popq %rax # left
  imulq %rcx, %rax
  pushq %rax
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -8(%rbp), %rax # local variable "n"
  pushq %rax # variable address
  leaq -8(%rbp), %rax # local variable "n"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  leaq -17(%rbp), %rax # local variable "x"
  pushq %rax # variable address
  popq %rax # address of T_UINT8
  movzbq 0(%rax), %rax # load uint8
  pushq %rax
  popq %rcx # right
  popq %rax # left
  addq %rcx, %rax
  pushq %rax
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  .L.range.post.101:
  leaq -33(%rbp), %rax # local variable ".range.index"
  pushq %rax # variable address
  leaq -33(%rbp), %rax # local variable ".range.index"
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
  jmp .L.range.cond.101
  .L.range.exit.101:
  leaq -16(%rbp), %rax # local variable "isMinus"
  pushq %rax # variable address
  popq %rax # address of T_BOOL
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rax # result of if condition
  cmpq $1, %rax
  jne .L.endif.104 # jmp if false
  leaq -8(%rbp), %rax # local variable "n"
  pushq %rax # variable address
  leaq -8(%rbp), %rax # local variable "n"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rax # e.X
  imulq $-1, %rax
  pushq %rax
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  .L.endif.104:
  leaq 32(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  leaq -8(%rbp), %rax # local variable "n"
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
# ------- Dynamic Types ------
.data


