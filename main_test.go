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
		{"nop", "nop", []byte{0x90}},
		{"ret", "ret", []byte{0xc3}},
		{"syscall", "syscall", []byte{0x0f, 0x05}},
		{"leave", "leave", []byte{0xc9}},

		{"multi statements", "nop;ret;leave;", []byte{0x90, 0xc3, 0xc9}},

		{"callq myfunc", "callq myfunc", []byte{0xe8, 0, 0, 0, 0}},

		{"movb", "movb %al, 0(%rsi)", []byte{0x88, 0x06}},
		{"movw", "movw %ax,0(%rsi)", []byte{0x66, 0x89, 0x06}},
		{"movl", "movl $3, %eax", []byte{0xb8, 0x03, 0, 0, 0}},
		{"movq 64", "movq $3, %rax", []byte{0x48, 0xc7, 0xc0, 0x03, 0x00, 0x00, 0x00}},

		{"sete", "sete %rcx", []byte{0x0f, 0x94, 0b11001000}},
		{"pushq REGI", "pushq %rcx", []byte{0x51}},
		{"pushq IMM8", "pushq $3", []byte{0x6a, 0x03}},
		{"pushq IMM16", "pushq $4096", []byte{0x68, 0, 0x10, 0, 0}},
		{"popq", "popq %rcx", []byte{0x59}},
		{"xorq regi", "xorq %rax, %rcx", []byte{0x48, 0x31, 0xc1}},
		{"xorq imm", "xorq $1, %rax", []byte{0x48, 0x83, 0xf0, 0x01}},
		{"andq regi", "andq %rax, %rcx", []byte{0x48, 0x21, 0xc1}},
		{"orq regi", "orq %rax, %rcx", []byte{0x48, 0x09, 0xc1}},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			encoded, data := EncodeString(tt.source)
			_ = data
			if !reflect.DeepEqual(encoded, tt.encoded) {
				t.Errorf("EncodeString() got = %v, want %v", encoded, tt.encoded)
			}
		})
	}
}
