#=== Package os
#--- walk 
# Package types:
# type os.File struct{fd int;}
# type os.linux_dirent struct{d_ino int;d_off int;d_reclen1 uint16;d_type uint8;d_name uint8;}
#--- string literals
.data
.string_0:
  .string "unable to create file "
.string_1:
  .string "unable to create file "
.string_2:
  .string "getdents failed"
.string_3:
  .string "."
.string_4:
  .string ".."
.string_5:
  .string "syscall.Open failed: "
#--- global vars (static values)
.global os.Args
os.Args: # T T_SLICE
  .quad 0 # ptr
  .quad 0 # len
  .quad 0 # cap
.global os.Stdin
os.Stdin: # T T_POINTER
  .quad 0
.global os.Stdout
os.Stdout: # T T_POINTER
  .quad 0
.global os.Stderr
os.Stderr: # T T_POINTER
  .quad 0

#--- global vars (dynamic value setting)
.text
.global os.__initGlobals
os.__initGlobals:
  ret

# Function os.Open
.global os.Open
os.Open: # args 56, locals -16
  pushq %rbp
  movq %rsp, %rbp
  subq $16, %rsp # local area
  leaq -8(%rbp), %rax # local variable "fd"
  pushq %rax # variable address
  pushq $0 # T_INT zero value (number)
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  subq $24, %rsp # alloc return vars area
  subq $32, %rsp # alloc parameters area
  leaq 16(%rbp), %rax # local variable "name"
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
  pushq $0 # number literal
  popq %rax # result of T_INT
  leaq 16(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  pushq $438 # number literal
  popq %rax # result of T_INT
  leaq 24(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  callq syscall.Open
  addq $32, %rsp # free parameters area
  #  totalReturnSize=24
  # len lhs=2
  # returnTypes=2
  leaq -8(%rbp), %rax # local variable "fd"
  pushq %rax # variable address
  popq %rsi # lhs addr
  popq %rax # result of T_INT
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  popq %rax # eface.dtype
  popq %rcx # eface.data
  leaq -8(%rbp), %rax # local variable "fd"
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
  jne .L.endif.62 # jmp if false
  subq $16, %rsp # alloc parameters area
  subq $16, %rsp # alloc return vars area
  subq $32, %rsp # alloc parameters area
  pushq $22 # str len
  leaq .string_0(%rip), %rax # str ptr
  pushq %rax # str ptr
  popq %rax # string.ptr
  popq %rcx # string.len
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  leaq 16(%rbp), %rax # local variable "name"
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
  .L.endif.62:
  leaq -16(%rbp), %rax # local variable "f"
  pushq %rax # variable address
  subq $8, %rsp # alloc return vars area
  pushq $8
  callq runtime.malloc
  addq $8, %rsp # free parameters area
  #  totalReturnSize=8
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq -16(%rbp), %rax # local variable "f"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax
  addq $0, %rax
  pushq %rax
  leaq -8(%rbp), %rax # local variable "fd"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq 32(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  leaq -16(%rbp), %rax # local variable "f"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq 40(%rbp), %rax # local variable ".r1"
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

# Function os.Create
.global os.Create
os.Create: # args 56, locals -16
  pushq %rbp
  movq %rsp, %rbp
  subq $16, %rsp # local area
  leaq -8(%rbp), %rax # local variable "fd"
  pushq %rax # variable address
  pushq $0 # T_INT zero value (number)
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  subq $24, %rsp # alloc return vars area
  subq $32, %rsp # alloc parameters area
  leaq 16(%rbp), %rax # local variable "name"
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
  pushq $2 # number literal
  pushq $64 # number literal
  popq %rcx # right
  popq %rax # left
  orq %rcx, %rax # bitwise or
  pushq %rax
  pushq $512 # number literal
  popq %rcx # right
  popq %rax # left
  orq %rcx, %rax # bitwise or
  pushq %rax
  pushq $524288 # number literal
  popq %rcx # right
  popq %rax # left
  orq %rcx, %rax # bitwise or
  pushq %rax
  popq %rax # result of T_INT
  leaq 16(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  pushq $438 # number literal
  popq %rax # result of T_INT
  leaq 24(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  callq syscall.Open
  addq $32, %rsp # free parameters area
  #  totalReturnSize=24
  # len lhs=2
  # returnTypes=2
  leaq -8(%rbp), %rax # local variable "fd"
  pushq %rax # variable address
  popq %rsi # lhs addr
  popq %rax # result of T_INT
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  popq %rax # eface.dtype
  popq %rcx # eface.data
  leaq -8(%rbp), %rax # local variable "fd"
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
  jne .L.endif.63 # jmp if false
  subq $16, %rsp # alloc parameters area
  subq $16, %rsp # alloc return vars area
  subq $32, %rsp # alloc parameters area
  pushq $22 # str len
  leaq .string_1(%rip), %rax # str ptr
  pushq %rax # str ptr
  popq %rax # string.ptr
  popq %rcx # string.len
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  leaq 16(%rbp), %rax # local variable "name"
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
  .L.endif.63:
  leaq -16(%rbp), %rax # local variable "f"
  pushq %rax # variable address
  subq $8, %rsp # alloc return vars area
  pushq $8
  callq runtime.malloc
  addq $8, %rsp # free parameters area
  #  totalReturnSize=8
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq -16(%rbp), %rax # local variable "f"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax
  addq $0, %rax
  pushq %rax
  leaq -8(%rbp), %rax # local variable "fd"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq 32(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  leaq -16(%rbp), %rax # local variable "f"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq 40(%rbp), %rax # local variable ".r1"
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

# Method os.$File.Fd
.global os.$File.Fd
os.$File.Fd: # args 32, locals 0
  pushq %rbp
  movq %rsp, %rbp
  leaq 24(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  leaq 16(%rbp), %rax # local variable "f"
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
  popq %rax # result of T_UINTPTR
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leave
  ret
  leave
  ret

# Function os.Cstring2string
.global os.Cstring2string
os.Cstring2string: # args 40, locals -32
  pushq %rbp
  movq %rsp, %rbp
  subq $32, %rsp # local area
  leaq -24(%rbp), %rax # local variable "bs"
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
  .L.for.cond.64:
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
  je .L.66.true
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
  jmp .L.66.exit
  .L.66.true:
  pushq $1 # true
  .L.66.exit:
  popq %rax # result of if condition
  cmpq $1, %rax
  jne .L.endif.65 # jmp if false
  jmp .L.for.exit.64 # break
  .L.endif.65:
  leaq -24(%rbp), %rax # local variable "bs"
  pushq %rax # variable address
  subq $24, %rsp # alloc return vars area
  subq $25, %rsp # alloc parameters area
  leaq -24(%rbp), %rax # local variable "bs"
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
  .L.for.post.64:
  jmp .L.for.cond.64
  .L.for.exit.64:
  leaq 24(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  leaq -24(%rbp), %rax # local variable "bs"
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

# Method os.$File.Readdirnames
.global os.$File.Readdirnames
os.$File.Readdirnames: # args 72, locals -136
  pushq %rbp
  movq %rsp, %rbp
  subq $136, %rsp # local area
  leaq -8(%rbp), %rax # local variable "fd"
  pushq %rax # variable address
  subq $8, %rsp # alloc return vars area
  subq $8, %rsp # alloc parameters area
  leaq 16(%rbp), %rax # local variable "f"
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
  popq %rax # result of T_UINTPTR
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq -32(%rbp), %rax # local variable "buf"
  pushq %rax # variable address
  subq $24, %rsp # alloc return vars area
  subq $24, %rsp # alloc parameters area
  pushq $1 # number literal
  popq %rax # result of T_INT
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  pushq $1024 # number literal
  popq %rax # result of T_INT
  leaq 8(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  pushq $1024 # number literal
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
  leaq -40(%rbp), %rax # local variable "counter"
  pushq %rax # variable address
  pushq $0 # T_INT zero value (number)
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -64(%rbp), %rax # local variable "entries"
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
  .L.for.cond.67:
  subq $24, %rsp # alloc return vars area
  subq $32, %rsp # alloc parameters area
  leaq -8(%rbp), %rax # local variable "fd"
  pushq %rax # variable address
  popq %rax # address of T_UINTPTR
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_INT
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -32(%rbp), %rax # local variable "buf"
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
  leaq 8(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  movq %rdx, 16(%rsi) # cap to cap
  callq syscall.Getdents
  addq $32, %rsp # free parameters area
  #  totalReturnSize=24
  # len lhs=2
  # returnTypes=2
  leaq -72(%rbp), %rax # local variable "nread"
  pushq %rax # variable address
  popq %rsi # lhs addr
  popq %rax # result of T_INT
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  popq %rax # eface.dtype
  popq %rcx # eface.data
  leaq -72(%rbp), %rax # local variable "nread"
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
  jne .L.endif.68 # jmp if false
  subq $16, %rsp # alloc parameters area
  pushq $15 # str len
  leaq .string_2(%rip), %rax # str ptr
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
  .L.endif.68:
  leaq -72(%rbp), %rax # local variable "nread"
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
  jne .L.endif.69 # jmp if false
  jmp .L.for.exit.67 # break
  .L.endif.69:
  leaq -96(%rbp), %rax # local variable "bpos"
  pushq %rax # variable address
  pushq $0 # T_INT zero value (number)
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  .L.for.cond.70:
  leaq -96(%rbp), %rax # local variable "bpos"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  leaq -72(%rbp), %rax # local variable "nread"
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
  jne .L.for.exit.70 # jmp if false
  leaq -104(%rbp), %rax # local variable "dirp"
  pushq %rax # variable address
  pushq $0 # T_POINTER zero value (nil pointer)
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq -112(%rbp), %rax # local variable "p"
  pushq %rax # variable address
  pushq $0 # number literal
  leaq -32(%rbp), %rax # local variable "buf"
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
  leaq -96(%rbp), %rax # local variable "bpos"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
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
  leaq -104(%rbp), %rax # local variable "dirp"
  pushq %rax # variable address
  leaq -112(%rbp), %rax # local variable "p"
  pushq %rax # variable address
  popq %rax # address of T_UINTPTR
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq -120(%rbp), %rax # local variable "bytes"
  pushq %rax # variable address
  leaq -104(%rbp), %rax # local variable "dirp"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax
  addq $19, %rax
  pushq %rax
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq -136(%rbp), %rax # local variable "s"
  pushq %rax # variable address
  subq $16, %rsp # alloc return vars area
  subq $8, %rsp # alloc parameters area
  leaq -120(%rbp), %rax # local variable "bytes"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_POINTER
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  callq os.Cstring2string
  addq $8, %rsp # free parameters area
  #  totalReturnSize=16
  popq %rax # string.ptr
  popq %rcx # string.len
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  leaq -96(%rbp), %rax # local variable "bpos"
  pushq %rax # variable address
  leaq -96(%rbp), %rax # local variable "bpos"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  leaq -104(%rbp), %rax # local variable "dirp"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax
  addq $16, %rax
  pushq %rax
  popq %rax # address of T_UINT16
  movzwq 0(%rax), %rax # load uint16
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
  leaq -40(%rbp), %rax # local variable "counter"
  pushq %rax # variable address
  leaq -40(%rbp), %rax # local variable "counter"
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
  subq $8, %rsp # alloc return vars area
  subq $32, %rsp # alloc parameters area
  leaq -136(%rbp), %rax # local variable "s"
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
  leaq .string_3(%rip), %rax # str ptr
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
  popq %rax # result of left
  cmpq $1, %rax
  je .L.72.true
  subq $8, %rsp # alloc return vars area
  subq $32, %rsp # alloc parameters area
  leaq -136(%rbp), %rax # local variable "s"
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
  callq runtime.cmpstrings
  addq $32, %rsp # free parameters area
  #  totalReturnSize=8
  jmp .L.72.exit
  .L.72.true:
  pushq $1 # true
  .L.72.exit:
  popq %rax # result of if condition
  cmpq $1, %rax
  jne .L.endif.71 # jmp if false
  jmp .L.for.post.70 # continue
  .L.endif.71:
  leaq -64(%rbp), %rax # local variable "entries"
  pushq %rax # variable address
  subq $24, %rsp # alloc return vars area
  subq $40, %rsp # alloc parameters area
  leaq -64(%rbp), %rax # local variable "entries"
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
  leaq -136(%rbp), %rax # local variable "s"
  pushq %rax # variable address
  popq %rax # address of T_STRING
  movq 8(%rax), %rdx # len
  movq 0(%rax), %rax # ptr
  pushq %rdx # len
  pushq %rax # ptr
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
  .L.for.post.70:
  jmp .L.for.cond.70
  .L.for.exit.70:
  .L.for.post.67:
  jmp .L.for.cond.67
  .L.for.exit.67:
  subq $16, %rsp # alloc return vars area
  subq $8, %rsp # alloc parameters area
  leaq 16(%rbp), %rax # local variable "f"
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
  leaq -64(%rbp), %rax # local variable "entries"
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

# Method os.$File.Close
.global os.$File.Close
os.$File.Close: # args 40, locals -16
  pushq %rbp
  movq %rsp, %rbp
  subq $16, %rsp # local area
  leaq -16(%rbp), %rax # local variable "err"
  pushq %rax # variable address
  subq $16, %rsp # alloc return vars area
  subq $8, %rsp # alloc parameters area
  leaq 16(%rbp), %rax # local variable "f"
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
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  callq syscall.Close
  addq $8, %rsp # free parameters area
  #  totalReturnSize=16
  popq %rax # eface.dtype
  popq %rcx # eface.data
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # store dtype
  movq %rcx, 8(%rsi) # store data
  leaq 24(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  leaq -16(%rbp), %rax # local variable "err"
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
  leave
  ret

# Method os.$File.Write
.global os.$File.Write
os.$File.Write: # args 72, locals 0
  pushq %rbp
  movq %rsp, %rbp
  subq $24, %rsp # alloc return vars area
  subq $32, %rsp # alloc parameters area
  leaq 16(%rbp), %rax # local variable "f"
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
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq 24(%rbp), %rax # local variable "p"
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
  leaq 8(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  movq %rdx, 16(%rsi) # cap to cap
  callq syscall.Write
  addq $32, %rsp # free parameters area
  #  totalReturnSize=24
  leaq 48(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  pushq $0 # number literal
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

# Function os.ReadFile
.global os.ReadFile
os.ReadFile: # args 72, locals -64
  pushq %rbp
  movq %rsp, %rbp
  subq $64, %rsp # local area
  leaq -8(%rbp), %rax # local variable "fd"
  pushq %rax # variable address
  pushq $0 # T_INT zero value (number)
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  subq $24, %rsp # alloc return vars area
  subq $32, %rsp # alloc parameters area
  leaq 16(%rbp), %rax # local variable "filename"
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
  pushq $0 # number literal
  popq %rax # result of T_INT
  leaq 16(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  pushq $0 # number literal
  popq %rax # result of T_INT
  leaq 24(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  callq syscall.Open
  addq $32, %rsp # free parameters area
  #  totalReturnSize=24
  # len lhs=2
  # returnTypes=2
  leaq -8(%rbp), %rax # local variable "fd"
  pushq %rax # variable address
  popq %rsi # lhs addr
  popq %rax # result of T_INT
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  popq %rax # eface.dtype
  popq %rcx # eface.data
  leaq -8(%rbp), %rax # local variable "fd"
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
  jne .L.endif.73 # jmp if false
  subq $16, %rsp # alloc parameters area
  subq $16, %rsp # alloc return vars area
  subq $32, %rsp # alloc parameters area
  pushq $21 # str len
  leaq .string_5(%rip), %rax # str ptr
  pushq %rax # str ptr
  popq %rax # string.ptr
  popq %rcx # string.len
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  leaq 16(%rbp), %rax # local variable "filename"
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
  .L.endif.73:
  leaq -32(%rbp), %rax # local variable "buf"
  pushq %rax # variable address
  subq $24, %rsp # alloc return vars area
  subq $24, %rsp # alloc parameters area
  pushq $1 # number literal
  popq %rax # result of T_INT
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  pushq $2000000 # number literal
  popq %rax # result of T_INT
  leaq 8(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  pushq $2000000 # number literal
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
  leaq -40(%rbp), %rax # local variable "n"
  pushq %rax # variable address
  pushq $0 # T_INT zero value (number)
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  subq $24, %rsp # alloc return vars area
  subq $32, %rsp # alloc parameters area
  leaq -8(%rbp), %rax # local variable "fd"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rax # result of T_INT
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -32(%rbp), %rax # local variable "buf"
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
  leaq 8(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  movq %rdx, 16(%rsi) # cap to cap
  callq syscall.Read
  addq $32, %rsp # free parameters area
  #  totalReturnSize=24
  # len lhs=2
  # returnTypes=2
  leaq -40(%rbp), %rax # local variable "n"
  pushq %rax # variable address
  popq %rsi # lhs addr
  popq %rax # result of T_INT
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  popq %rax # eface.dtype
  popq %rcx # eface.data
  subq $16, %rsp # alloc return vars area
  subq $8, %rsp # alloc parameters area
  leaq -8(%rbp), %rax # local variable "fd"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rax # result of T_INT
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  callq syscall.Close
  addq $8, %rsp # free parameters area
  #  totalReturnSize=16
  leaq -64(%rbp), %rax # local variable "readbytes"
  pushq %rax # variable address
  leaq -32(%rbp), %rax # local variable "buf"
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
  leaq -40(%rbp), %rax # local variable "n"
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
  leaq -32(%rbp), %rax # local variable "buf"
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
  leaq 32(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  leaq -64(%rbp), %rax # local variable "readbytes"
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

# Function os.init
.global os.init
os.init: # args 16, locals 0
  pushq %rbp
  movq %rsp, %rbp
  leaq os.Args(%rip), %rax # global variable "Args"
  pushq %rax # variable address
  subq $24, %rsp # alloc return vars area
  subq $0, %rsp # alloc parameters area
  callq runtime.runtime_args
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
  leaq os.Stdin(%rip), %rax # global variable "Stdin"
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
  pushq $0 # number literal
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq os.Stdout(%rip), %rax # global variable "Stdout"
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
  pushq $1 # number literal
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq os.Stderr(%rip), %rax # global variable "Stderr"
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
  pushq $2 # number literal
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leave
  ret

# Function os.Getenv
.global os.Getenv
os.Getenv: # args 48, locals -16
  pushq %rbp
  movq %rsp, %rbp
  subq $16, %rsp # local area
  leaq -16(%rbp), %rax # local variable "v"
  pushq %rax # variable address
  subq $16, %rsp # alloc return vars area
  subq $16, %rsp # alloc parameters area
  leaq 16(%rbp), %rax # local variable "key"
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
  callq runtime.runtime_getenv
  addq $16, %rsp # free parameters area
  #  totalReturnSize=16
  popq %rax # string.ptr
  popq %rcx # string.len
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  leaq 32(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  leaq -16(%rbp), %rax # local variable "v"
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

# Function os.Exit
.global os.Exit
os.Exit: # args 24, locals 0
  pushq %rbp
  movq %rsp, %rbp
  subq $8, %rsp # alloc return vars area
  subq $32, %rsp # alloc parameters area
  pushq $60 # number literal
  popq %rax # result of T_UINTPTR
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq 16(%rbp), %rax # local variable "status"
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


