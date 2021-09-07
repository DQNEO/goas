# goas - a port of GNU Assembler written in go

# Platform
It supports Linux x86-64 AT&T syntax only

# USAGE

a.s
```as
# example code to exit with status 42
.text
.global _start
_start:
  movq $42, %rdi # status
  movq $60, %rax # sys_exit
  syscall
```

```terminal
$ go build -o as *.go
$ ./goas -o a.o a.s
$ ld -o a a.o
$ ./a; echo $?
42
```

# LICENSE

MIT

# AUTHOR

@DQNEO

