.data
var1:
  .quad 0x10
var2:
  .quad 0x20
  .quad 0x30
var3:
  .quad var4
var4:
  .quad 0x40
  .quad 0
var5:
  .quad var2
myGlobalInt:
  .quad 0x0a
pGlobalInt:
  .quad myGlobalInt
myString:
  .string "abcd"
myByte:
  .byte 1
.text
.global _start
_start:
  call myfunc1
  call myfunc2
  call myfunc3
  ret

myfunc1:
  movq var1(%rip), %rcx
  movq $0x1a, %rcx
  ret
myfunc2:
  movq $0x3c, %rax # sys_exit
  movq $0x2a, %rdi # status code
  syscall
  ret
myfunc3:
  ret
start2:
  nop
  callq myfunc4
  callq myfunc5

  movq pGlobalInt(%rip), %rax
  movq (%rax), %rax
  movq $0x20, %rdi
  addq %rax, %rdi
  movq $0x3c, %rax
  syscall

  retq
myfunc4:
  retq
myfunc5:
  movb %al, 0(%rsi)
  movzbq 0(%rax), %rax
  sete %al
  setl %al
  setg %al
  setge %al
  divq %rcx
  subq $277, %rsp
  subq $1, %rsp
  movzwq 0(%rax), %rax
  setle %al
  movq 8+8(%rsp), %rcx
  movw %ax, 0(%rsi)
  leaq 8(%rsp),%rsi
  leaq 8(%rsp),%rax
  leaq 8(%rbp), %rsi
  leaq 8(%rbp), %rax
  movq %rax, 0(%rsi)
  retq
