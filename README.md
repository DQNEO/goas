# goas - a port of GNU Assembler written in go

`goas` is an assembler that behaves like `as`, GNU Assembler.

This is just a toy program. It does not to support all syntax or instructions.
Currently It supports Linux x86-64 AT&T syntax only.

However, for any input it supports, it behaves exactly the same as `as`, which means it produces the same binary *.o files as `as` does.

The most interesting thing is that it can assemble [babygo](https://github.com/DQNEO/babygo), my Go compiler. ( `make babygo` shows the example .)

# BUILD

```
$ go build -o goas *.go
```

# USAGE

Write a small assembly file `test.s`

```as
# example code to exit with status 42
.text
.global _start
_start:
  movq $42, %rdi # status
  movq $60, %rax # sys_exit
  syscall
```

Assemble it

```terminal
$ ./goas -o test.o test.s
$ ld -o test test.o
$ ./test; echo $?
42
```

# Supported Instructions

See test files under `./t` directory to know what syntax it can asseemble.



# LICENSE

MIT

# AUTHOR

@DQNEO

