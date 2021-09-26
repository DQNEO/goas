# hello world
.data
msg:
  .string "hello world"

.text
.global main
main:
  leaq msg(%rip), %rdi
  callq puts
  movq $0, %rax
  ret
