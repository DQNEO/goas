# oneline instructions
nop
syscall
leave
ret
movq $1, %rax
movq %rcx,0x8(%rsi)
movq %rax, 0(%rsi)
movq 8(%rax), %rdx
movq 0(%rax), %rax
movq 8+8(%rsp), %rcx
movb %al, 0(%rsi)
movw %ax, 0(%rsi)
movzbq 0(%rax), %rax
movzbq (%rsp), %rax
movzwq 0(%rax), %rax
movq %rax, 0(%rsp)
movq %rax, (%rsp)

movq $0, %r10
movq $0, %r8
movq $0, %r9
movq 0x18(%rsp),%r12

leaq 8(%rsp),%rsi
leaq 8(%rsp),%rax
leaq 8(%rbp), %rsi
leaq 8(%rbp), %rax
leaq -260(%rbp), %rax

addq %rax, %rdi
addq $0x20,%rsp
subq $277, %rsp
subq $1, %rsp
divq %rcx

cmpq %rcx,%rdx
sete %al
setl %al
setle %al
setg %al
setge %al
