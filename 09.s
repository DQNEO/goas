# oneline instructions
movq %rcx,0x8(%rsi)
cmpq %rcx,%rdx
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
leaq -260(%rbp), %rax
movq 8(%rax), %rdx # data
movq 0(%rax), %rax # dtype
