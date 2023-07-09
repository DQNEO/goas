#=== Package syscall
#--- walk 
# Package types:
#--- string literals
.data
#--- global vars (static values)

#--- global vars (dynamic value setting)
.text
.global syscall.__initGlobals
syscall.__initGlobals:
  ret

# Function syscall.Read
.global syscall.Read
syscall.Read: # args 72, locals -24
  pushq %rbp
  movq %rsp, %rbp
  subq $24, %rsp # local area
  leaq -8(%rbp), %rax # local variable "p"
  pushq %rax # variable address
  pushq $0 # number literal
  leaq 24(%rbp), %rax # local variable "buf"
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
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq -16(%rbp), %rax # local variable "_cap"
  pushq %rax # variable address
  leaq 24(%rbp), %rax # local variable "buf"
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
  leaq -24(%rbp), %rax # local variable "ret"
  pushq %rax # variable address
  pushq $0 # T_UINTPTR zero value (nil pointer)
  popq %rax # result of T_UINTPTR
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq -24(%rbp), %rax # local variable "ret"
  pushq %rax # variable address
  subq $8, %rsp # alloc return vars area
  subq $32, %rsp # alloc parameters area
  pushq $0 # number literal
  popq %rax # result of T_UINTPTR
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq 16(%rbp), %rax # local variable "fd"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rax # result of T_UINTPTR
  leaq 8(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq -8(%rbp), %rax # local variable "p"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_UINTPTR
  leaq 16(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq -16(%rbp), %rax # local variable "_cap"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rax # result of T_UINTPTR
  leaq 24(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  callq syscall.Syscall
  addq $32, %rsp # free parameters area
  #  totalReturnSize=8
  popq %rax # result of T_UINTPTR
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq 48(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  leaq -24(%rbp), %rax # local variable "ret"
  pushq %rax # variable address
  popq %rax # address of T_UINTPTR
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_UINTPTR
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
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

# Function syscall.Open
.global syscall.Open
syscall.Open: # args 72, locals -40
  pushq %rbp
  movq %rsp, %rbp
  subq $40, %rsp # local area
  leaq -24(%rbp), %rax # local variable "buf"
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
  pushq %rcx # cap
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
  pushq $0 # number literal
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
  pushq $0 # number literal
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
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq -40(%rbp), %rax # local variable "fd"
  pushq %rax # variable address
  pushq $0 # T_UINTPTR zero value (nil pointer)
  popq %rax # result of T_UINTPTR
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq -40(%rbp), %rax # local variable "fd"
  pushq %rax # variable address
  subq $8, %rsp # alloc return vars area
  subq $32, %rsp # alloc parameters area
  pushq $2 # number literal
  popq %rax # result of T_UINTPTR
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq -32(%rbp), %rax # local variable "p"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_UINTPTR
  leaq 8(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq 32(%rbp), %rax # local variable "mode"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rax # result of T_UINTPTR
  leaq 16(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq 40(%rbp), %rax # local variable "perm"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rax # result of T_UINTPTR
  leaq 24(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  callq syscall.Syscall
  addq $32, %rsp # free parameters area
  #  totalReturnSize=8
  popq %rax # result of T_UINTPTR
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq 48(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  leaq -40(%rbp), %rax # local variable "fd"
  pushq %rax # variable address
  popq %rax # address of T_UINTPTR
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_UINTPTR
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
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

# Function syscall.Close
.global syscall.Close
syscall.Close: # args 40, locals 0
  pushq %rbp
  movq %rsp, %rbp
  subq $8, %rsp # alloc return vars area
  subq $32, %rsp # alloc parameters area
  pushq $3 # number literal
  popq %rax # result of T_UINTPTR
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq 16(%rbp), %rax # local variable "fd"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
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
  callq syscall.Syscall
  addq $32, %rsp # free parameters area
  #  totalReturnSize=8
  leaq 24(%rbp), %rax # local variable ".r0"
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

# Function syscall.Write
.global syscall.Write
syscall.Write: # args 72, locals -24
  pushq %rbp
  movq %rsp, %rbp
  subq $24, %rsp # local area
  leaq -8(%rbp), %rax # local variable "p"
  pushq %rax # variable address
  pushq $0 # number literal
  leaq 24(%rbp), %rax # local variable "buf"
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
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq -16(%rbp), %rax # local variable "_len"
  pushq %rax # variable address
  leaq 24(%rbp), %rax # local variable "buf"
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
  leaq -24(%rbp), %rax # local variable "ret"
  pushq %rax # variable address
  pushq $0 # T_UINTPTR zero value (nil pointer)
  popq %rax # result of T_UINTPTR
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq -24(%rbp), %rax # local variable "ret"
  pushq %rax # variable address
  subq $8, %rsp # alloc return vars area
  subq $32, %rsp # alloc parameters area
  pushq $1 # number literal
  popq %rax # result of T_UINTPTR
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq 16(%rbp), %rax # local variable "fd"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rax # result of T_UINTPTR
  leaq 8(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq -8(%rbp), %rax # local variable "p"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_UINTPTR
  leaq 16(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq -16(%rbp), %rax # local variable "_len"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rax # result of T_UINTPTR
  leaq 24(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  callq syscall.Syscall
  addq $32, %rsp # free parameters area
  #  totalReturnSize=8
  popq %rax # result of T_UINTPTR
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq 48(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  leaq -24(%rbp), %rax # local variable "ret"
  pushq %rax # variable address
  popq %rax # address of T_UINTPTR
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_UINTPTR
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
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

# Function syscall.Getdents
.global syscall.Getdents
syscall.Getdents: # args 72, locals -16
  pushq %rbp
  movq %rsp, %rbp
  subq $16, %rsp # local area
  leaq -8(%rbp), %rax # local variable "_p0"
  pushq %rax # variable address
  pushq $0 # T_POINTER zero value (nil pointer)
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq -8(%rbp), %rax # local variable "_p0"
  pushq %rax # variable address
  pushq $0 # number literal
  leaq 24(%rbp), %rax # local variable "buf"
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
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq -16(%rbp), %rax # local variable "nread"
  pushq %rax # variable address
  subq $8, %rsp # alloc return vars area
  subq $32, %rsp # alloc parameters area
  pushq $217 # number literal
  popq %rax # result of T_UINTPTR
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq 16(%rbp), %rax # local variable "fd"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rax # result of T_UINTPTR
  leaq 8(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq -8(%rbp), %rax # local variable "_p0"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_UINTPTR
  leaq 16(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq 24(%rbp), %rax # local variable "buf"
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
  popq %rax # result of T_UINTPTR
  leaq 24(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  callq syscall.Syscall
  addq $32, %rsp # free parameters area
  #  totalReturnSize=8
  popq %rax # result of T_UINTPTR
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq 48(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  leaq -16(%rbp), %rax # local variable "nread"
  pushq %rax # variable address
  popq %rax # address of T_UINTPTR
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
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
# ------- Dynamic Types ------
.data


