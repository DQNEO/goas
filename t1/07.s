# exit with 42
.data
myGlobalInt:
  .quad 0x0a
pGlobalInt:
  .quad myGlobalInt

.text
.global _start
_start:
  call myfunc1
  ret

myfunc1:
  movq $0x3c, %rax # 60 sys_exit

  movq pGlobalInt(%rip), %rax
  movq (%rax), %rax # 10
  movq $0x20, %rdi # 32
  addq %rdi, %rax # 42
  syscall
