#=== Package github.com/DQNEO/babygo/lib/mylib2
#--- walk 
# Package types:
#--- string literals
.data
#--- global vars (static values)

#--- global vars (dynamic value setting)
.text
.global mylib2.__initGlobals
mylib2.__initGlobals:
  ret

# Function mylib2.Sum2
.global mylib2.Sum2
mylib2.Sum2: # args 40, locals 0
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
# ------- Dynamic Types ------
.data


