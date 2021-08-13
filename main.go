package main

import (
	"os"
	"unsafe"
)

// ELF format
// see https://en.wikipedia.org/wiki/Executable_and_Linkable_Format#File_layout
// see https://man7.org/linux/man-pages/man5/elf.5.html
// see https://sourceware.org/git/?p=glibc.git;a=blob;f=elf/elf.h;h=4738dfa28f6549fc11654996a15659dc8007e686;hb=HEAD

// copied from libc's elf/elf.h
//#define EI_NIDENT (16)
//
//typedef struct
//{
//	unsigned char	e_ident[EI_NIDENT];	/* Magic number and other info */
//	Elf64_Half	e_type;			/* Object file type */
//	Elf64_Half	e_machine;		/* Architecture */
//	Elf64_Word	e_version;		/* Object file version */
//	Elf64_Addr	e_entry;		/* Entry point virtual address */
//	Elf64_Off	e_phoff;		/* Program header table file offset */
//	Elf64_Off	e_shoff;		/* Section header table file offset */
//	Elf64_Word	e_flags;		/* Processor-specific flags */
//	Elf64_Half	e_ehsize;		/* ELF header size in bytes */
//	Elf64_Half	e_phentsize;		/* Program header table entry size */
//	Elf64_Half	e_phnum;		/* Program header table entry count */
//	Elf64_Half	e_shentsize;		/* Section header table entry size */
//	Elf64_Half	e_shnum;		/* Section header table entry count */
//	Elf64_Half	e_shstrndx;		/* Section header string table index */
//} Elf64_Ehdr;

type Elf64_Ehdr struct {
	e_ident [16]uint8
	e_type uint16
	e_machine uint16 // 20
	e_version uint32 // 24
	e_entry uintptr // 32
	e_phoff uintptr // 40
	e_shoff uintptr // 48
	e_flags uint32 // 52
	e_ehsize uint16
	e_phentsize uint16
	e_phnum uint16
	e_shentsize uint16
	e_shnum uint16
	e_shstrndx uint16 // 64
}

var _eh Elf64_Ehdr
var elfHeader = Elf64_Ehdr{
	e_ident: [16]uint8{
		0x7f, 0x45, 0x4c, 0x46, // 0x7F followed by "ELF"(45 4c 46) in ASCII;
		0x02,                                     // EI_CLASS:2=64-bit
		0x01,                                     // EI_DATA:1=little endian
		0x01,                                     // EI_VERSION:1=the original and current version of ELF.
		0x00,                                     // EI_OSABI: 0=System V
		0x00,                                     // EI_ABIVERSION:
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, // EI_PAD: always zero.
	},
	e_type: 1, // ET_REL
	e_machine: 0x3e, // AMD x86-64
	e_version: 1,
	e_entry:0,
	e_phoff: 0,
	//e_shoff: 0, // calculated at runtime
	e_flags:0,
	e_ehsize: uint16(unsafe.Sizeof(_eh)),
	e_phentsize:0,
	e_phnum:0,
	e_shentsize:0x40,
	// e_shnum: 0, // calculated at runtime
	// e_shstrndx: 0, // calculated at runtime
}

var text []byte = []byte{
	// .text section
	// offset: 0x40
	0x48, 0xc7, 0xc0, 0x2a, 0x00, 0x00, 0x00, // movq    $42, %rax
	0xc3, // retq

}

var symtab = []byte{
	//  SHT_SYMTAB (symbol table)
	// offset: 0x48 size:0x78
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x03, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x03, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x03, 0x00, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x01, 0x00, 0x00, 0x00, 0x10, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
}

var strtab1 = []byte{
	// SHT_STRTAB
	// offset: 0xc0 size: 0x06
	0x00,
	0x6d, 0x61, 0x69, 0x6e, // main
	0x00,
}

var strtabSectionNames = []byte{
	// SHT_STRTAB (e_shstrndx =  the section names)
	0x00, 0x2e, 0x73, 0x79, 0x6d, 0x74, 0x61, 0x62, // .symtab
	0x00, 0x2e, 0x73, 0x74, 0x72, 0x74, 0x61, 0x62, // .strtab
	0x00, 0x2e, 0x73, 0x68, 0x73, 0x74, 0x72, 0x74, 0x61, 0x62, //.shstrtab
	0x00, 0x2e, 0x74, 0x65, 0x78, 0x74, // .text
	0x00, 0x2e, 0x64, 0x61, 0x74, 0x61, // .data
	0x00, 0x2e, 0x62, 0x73, 0x73, // .bss
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
}

var ht0 = []byte{
	// # Section header table (64 * 7)
	// ## section SHT_NULL
	0x00, 0x00, 0x00, 0x00, // sh_name: An offset to a string in the .shstrtab section that represents the name of this section.
	0x00, 0x00, 0x00, 0x00, // sh_type: Identifies the type of this header.
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, // sh_flags: Identifies the attributes of the section.
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, // sh_addr: Virtual address of the section in memory, for sections that are loaded.
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, // sh_offset: Offset of the section in the file image.
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, // sh_size: Size in bytes of the section in the file image. May be 0.
	0x00, 0x00, 0x00, 0x00, // sh_link: Contains the section index of an associated section. This field is used for several purposes, depending on the type of section.
	0x00, 0x00, 0x00, 0x00, // sh_info: Contains extra information about the section. This field is used for several purposes, depending on the type of section.
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // sh_addralign: Contains the required alignment of the section. This field must be a power of two.
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, // sh_entsize:Contains the size, in bytes, of each entry, for sections that contain fixed-size entries. Otherwise, this field contains zero.
}
var ht1 = []byte{
	// ## section
	0x1b,0x00,0x00,0x00, // sh_name
	0x01,0x00,0x00,0x00, // sh_type: SHT_PROGBITS
	0x06,0x00,0x00,0x00,0x00,0x00,0x00,0x00, // sh_flags:  SHF_ALLOC|SHF_EXECINSTR
	0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00, // sh_addr
	0x40,0x00,0x00,0x00,0x00,0x00,0x00,0x00, // sh_offset
	0x08,0x00,0x00,0x00,0x00,0x00,0x00,0x00, // sh_size
	0x00,0x00,0x00,0x00, // sh_link
	0x00,0x00,0x00,0x00, // sh_info
	0x01,0x00,0x00,0x00,0x00,0x00,0x00,0x00, // sh_addralign
	0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00, // sh_entsize
}
var ht2 = []byte{
	// ## section
	0x21,0x00,0x00,0x00, // sh_name
	0x01,0x00,0x00,0x00, // sh_type: SHT_PROGBITS
	0x03,0x00,0x00,0x00,0x00,0x00,0x00,0x00, // sh_flags: SHF_WRITE|SHF_ALLOC
	0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00, // sh_addr
	0x48,0x00,0x00,0x00,0x00,0x00,0x00,0x00, // sh_offset
	0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00, // sh_size
	0x00,0x00,0x00,0x00, // sh_link
	0x00,0x00,0x00,0x00, // sh_info
	0x01,0x00,0x00,0x00,0x00,0x00,0x00,0x00, // sh_addralign
	0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00, // sh_entsize
}
var ht3 = []byte{
	// ## section
	0x27,0x00,0x00,0x00, // sh_name
	0x08,0x00,0x00,0x00, // sh_type:  SHT_NOBITS (bss)
	0x03,0x00,0x00,0x00,0x00,0x00,0x00,0x00, // sh_flags: SHF_WRITE|SHF_ALLOC
	0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00, // sh_addr
	0x48,0x00,0x00,0x00,0x00,0x00,0x00,0x00, // sh_offset
	0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00, // sh_size
	0x00,0x00,0x00,0x00, // sh_link
	0x00,0x00,0x00,0x00, // sh_info
	0x01,0x00,0x00,0x00,0x00,0x00,0x00,0x00, // sh_addralign
	0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00, // sh_entsize
}
var ht4 = []byte{
	// ## section
	0x01,0x00,0x00,0x00, // sh_name
	0x02,0x00,0x00,0x00, // sh_type:  SHT_SYMTAB
	0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00, // sh_flags:
	0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00, // sh_addr
	0x48,0x00,0x00,0x00,0x00,0x00,0x00,0x00, // sh_offset
	0x78,0x00,0x00,0x00,0x00,0x00,0x00,0x00, // sh_size
	0x05,0x00,0x00,0x00, // sh_link
	0x04,0x00,0x00,0x00, // sh_info
	0x08,0x00,0x00,0x00,0x00,0x00,0x00,0x00, // sh_addralign
	0x18,0x00,0x00,0x00,0x00,0x00,0x00,0x00, // sh_entsize
}
var ht5 = []byte{
	// ## section
	0x09,0x00,0x00,0x00, // sh_name
	0x03,0x00,0x00,0x00, // sh_type: SHT_STRTAB
	0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00, // sh_flags:
	0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00, // sh_addr
	0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x00, // sh_offset
	0x06,0x00,0x00,0x00,0x00,0x00,0x00,0x00, // sh_size
	0x00,0x00,0x00,0x00, // sh_link
	0x00,0x00,0x00,0x00, // sh_info
	0x01,0x00,0x00,0x00,0x00,0x00,0x00,0x00, // sh_addralign
	0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00, // sh_entsize
}
var ht6 = []byte{ //  this is what e_shstrndx points to
	// ## section
	0x11,0x00,0x00,0x00, // sh_name
	0x03,0x00,0x00,0x00, // sh_type:  SHT_STRTAB
	0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00, // sh_flags:
	0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00, // sh_addr
	0xc6,0x00,0x00,0x00,0x00,0x00,0x00,0x00, // sh_offset
	0x2c,0x00,0x00,0x00,0x00,0x00,0x00,0x00, // sh_size
	0x00,0x00,0x00,0x00, // sh_link
	0x00,0x00,0x00,0x00, // sh_info
	0x01,0x00,0x00,0x00,0x00,0x00,0x00,0x00, // sh_addralign
	0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00, // sh_entsize
}

var body [][]byte = [][]byte{
	text,
	symtab,
	strtab1,
	strtabSectionNames,
}
var sectionHeaderTable = [][]byte{
	ht0,ht1,ht2,ht3,ht4,ht5,ht6,
}

func main() {
	var shoff = 0xf8
	elfHeader.e_shoff = uintptr(shoff)
	elfHeader.e_shnum = uint16(len(sectionHeaderTable))
	elfHeader.e_shstrndx = elfHeader.e_shnum - 1

	var buf []byte = ((*[unsafe.Sizeof(elfHeader)]byte)(unsafe.Pointer(&elfHeader)))[:]
	os.Stdout.Write(buf)

	var sections [][]byte
	sections = append(sections, body...)
	sections = append(sections, sectionHeaderTable...)

	write(sections)
}

func write(sections [][]byte) {
	for _, buf := range sections {
		os.Stdout.Write(buf)
	}
}
