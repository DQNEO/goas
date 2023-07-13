package main

import (
	"reflect"
	"testing"
)

func TestEncodeStringAsText(t *testing.T) {
	tests := []struct {
		name    string
		source  string
		encoded []byte
	}{
		// Simple instructions
		// Note: rdi:111, rbp:101, rbx:011
		{"nop", "nop", []byte{0x90}},
		{"ret", "ret", []byte{0xc3}},
		{"syscall", "syscall", []byte{0x0f, 0x05}},
		{"leave", "leave", []byte{0xc9}},

		{"multi statements", "nop;ret;leave;", []byte{0x90, 0xc3, 0xc9}},

		{"callq SYMBOL", "callq myfunc", []byte{0xe8, 0, 0, 0, 0}},

		{"leaq IND8, REG", "leaq 127(%rbp), %rdi", []byte{0x48, 0x8d, 0b01_111_101, 0x7f}},
		{"leaq IND0, REG", "leaq 0(%rbp), %rdi", []byte{0x48, 0x8d, 0b01_111_101, 0}},
		{"leaq IND0, REG", "leaq 0(%rsp), %rdi", []byte{0x48, 0x8d, 0b00_111_100, 0b00_100_100}},
		{"movb REG, IND", "movb %bl, 0(%rdi)", []byte{0x88, 0b00_011_111}},
		{"movw REG, IND", "movw %bx, 0(%rdi)", []byte{0x66, 0x89, 0b00_011_111}},
		{"movl IMM32, REG", "movl $2147483647, %ebx", []byte{0xb8 + 0b011, 0xff, 0xff, 0xff, 0x7f}},

		{"movq IMM32, REG", "movq $2147483647, %rdi", []byte{0x48, 0xc7, 0b11_000_111, 0xff, 0xff, 0xff, 0x7f}},
		{"movq IMM32, EXREG", "movq $2147483647, %r8", []byte{0x49, 0xc7, 0b11_000_000, 0xff, 0xff, 0xff, 0x7f}},
		{"movq REG, REG", "movq %rbp, %rdi", []byte{0x48, 0x89, 0b11_101_111}},

		{"movzwq IND, REG", "movzwq 0(%rbp), %rdi", []byte{0x48, 0x0f, 0xb7, 0b00_101_111}},
		{"addq REG, REG", "addq %rbp, %rdi", []byte{0x48, 0x01, 0b11_101_111}},
		{"sete REG", "sete %rdi", []byte{0x0f, 0x94, 0b11_111_000}},
		{"pushq REG", "pushq %rdi", []byte{0x50 + 0b111}},
		{"pushq IMM8", "pushq $127", []byte{0x6a, 0x7f}},
		{"pushq IMM32", "pushq $2147483647", []byte{0x68, 0xff, 0xff, 0xff, 0x7f}},
		{"popq REG", "popq %rdi", []byte{0x58 + 0b111}},
		{"xorq IMM8", "xorq $127, %rdi", []byte{0x48, 0x83, 0b11_110_111, 0x7f}},
		{"xorq REG", "xorq %rbp, %rdi", []byte{0x48, 0x31, 0b11_101_111}},
		{"andq REG", "andq %rbp, %rdi", []byte{0x48, 0x21, 0b11_101_111}},
		{"orq REG", "orq %rbp, %rdi", []byte{0x48, 0x09, 0b11_101_111}},
	}
	for _, tt := range tests {
		tt := tt
		t.Run(tt.name, func(t *testing.T) {
			t.Parallel()
			encoded, data := EncodeString(tt.source)
			_ = data
			if !reflect.DeepEqual(encoded, tt.encoded) {
				t.Errorf("EncodeString() %s got = 0x%x, want 0x%x", tt.source, encoded, tt.encoded)
			}
		})
	}
}
