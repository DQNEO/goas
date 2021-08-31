# oneline instructions
nop
syscall
leave
ret

movq %rcx,0x8(%rsi)
movq %rax, 0(%rsi)
movq 8(%rax), %rdx # data
movq 0(%rax), %rax # dtype
movq 8+8(%rsp), %rcx
movzbq 0(%rax), %rax
movzwq 0(%rax), %rax
movb %al, 0(%rsi)
movw %ax, 0(%rsi)

leaq 8(%rsp),%rsi
leaq 8(%rsp),%rax
leaq 8(%rbp), %rsi
leaq 8(%rbp), %rax
leaq -260(%rbp), %rax

addq %rax, %rdi
subq $277, %rsp
subq $1, %rsp
divq %rcx

cmpq %rcx,%rdx
sete %al
setl %al
setle %al
setg %al
setge %al

