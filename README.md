# goas - a port of GNU Assembler written in go

`goas` is an assembler that behaves like `as`, GNU Assembler.

This is just a toy program to illustrate how an assembler works. Actually I learned how an assembler works by writing this program :).

It does not mean to support all syntax or instructions, but  Linux x86-64 AT&T syntax only.
However, for any input it supports, it behaves exactly the same as `as`,
 which means it produces the very same binary files (*.o) as `as` does.

The most interesting thing is that it can assemble my Go compiler [babygo](https://github.com/DQNEO/babygo). (You can see it by running `make babygo`.)


# Requirements

You need a linux with gcc installed.
If you are using MacOS or Windows, you can use my docker image to run `goas`.

```cgo
docker run --rm -it -v `pwd`:/mnt/goas -w /mnt/goas dqneo/ubuntu-build-essential:go bash 
```

# How to build

```
$ go build
```

# How to use

Prepare a small assembly file `test.s`

```asm
.text
.global _start
_start:
  movq $42, %rdi # status
  movq $60, %rax # sys_exit
  syscall
```

And you can assemble it

```terminal
$ ./goas -o test.o test.s
$ ld -o test test.o
$ ./test; echo $?
42
```

## Demo

![goas-min-demo](https://user-images.githubusercontent.com/188741/134793225-411c06e7-982d-44aa-8fec-34139d5d080b.gif)


# Supported Instructions

See test files under `/t` and `/t2` directory to know what syntax it can assemble.

# Design

`goas` is composed of 4 files.

File|Role
---|---
parser.go | parser
encoder.go | instruction encoder
elf_writer.go | ELF format writer
main.go | miscellaneous tasks

### Parser

`parser.go` is a simple recursive descent parser. The boundary between lexer nd parser are not clearly separated.

Each line of source code is converted into a statement object.

It produces a list of statements in the end.

### Instruction encoder

`encoder.go` translates an instruction with operands into a piece of x86-64 binary machine code.

### ELF format Writer

`elf_writer.go` composes an object which represents ELF file format and write it into a binary object file.

# Test

```
$ make test
```

# References

ELF

* https://refspecs.linuxfoundation.org/elf/elf.pdf ELF Specification
* https://man7.org/linux/man-pages/man5/elf.5.html ELF man
* https://sourceware.org/git/?p=glibc.git;a=blob;f=elf/elf.h;h=4738dfa28f6549fc11654996a15659dc8007e686;hb=HEAD libc elf.h

GNU Asssembler

* https://sourceware.org/binutils/docs-2.37/as.html Manual of GNU Assembler

X86-64 Instruction set and encoding

* https://software.intel.com/content/www/us/en/develop/articles/intel-sdm.html Intel® 64 and IA-32 Architectures Software Developer Manuals
* https://hikalium.github.io/opv86/ Opcode/Instruction finder for x86_64

# License

MIT

# Author

[@DQNEO](https://twitter.com/DQNEO)

