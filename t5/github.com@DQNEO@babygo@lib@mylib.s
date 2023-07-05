#=== Package github.com/DQNEO/babygo/lib/mylib
#--- walk 
# Package types:
# type mylib.Type struct{Field int;}
#--- string literals
.data
.string_0:
  .string "cannot open "
#--- global vars (static values)

#--- global vars (dynamic value setting)
.text
.global mylib.__initGlobals
mylib.__initGlobals:
  ret

# Method mylib.$Type.Method
.global mylib.$Type.Method
mylib.$Type.Method: # args 32, locals 0
  pushq %rbp
  movq %rsp, %rbp
  leaq 24(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  leaq 16(%rbp), %rax # local variable "mt"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax
  addq $0, %rax
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

# Function mylib.InArray
.global mylib.InArray
mylib.InArray: # args 64, locals -40
  pushq %rbp
  movq %rsp, %rbp
  subq $40, %rsp # local area
  leaq -8(%rbp), %rax # local variable ".range.len"
  pushq %rax # variable address
  leaq 32(%rbp), %rax # local variable "list"
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
  .L.range.cond.137:
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
  jne .L.range.exit.137 # jmp if false
  leaq -40(%rbp), %rax # local variable "v"
  pushq %rax # variable address
  leaq -16(%rbp), %rax # local variable ".range.index"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  leaq 32(%rbp), %rax # local variable "list"
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
  subq $8, %rsp # alloc return vars area
  subq $32, %rsp # alloc parameters area
  leaq -40(%rbp), %rax # local variable "v"
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
  leaq 16(%rbp), %rax # local variable "x"
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
  jne .L.endif.138 # jmp if false
  leaq 56(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  pushq $1 # true
  popq %rax # result of T_BOOL
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leave
  ret
  .L.endif.138:
  .L.range.post.137:
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
  jmp .L.range.cond.137
  .L.range.exit.137:
  leaq 56(%rbp), %rax # local variable ".r0"
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

# Function mylib.Sum
.global mylib.Sum
mylib.Sum: # args 40, locals 0
  pushq %rbp
  movq %rsp, %rbp
  leaq 32(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  leaq 16(%rbp), %rax # local variable "a"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  leaq 24(%rbp), %rax # local variable "b"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
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
  leave
  ret
  leave
  ret

# Function mylib.Sum2
.global mylib.Sum2
mylib.Sum2: # args 40, locals 0
  pushq %rbp
  movq %rsp, %rbp
  leaq 32(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  subq $8, %rsp # alloc return vars area
  subq $16, %rsp # alloc parameters area
  leaq 16(%rbp), %rax # local variable "a"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rax # result of T_INT
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq 24(%rbp), %rax # local variable "b"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rax # result of T_INT
  leaq 8(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  callq mylib2.Sum2
  addq $16, %rsp # free parameters area
  #  totalReturnSize=8
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leave
  ret
  leave
  ret

# Function mylib.Readdirnames
.global mylib.Readdirnames
mylib.Readdirnames: # args 72, locals -64
  pushq %rbp
  movq %rsp, %rbp
  subq $64, %rsp # local area
  subq $24, %rsp # alloc return vars area
  subq $16, %rsp # alloc parameters area
  leaq 16(%rbp), %rax # local variable "dir"
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
  callq os.Open
  addq $16, %rsp # free parameters area
  #  totalReturnSize=24
  # len lhs=2
  # returnTypes=2
  leaq -8(%rbp), %rax # local variable "f"
  pushq %rax # variable address
  popq %rsi # lhs addr
  popq %rax # result of T_POINTER
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  popq %rax # eface.dtype
  popq %rcx # eface.data
  subq $8, %rsp # alloc return vars area
  subq $8, %rsp # alloc parameters area
  leaq -8(%rbp), %rax # local variable "f"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_POINTER
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  callq os.$File.Fd
  addq $8, %rsp # free parameters area
  #  totalReturnSize=8
  pushq $0 # number literal
  popq %rcx # right
  popq %rax # left
  cmpq %rcx, %rax
  setl %al
  movzbq %al, %rax
  pushq %rax
  popq %rax # result of if condition
  cmpq $1, %rax
  jne .L.endif.139 # jmp if false
  subq $16, %rsp # alloc parameters area
  subq $16, %rsp # alloc return vars area
  subq $32, %rsp # alloc parameters area
  pushq $12 # str len
  leaq .string_0(%rip), %rax # str ptr
  pushq %rax # str ptr
  popq %rax # string.ptr
  popq %rcx # string.len
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  leaq 16(%rbp), %rax # local variable "dir"
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
  .L.endif.139:
  subq $40, %rsp # alloc return vars area
  subq $16, %rsp # alloc parameters area
  leaq -8(%rbp), %rax # local variable "f"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_POINTER
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  pushq $1 # number literal
  popq %rax # e.X
  imulq $-1, %rax
  pushq %rax
  popq %rax # result of T_INT
  leaq 8(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  callq os.$File.Readdirnames
  addq $16, %rsp # free parameters area
  #  totalReturnSize=40
  # len lhs=2
  # returnTypes=2
  leaq -48(%rbp), %rax # local variable "names"
  pushq %rax # variable address
  popq %rsi # lhs addr
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  movq %rdx, 16(%rsi) # cap to cap
  popq %rax # eface.dtype
  popq %rcx # eface.data
  subq $16, %rsp # alloc return vars area
  subq $8, %rsp # alloc parameters area
  leaq -8(%rbp), %rax # local variable "f"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_POINTER
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  callq os.$File.Close
  addq $8, %rsp # free parameters area
  #  totalReturnSize=16
  leaq 32(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  leaq -48(%rbp), %rax # local variable "names"
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
  leaq 56(%rbp), %rax # local variable ".r1"
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
  leave
  ret
  leave
  ret

# Function mylib.needSwap
.global mylib.needSwap
mylib.needSwap: # args 56, locals -24
  pushq %rbp
  movq %rsp, %rbp
  subq $24, %rsp # local area
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
  pushq $0 # number literal
  popq %rcx # right
  popq %rax # left
  cmpq %rcx, %rax
  sete %al
  movzbq %al, %rax
  pushq %rax
  popq %rax # result of if condition
  cmpq $1, %rax
  jne .L.endif.140 # jmp if false
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
  .L.endif.140:
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
  .L.for.cond.141:
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
  jne .L.for.exit.141 # jmp if false
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
  pushq %rcx # len
  popq %rcx # right
  popq %rax # left
  cmpq %rcx, %rax
  sete %al
  movzbq %al, %rax
  pushq %rax
  popq %rax # result of if condition
  cmpq $1, %rax
  jne .L.endif.142 # jmp if false
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
  .L.endif.142:
  leaq -16(%rbp), %rax # local variable "aa"
  pushq %rax # variable address
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
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -24(%rbp), %rax # local variable "bb"
  pushq %rax # variable address
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
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -16(%rbp), %rax # local variable "aa"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  leaq -24(%rbp), %rax # local variable "bb"
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
  popq %rax # result of if condition
  cmpq $1, %rax
  jne .L.else.143 # jmp if false
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
  jmp .L.endif.143
  .L.else.143:
  leaq -16(%rbp), %rax # local variable "aa"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  leaq -24(%rbp), %rax # local variable "bb"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rcx # right
  popq %rax # left
  cmpq %rcx, %rax
  setg %al
  movzbq %al, %rax
  pushq %rax
  popq %rax # result of if condition
  cmpq $1, %rax
  jne .L.endif.144 # jmp if false
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
  .L.endif.144:
  .L.endif.143:
  .L.for.post.141:
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
  jmp .L.for.cond.141
  .L.for.exit.141:
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

# Function mylib.SortStrings
.global mylib.SortStrings
mylib.SortStrings: # args 40, locals -48
  pushq %rbp
  movq %rsp, %rbp
  subq $48, %rsp # local area
  leaq -8(%rbp), %rax # local variable "i"
  pushq %rax # variable address
  pushq $0 # T_INT zero value (number)
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -16(%rbp), %rax # local variable "j"
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
  .L.for.cond.145:
  leaq -8(%rbp), %rax # local variable "i"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  leaq 16(%rbp), %rax # local variable "ss"
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
  popq %rcx # right
  popq %rax # left
  cmpq %rcx, %rax
  setl %al
  movzbq %al, %rax
  pushq %rax
  popq %rax # result of for condition
  cmpq $1, %rax
  jne .L.for.exit.145 # jmp if false
  leaq -16(%rbp), %rax # local variable "j"
  pushq %rax # variable address
  pushq $0 # number literal
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  .L.for.cond.146:
  leaq -16(%rbp), %rax # local variable "j"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  leaq 16(%rbp), %rax # local variable "ss"
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
  pushq $1 # number literal
  popq %rcx # right
  popq %rax # left
  subq %rcx, %rax
  pushq %rax
  popq %rcx # right
  popq %rax # left
  cmpq %rcx, %rax
  setl %al
  movzbq %al, %rax
  pushq %rax
  popq %rax # result of for condition
  cmpq $1, %rax
  jne .L.for.exit.146 # jmp if false
  leaq -32(%rbp), %rax # local variable "a"
  pushq %rax # variable address
  leaq -16(%rbp), %rax # local variable "j"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  leaq 16(%rbp), %rax # local variable "ss"
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
  leaq -48(%rbp), %rax # local variable "b"
  pushq %rax # variable address
  leaq -16(%rbp), %rax # local variable "j"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  pushq $1 # number literal
  popq %rcx # right
  popq %rax # left
  addq %rcx, %rax
  pushq %rax
  leaq 16(%rbp), %rax # local variable "ss"
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
  subq $8, %rsp # alloc return vars area
  subq $32, %rsp # alloc parameters area
  leaq -32(%rbp), %rax # local variable "a"
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
  leaq -48(%rbp), %rax # local variable "b"
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
  callq mylib.needSwap
  addq $32, %rsp # free parameters area
  #  totalReturnSize=8
  popq %rax # result of if condition
  cmpq $1, %rax
  jne .L.else.147 # jmp if false
  leaq -16(%rbp), %rax # local variable "j"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  leaq 16(%rbp), %rax # local variable "ss"
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
  leaq -48(%rbp), %rax # local variable "b"
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
  leaq -16(%rbp), %rax # local variable "j"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  pushq $1 # number literal
  popq %rcx # right
  popq %rax # left
  addq %rcx, %rax
  pushq %rax
  leaq 16(%rbp), %rax # local variable "ss"
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
  leaq -32(%rbp), %rax # local variable "a"
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
  jmp .L.endif.147
  .L.else.147:
  .L.endif.147:
  .L.for.post.146:
  leaq -16(%rbp), %rax # local variable "j"
  pushq %rax # variable address
  leaq -16(%rbp), %rax # local variable "j"
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
  jmp .L.for.cond.146
  .L.for.exit.146:
  .L.for.post.145:
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
  jmp .L.for.cond.145
  .L.for.exit.145:
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


