#=== Package github.com/DQNEO/babygo/lib/fmt
#--- walk 
# Package types:
#--- string literals
.data
.string_0:
  .string "%!s(int="
.string_1:
  .string ")"
.string_2:
  .string "unknown type"
.string_3:
  .string "%!d(string="
.string_4:
  .string ")"
.string_5:
  .string "unknown type"
.string_6:
  .string "Sprintf: Unknown format:"
#--- global vars (static values)

#--- global vars (dynamic value setting)
.text
.global fmt.__initGlobals
fmt.__initGlobals:
  ret

# Function fmt.Sprintf
.global fmt.Sprintf
fmt.Sprintf: # args 72, locals -277
  pushq %rbp
  movq %rsp, %rbp
  subq $277, %rsp # local area
  leaq -24(%rbp), %rax # local variable "r"
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
  leaq -32(%rbp), %rax # local variable "inPercent"
  pushq %rax # variable address
  pushq $0 # T_BOOL zero value (number)
  popq %rax # result of T_BOOL
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -40(%rbp), %rax # local variable "argIndex"
  pushq %rax # variable address
  pushq $0 # T_INT zero value (number)
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -260(%rbp), %rax # local variable ".range.len"
  pushq %rax # variable address
  leaq 16(%rbp), %rax # local variable "format"
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
  leaq -268(%rbp), %rax # local variable ".range.index"
  pushq %rax # variable address
  pushq $0 # T_INT zero value (number)
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  .L.range.cond.111:
  leaq -268(%rbp), %rax # local variable ".range.index"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  leaq -260(%rbp), %rax # local variable ".range.len"
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
  jne .L.range.exit.111 # jmp if false
  leaq -277(%rbp), %rax # local variable "c"
  pushq %rax # variable address
  leaq -268(%rbp), %rax # local variable ".range.index"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  leaq 16(%rbp), %rax # local variable "format"
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
  leaq -32(%rbp), %rax # local variable "inPercent"
  pushq %rax # variable address
  popq %rax # address of T_BOOL
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rax # result of if condition
  cmpq $1, %rax
  jne .L.else.112 # jmp if false
  leaq -277(%rbp), %rax # local variable "c"
  pushq %rax # variable address
  popq %rax # address of T_UINT8
  movzbq 0(%rax), %rax # load uint8
  pushq %rax
  pushq $37 # convert char literal to int
  popq %rcx # right
  popq %rax # left
  cmpq %rcx, %rax
  sete %al
  movzbq %al, %rax
  pushq %rax
  popq %rax # result of if condition
  cmpq $1, %rax
  jne .L.else.113 # jmp if false
  leaq -24(%rbp), %rax # local variable "r"
  pushq %rax # variable address
  subq $24, %rsp # alloc return vars area
  subq $25, %rsp # alloc parameters area
  leaq -24(%rbp), %rax # local variable "r"
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
  pushq $37 # convert char literal to int
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
  jmp .L.endif.113
  .L.else.113:
  leaq -56(%rbp), %rax # local variable "arg"
  pushq %rax # variable address
  leaq -40(%rbp), %rax # local variable "argIndex"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  leaq 32(%rbp), %rax # local variable "a"
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
  leaq -57(%rbp), %rax # local variable "sign"
  pushq %rax # variable address
  leaq -277(%rbp), %rax # local variable "c"
  pushq %rax # variable address
  popq %rax # address of T_UINT8
  movzbq 0(%rax), %rax # load uint8
  pushq %rax
  popq %rax # result of T_UINT8
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movb %al, 0(%rsi) # assign byte
  leaq -73(%rbp), %rax # local variable "str"
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
  leaq -57(%rbp), %rax # local variable "sign"
  pushq %rax # variable address
  popq %rax # address of T_UINT8
  movzbq 0(%rax), %rax # load uint8
  pushq %rax
  movq 0(%rsp), %rax # copy stack top value (switch expr) 
  pushq %rax
  pushq $35 # convert char literal to int
  popq %rcx # right
  popq %rax # left
  cmpq %rcx, %rax
  sete %al
  movzbq %al, %rax
  pushq %rax
  popq %rax # result of  of switch-case comparison
  cmpq $1, %rax
  je .L.case.115 # jump if match
  movq 0(%rsp), %rax # copy stack top value (switch expr) 
  pushq %rax
  pushq $115 # convert char literal to int
  popq %rcx # right
  popq %rax # left
  cmpq %rcx, %rax
  sete %al
  movzbq %al, %rax
  pushq %rax
  popq %rax # result of  of switch-case comparison
  cmpq $1, %rax
  je .L.case.116 # jump if match
  movq 0(%rsp), %rax # copy stack top value (switch expr) 
  pushq %rax
  pushq $100 # convert char literal to int
  popq %rcx # right
  popq %rax # left
  cmpq %rcx, %rax
  sete %al
  movzbq %al, %rax
  pushq %rax
  popq %rax # result of  of switch-case comparison
  cmpq $1, %rax
  je .L.case.117 # jump if match
  movq 0(%rsp), %rax # copy stack top value (switch expr) 
  pushq %rax
  pushq $112 # convert char literal to int
  popq %rcx # right
  popq %rax # left
  cmpq %rcx, %rax
  sete %al
  movzbq %al, %rax
  pushq %rax
  popq %rax # result of  of switch-case comparison
  cmpq $1, %rax
  je .L.case.117 # jump if match
  movq 0(%rsp), %rax # copy stack top value (switch expr) 
  pushq %rax
  pushq $84 # convert char literal to int
  popq %rcx # right
  popq %rax # left
  cmpq %rcx, %rax
  sete %al
  movzbq %al, %rax
  pushq %rax
  popq %rax # result of  of switch-case comparison
  cmpq $1, %rax
  je .L.case.118 # jump if match
  jmp .L.case.119
  addq $1, %rsp # revert stack top
  .L.case.115:
  jmp .L.switch.114.exit
  .L.case.116:
  leaq -89(%rbp), %rax # local variable ".switch_expr"
  pushq %rax # variable address
  leaq -56(%rbp), %rax # local variable "arg"
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
  leaq -89(%rbp), %rax # local variable ".switch_expr"
  pushq %rax # variable address
  popq %rax # address of type switch subject
  movq (%rax), %rax # dtype label addr
  pushq %rax # dtype label addr
  leaq .dtype.1(%rip), %rax # dtype label address "string"
  pushq %rax           # dtype label address
  popq %rdx           # dtype label address A
  popq %rcx           # dtype label address B
  cmpq %rcx, %rdx
  je .L.cmpdtypes.122.true # jump if match
  cmpq $0, %rdx # check if A is nil
  je .L.cmpdtypes.122.false # jump if nil
  cmpq $0, %rcx # check if B is nil
  je .L.cmpdtypes.122.false # jump if nil
  jmp .L.cmpdtypes.122.cmp # jump to end
  .L.cmpdtypes.122.true:
  pushq $1
  jmp .L.cmpdtypes.122.end # jump to end
  .L.cmpdtypes.122.false:
  pushq $0
  jmp .L.cmpdtypes.122.end # jump to end
  .L.cmpdtypes.122.cmp:
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
  .L.cmpdtypes.122.end:
  popq %rax # result of  of switch-case comparison
  cmpq $1, %rax
  je .L.case.121 # jump if match
  leaq -89(%rbp), %rax # local variable ".switch_expr"
  pushq %rax # variable address
  popq %rax # address of type switch subject
  movq (%rax), %rax # dtype label addr
  pushq %rax # dtype label addr
  leaq .dtype.2(%rip), %rax # dtype label address "int"
  pushq %rax           # dtype label address
  popq %rdx           # dtype label address A
  popq %rcx           # dtype label address B
  cmpq %rcx, %rdx
  je .L.cmpdtypes.124.true # jump if match
  cmpq $0, %rdx # check if A is nil
  je .L.cmpdtypes.124.false # jump if nil
  cmpq $0, %rcx # check if B is nil
  je .L.cmpdtypes.124.false # jump if nil
  jmp .L.cmpdtypes.124.cmp # jump to end
  .L.cmpdtypes.124.true:
  pushq $1
  jmp .L.cmpdtypes.124.end # jump to end
  .L.cmpdtypes.124.false:
  pushq $0
  jmp .L.cmpdtypes.124.end # jump to end
  .L.cmpdtypes.124.cmp:
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
  .L.cmpdtypes.124.end:
  popq %rax # result of  of switch-case comparison
  cmpq $1, %rax
  je .L.case.123 # jump if match
  jmp .L.case.125
  .L.case.121:
  leaq -105(%rbp), %rax # local variable "_arg"
  pushq %rax # variable address
  leaq -89(%rbp), %rax # local variable ".switch_expr"
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
  leaq -73(%rbp), %rax # local variable "str"
  pushq %rax # variable address
  leaq -105(%rbp), %rax # local variable "_arg"
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
  jmp .L.typeswitch.120.exit
  .L.case.123:
  leaq -113(%rbp), %rax # local variable "_arg"
  pushq %rax # variable address
  leaq -89(%rbp), %rax # local variable ".switch_expr"
  pushq %rax # variable address
  popq %rax # address of T_INTERFACE
  movq 8(%rax), %rdx # data
  movq 0(%rax), %rax # dtype
  pushq %rdx # data
  pushq %rax # dtype
  popq %rax # ifc.dtype
  popq %rcx # ifc.data
  pushq %rcx # ifc.data
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -129(%rbp), %rax # local variable "strNumber"
  pushq %rax # variable address
  subq $16, %rsp # alloc return vars area
  subq $8, %rsp # alloc parameters area
  leaq -113(%rbp), %rax # local variable "_arg"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rax # result of T_INT
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  callq strconv.Itoa
  addq $8, %rsp # free parameters area
  #  totalReturnSize=16
  popq %rax # string.ptr
  popq %rcx # string.len
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  leaq -113(%rbp), %rax # local variable "_arg"
  pushq %rax # variable address
  leaq -89(%rbp), %rax # local variable ".switch_expr"
  pushq %rax # variable address
  popq %rax # address of T_INTERFACE
  movq 8(%rax), %rdx # data
  movq 0(%rax), %rax # dtype
  pushq %rdx # data
  pushq %rax # dtype
  popq %rax # ifc.dtype
  popq %rcx # ifc.data
  pushq %rcx # ifc.data
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -73(%rbp), %rax # local variable "str"
  pushq %rax # variable address
  subq $16, %rsp # alloc return vars area
  subq $32, %rsp # alloc parameters area
  subq $16, %rsp # alloc return vars area
  subq $32, %rsp # alloc parameters area
  pushq $8 # str len
  leaq .string_0(%rip), %rax # str ptr
  pushq %rax # str ptr
  popq %rax # string.ptr
  popq %rcx # string.len
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  leaq -129(%rbp), %rax # local variable "strNumber"
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
  jmp .L.typeswitch.120.exit
  .L.case.125:
  leaq -73(%rbp), %rax # local variable "str"
  pushq %rax # variable address
  pushq $12 # str len
  leaq .string_2(%rip), %rax # str ptr
  pushq %rax # str ptr
  popq %rax # string.ptr
  popq %rcx # string.len
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  jmp .L.typeswitch.120.exit
  .L.typeswitch.120.exit:
  leaq -137(%rbp), %rax # local variable ".range.len"
  pushq %rax # variable address
  leaq -73(%rbp), %rax # local variable "str"
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
  leaq -145(%rbp), %rax # local variable ".range.index"
  pushq %rax # variable address
  pushq $0 # T_INT zero value (number)
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  .L.range.cond.126:
  leaq -145(%rbp), %rax # local variable ".range.index"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  leaq -137(%rbp), %rax # local variable ".range.len"
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
  jne .L.range.exit.126 # jmp if false
  leaq -154(%rbp), %rax # local variable "_c"
  pushq %rax # variable address
  leaq -145(%rbp), %rax # local variable ".range.index"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  leaq -73(%rbp), %rax # local variable "str"
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
  leaq -24(%rbp), %rax # local variable "r"
  pushq %rax # variable address
  subq $24, %rsp # alloc return vars area
  subq $25, %rsp # alloc parameters area
  leaq -24(%rbp), %rax # local variable "r"
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
  leaq -154(%rbp), %rax # local variable "_c"
  pushq %rax # variable address
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
  .L.range.post.126:
  leaq -145(%rbp), %rax # local variable ".range.index"
  pushq %rax # variable address
  leaq -145(%rbp), %rax # local variable ".range.index"
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
  jmp .L.range.cond.126
  .L.range.exit.126:
  jmp .L.switch.114.exit
  .L.case.117:
  leaq -170(%rbp), %rax # local variable ".switch_expr"
  pushq %rax # variable address
  leaq -56(%rbp), %rax # local variable "arg"
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
  leaq -170(%rbp), %rax # local variable ".switch_expr"
  pushq %rax # variable address
  popq %rax # address of type switch subject
  movq (%rax), %rax # dtype label addr
  pushq %rax # dtype label addr
  leaq .dtype.1(%rip), %rax # dtype label address "string"
  pushq %rax           # dtype label address
  popq %rdx           # dtype label address A
  popq %rcx           # dtype label address B
  cmpq %rcx, %rdx
  je .L.cmpdtypes.129.true # jump if match
  cmpq $0, %rdx # check if A is nil
  je .L.cmpdtypes.129.false # jump if nil
  cmpq $0, %rcx # check if B is nil
  je .L.cmpdtypes.129.false # jump if nil
  jmp .L.cmpdtypes.129.cmp # jump to end
  .L.cmpdtypes.129.true:
  pushq $1
  jmp .L.cmpdtypes.129.end # jump to end
  .L.cmpdtypes.129.false:
  pushq $0
  jmp .L.cmpdtypes.129.end # jump to end
  .L.cmpdtypes.129.cmp:
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
  .L.cmpdtypes.129.end:
  popq %rax # result of  of switch-case comparison
  cmpq $1, %rax
  je .L.case.128 # jump if match
  leaq -170(%rbp), %rax # local variable ".switch_expr"
  pushq %rax # variable address
  popq %rax # address of type switch subject
  movq (%rax), %rax # dtype label addr
  pushq %rax # dtype label addr
  leaq .dtype.2(%rip), %rax # dtype label address "int"
  pushq %rax           # dtype label address
  popq %rdx           # dtype label address A
  popq %rcx           # dtype label address B
  cmpq %rcx, %rdx
  je .L.cmpdtypes.131.true # jump if match
  cmpq $0, %rdx # check if A is nil
  je .L.cmpdtypes.131.false # jump if nil
  cmpq $0, %rcx # check if B is nil
  je .L.cmpdtypes.131.false # jump if nil
  jmp .L.cmpdtypes.131.cmp # jump to end
  .L.cmpdtypes.131.true:
  pushq $1
  jmp .L.cmpdtypes.131.end # jump to end
  .L.cmpdtypes.131.false:
  pushq $0
  jmp .L.cmpdtypes.131.end # jump to end
  .L.cmpdtypes.131.cmp:
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
  .L.cmpdtypes.131.end:
  popq %rax # result of  of switch-case comparison
  cmpq $1, %rax
  je .L.case.130 # jump if match
  jmp .L.case.132
  .L.case.128:
  leaq -186(%rbp), %rax # local variable "_arg"
  pushq %rax # variable address
  leaq -170(%rbp), %rax # local variable ".switch_expr"
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
  leaq -73(%rbp), %rax # local variable "str"
  pushq %rax # variable address
  subq $16, %rsp # alloc return vars area
  subq $32, %rsp # alloc parameters area
  subq $16, %rsp # alloc return vars area
  subq $32, %rsp # alloc parameters area
  pushq $11 # str len
  leaq .string_3(%rip), %rax # str ptr
  pushq %rax # str ptr
  popq %rax # string.ptr
  popq %rcx # string.len
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  leaq -186(%rbp), %rax # local variable "_arg"
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
  jmp .L.typeswitch.127.exit
  .L.case.130:
  leaq -194(%rbp), %rax # local variable "_arg"
  pushq %rax # variable address
  leaq -170(%rbp), %rax # local variable ".switch_expr"
  pushq %rax # variable address
  popq %rax # address of T_INTERFACE
  movq 8(%rax), %rdx # data
  movq 0(%rax), %rax # dtype
  pushq %rdx # data
  pushq %rax # dtype
  popq %rax # ifc.dtype
  popq %rcx # ifc.data
  pushq %rcx # ifc.data
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -73(%rbp), %rax # local variable "str"
  pushq %rax # variable address
  subq $16, %rsp # alloc return vars area
  subq $8, %rsp # alloc parameters area
  leaq -194(%rbp), %rax # local variable "_arg"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rax # result of T_INT
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  callq strconv.Itoa
  addq $8, %rsp # free parameters area
  #  totalReturnSize=16
  popq %rax # string.ptr
  popq %rcx # string.len
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  jmp .L.typeswitch.127.exit
  .L.case.132:
  leaq -73(%rbp), %rax # local variable "str"
  pushq %rax # variable address
  pushq $12 # str len
  leaq .string_5(%rip), %rax # str ptr
  pushq %rax # str ptr
  popq %rax # string.ptr
  popq %rcx # string.len
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  jmp .L.typeswitch.127.exit
  .L.typeswitch.127.exit:
  leaq -202(%rbp), %rax # local variable ".range.len"
  pushq %rax # variable address
  leaq -73(%rbp), %rax # local variable "str"
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
  leaq -210(%rbp), %rax # local variable ".range.index"
  pushq %rax # variable address
  pushq $0 # T_INT zero value (number)
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  .L.range.cond.133:
  leaq -210(%rbp), %rax # local variable ".range.index"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  leaq -202(%rbp), %rax # local variable ".range.len"
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
  jne .L.range.exit.133 # jmp if false
  leaq -219(%rbp), %rax # local variable "_c"
  pushq %rax # variable address
  leaq -210(%rbp), %rax # local variable ".range.index"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  leaq -73(%rbp), %rax # local variable "str"
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
  leaq -24(%rbp), %rax # local variable "r"
  pushq %rax # variable address
  subq $24, %rsp # alloc return vars area
  subq $25, %rsp # alloc parameters area
  leaq -24(%rbp), %rax # local variable "r"
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
  leaq -219(%rbp), %rax # local variable "_c"
  pushq %rax # variable address
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
  .L.range.post.133:
  leaq -210(%rbp), %rax # local variable ".range.index"
  pushq %rax # variable address
  leaq -210(%rbp), %rax # local variable ".range.index"
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
  jmp .L.range.cond.133
  .L.range.exit.133:
  jmp .L.switch.114.exit
  .L.case.118:
  leaq -227(%rbp), %rax # local variable "t"
  pushq %rax # variable address
  subq $8, %rsp # alloc return vars area
  subq $16, %rsp # alloc parameters area
  leaq -56(%rbp), %rax # local variable "arg"
  pushq %rax # variable address
  popq %rax # address of T_INTERFACE
  movq 8(%rax), %rdx # data
  movq 0(%rax), %rax # dtype
  pushq %rdx # data
  pushq %rax # dtype
  popq %rax # eface.dtype
  popq %rcx # eface.data
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # store dtype
  movq %rcx, 8(%rsi) # store data
  callq reflect.TypeOf
  addq $16, %rsp # free parameters area
  #  totalReturnSize=8
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq -227(%rbp), %rax # local variable "t"
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
  popq %rax # result of if condition
  cmpq $1, %rax
  jne .L.else.134 # jmp if false
  jmp .L.endif.134
  .L.else.134:
  leaq -73(%rbp), %rax # local variable "str"
  pushq %rax # variable address
  subq $16, %rsp # alloc return vars area
  subq $8, %rsp # alloc parameters area
  leaq -227(%rbp), %rax # local variable "t"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_POINTER
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  callq reflect.$Type.String
  addq $8, %rsp # free parameters area
  #  totalReturnSize=16
  popq %rax # string.ptr
  popq %rcx # string.len
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  .L.endif.134:
  leaq -235(%rbp), %rax # local variable ".range.len"
  pushq %rax # variable address
  leaq -73(%rbp), %rax # local variable "str"
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
  leaq -243(%rbp), %rax # local variable ".range.index"
  pushq %rax # variable address
  pushq $0 # T_INT zero value (number)
  popq %rax # result of T_INT
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  .L.range.cond.135:
  leaq -243(%rbp), %rax # local variable ".range.index"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  leaq -235(%rbp), %rax # local variable ".range.len"
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
  jne .L.range.exit.135 # jmp if false
  leaq -252(%rbp), %rax # local variable "_c"
  pushq %rax # variable address
  leaq -243(%rbp), %rax # local variable ".range.index"
  pushq %rax # variable address
  popq %rax # address of T_INT
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  leaq -73(%rbp), %rax # local variable "str"
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
  leaq -24(%rbp), %rax # local variable "r"
  pushq %rax # variable address
  subq $24, %rsp # alloc return vars area
  subq $25, %rsp # alloc parameters area
  leaq -24(%rbp), %rax # local variable "r"
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
  leaq -252(%rbp), %rax # local variable "_c"
  pushq %rax # variable address
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
  .L.range.post.135:
  leaq -243(%rbp), %rax # local variable ".range.index"
  pushq %rax # variable address
  leaq -243(%rbp), %rax # local variable ".range.index"
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
  jmp .L.range.cond.135
  .L.range.exit.135:
  jmp .L.switch.114.exit
  .L.case.119:
  subq $16, %rsp # alloc parameters area
  subq $16, %rsp # alloc return vars area
  subq $32, %rsp # alloc parameters area
  pushq $24 # str len
  leaq .string_6(%rip), %rax # str ptr
  pushq %rax # str ptr
  popq %rax # string.ptr
  popq %rcx # string.len
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  subq $8, %rsp # alloc return vars area
  pushq $1
  callq runtime.malloc
  addq $8, %rsp # free parameters area
  #  totalReturnSize=8
  movq 0(%rsp), %rax # copy stack top value (malloced address) 
  pushq %rax
  popq %rax
  addq $0, %rax
  pushq %rax
  leaq -57(%rbp), %rax # local variable "sign"
  pushq %rax # variable address
  popq %rax # address of T_UINT8
  movzbq 0(%rax), %rax # load uint8
  pushq %rax
  popq %rax # result of T_UINT8
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movb %al, 0(%rsi) # assign byte
  popq %rax # address of malloc
  pushq $1 # slice.cap
  pushq $1 # slice.len
  pushq %rax # slice.ptr
  popq %rax # slice.ptr
  popq %rcx # slice.len
  popq %rdx # slice.cap
  pushq %rcx # str len
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
  jmp .L.switch.114.exit
  .L.switch.114.exit:
  leaq -40(%rbp), %rax # local variable "argIndex"
  pushq %rax # variable address
  leaq -40(%rbp), %rax # local variable "argIndex"
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
  .L.endif.113:
  leaq -32(%rbp), %rax # local variable "inPercent"
  pushq %rax # variable address
  pushq $0 # false
  popq %rax # result of T_BOOL
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  jmp .L.endif.112
  .L.else.112:
  leaq -277(%rbp), %rax # local variable "c"
  pushq %rax # variable address
  popq %rax # address of T_UINT8
  movzbq 0(%rax), %rax # load uint8
  pushq %rax
  pushq $37 # convert char literal to int
  popq %rcx # right
  popq %rax # left
  cmpq %rcx, %rax
  sete %al
  movzbq %al, %rax
  pushq %rax
  popq %rax # result of if condition
  cmpq $1, %rax
  jne .L.else.136 # jmp if false
  leaq -32(%rbp), %rax # local variable "inPercent"
  pushq %rax # variable address
  pushq $1 # true
  popq %rax # result of T_BOOL
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  jmp .L.endif.136
  .L.else.136:
  leaq -24(%rbp), %rax # local variable "r"
  pushq %rax # variable address
  subq $24, %rsp # alloc return vars area
  subq $25, %rsp # alloc parameters area
  leaq -24(%rbp), %rax # local variable "r"
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
  leaq -277(%rbp), %rax # local variable "c"
  pushq %rax # variable address
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
  .L.endif.136:
  .L.endif.112:
  .L.range.post.111:
  leaq -268(%rbp), %rax # local variable ".range.index"
  pushq %rax # variable address
  leaq -268(%rbp), %rax # local variable ".range.index"
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
  jmp .L.range.cond.111
  .L.range.exit.111:
  leaq 56(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  leaq -24(%rbp), %rax # local variable "r"
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

# Function fmt.Printf
.global fmt.Printf
fmt.Printf: # args 56, locals -16
  pushq %rbp
  movq %rsp, %rbp
  subq $16, %rsp # local area
  leaq -16(%rbp), %rax # local variable "s"
  pushq %rax # variable address
  subq $16, %rsp # alloc return vars area
  subq $40, %rsp # alloc parameters area
  leaq 16(%rbp), %rax # local variable "format"
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
  leaq 32(%rbp), %rax # local variable "a"
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
  leaq 16(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  movq %rdx, 16(%rsi) # cap to cap
  callq fmt.Sprintf
  addq $40, %rsp # free parameters area
  #  totalReturnSize=16
  popq %rax # string.ptr
  popq %rcx # string.len
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  subq $24, %rsp # alloc return vars area
  subq $32, %rsp # alloc parameters area
  pushq $1 # number literal
  popq %rax # result of T_INT
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -16(%rbp), %rax # local variable "s"
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
  callq syscall.Write
  addq $32, %rsp # free parameters area
  #  totalReturnSize=24
  leave
  ret

# Function fmt.Fprintf
.global fmt.Fprintf
fmt.Fprintf: # args 64, locals -16
  pushq %rbp
  movq %rsp, %rbp
  subq $16, %rsp # local area
  leaq -16(%rbp), %rax # local variable "s"
  pushq %rax # variable address
  subq $16, %rsp # alloc return vars area
  subq $40, %rsp # alloc parameters area
  leaq 24(%rbp), %rax # local variable "format"
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
  leaq 40(%rbp), %rax # local variable "a"
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
  leaq 16(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  movq %rdx, 16(%rsi) # cap to cap
  callq fmt.Sprintf
  addq $40, %rsp # free parameters area
  #  totalReturnSize=16
  popq %rax # string.ptr
  popq %rcx # string.len
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  subq $24, %rsp # alloc return vars area
  subq $32, %rsp # alloc parameters area
  leaq 16(%rbp), %rax # local variable "w"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_POINTER
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq -16(%rbp), %rax # local variable "s"
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
  callq os.$File.Write
  addq $32, %rsp # free parameters area
  #  totalReturnSize=24
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
.dtype.2: # int
  .quad 2
  .quad .string.dtype.2
  .quad 3
.string.dtype.2:
  .string "int"


