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
		{"ret", "ret", []byte{0xc3}},
		{"nop", "nop", []byte{0x90}},
		{"syscall", "syscall", []byte{0x0f, 0x05}},
		{"leave", "leave", []byte{0xc9}},
		{"movq 64", "movq $1, %rax", []byte{0x48, 0xc7, 0xc0, 0x01, 0x00, 0x00, 0x00}},
		{"callq myfunc", "callq myfunc", []byte{0xe8, 0, 0, 0, 0}},
		{"orq", "orq %rax, %rcx", []byte{0x48, 0x09, 0xc1}},
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
