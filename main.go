package main

import "os"

// ELF format
// see https://en.wikipedia.org/wiki/Executable_and_Linkable_Format#File_layout
// see https://man7.org/linux/man-pages/man5/elf.5.html

// The ELF header
var magickNumber = []byte{
	// 0x7F followed by ELF(45 4c 46) in ASCII;
	0x7f,0x45,0x4c,0x46,
}

var EI_CLASS = []byte{0x02} //  1 or 2 to signify 32- or 64-bit format, respectively.

var EI_DATA = []byte{0x01} // 1 or 2 to signify little or big endianness, respectively.
var EI_VERSION = []byte{0x01} // 1 for the original and current version of ELF.

var OtherELFHeader []byte = []byte{
	0x00,                                     // EI_OSABI
	0x00,                                     // EI_ABIVERSION
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, // EI_PAD always zero.
	0x01, 0x00, // e_type = ET_REL
	0x3e, 0x00, // e_machine = AMD x86-64

	0x01, 0x00, 0x00, 0x00, // e_version = 1
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, // e_entry: null
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, // e_phoff: null
	0xf8, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, // e_shoff: Points to the start of the section header table. f8=248
	0x00, 0x00, 0x00, 0x00, // e_flags
	0x40, 0x00, // e_ehsize: Contains the size of this header, normally 64 Bytes for 64-bit
	0x00, 0x00, // e_phentsize: null
	0x00, 0x00, // e_phnum: null
	0x40, 0x00, // e_shentsize: Contains the size of a section header table entry.
	0x07, 0x00, // e_shnum: Contains the number of entries in the section header table.
	0x06, 0x00, // e_shstrndx: Contains index of the section header table entry that contains the section names.
}

var elfHeader [][]byte = [][]byte{
	magickNumber,
	EI_CLASS,
	EI_DATA,
	EI_VERSION,
	OtherELFHeader,
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
	var sections [][]byte
	sections = append(sections, elfHeader...)
	sections = append(sections, body...)
	sections = append(sections, sectionHeaderTable...)

	write(sections)
}

func write(sections [][]byte) {
	for _, buf := range sections {
		os.Stdout.Write(buf)
	}
}
