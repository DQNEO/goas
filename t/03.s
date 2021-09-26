# minimum code that exits with status 42
.text
.global _start
_start:
  movq $42, %rdi # status
  movq $60, %rax # sys_exit
  syscall
