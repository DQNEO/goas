package main

import (
	"io"
	"unsafe"
)

// ELF format
type ElfFile struct {
	header         *Elf64_Ehdr
	sectionBodies  []*ElfSectionBodies
	zeroPadding    []uint8
	sectionHeaders []*Elf64_Shdr
}

// Part1: ELF Header

//  #define EI_NIDENT (16)
const EI_NIDENT = 16

//  typedef struct
//  {
//  	unsigned char	e_ident[EI_NIDENT];
//  	Elf64_Half	e_type;
//  	Elf64_Half	e_machine;
//  	Elf64_Word	e_version;
//  	Elf64_Addr	e_entry;
//  	Elf64_Off	e_phoff;
//  	Elf64_Off	e_shoff;
//  	Elf64_Word	e_flags;
//  	Elf64_Half	e_ehsize;
//  	Elf64_Half	e_phentsize;
//  	Elf64_Half	e_phnum;
//  	Elf64_Half	e_shentsize;
//  	Elf64_Half	e_shnum;
//  	Elf64_Half	e_shstrndx;
//  } Elf64_Ehdr;
//
type Elf64_Ehdr struct {
	e_ident     [EI_NIDENT]uint8  /* Magic number and other info */
	e_type      uint16		      /* Object file type */
	e_machine   uint16	          /* Architecture */
	e_version   uint32	          /* Object file version */
	e_entry     uintptr	          /* Entry point virtual address */
	e_phoff     uintptr	          /* Program header table file offset */
	e_shoff     uintptr	          /* Section header table file offset */
	e_flags     uint32	          /* Processor-specific flags */
	e_ehsize    uint16	          /* ELF header size in bytes */
	e_phentsize uint16	          /* Program header table entry size */
	e_phnum     uint16	          /* Program header table entry count */
	e_shentsize uint16	          /* Section header table entry size */
	e_shnum     uint16	          /* Section header table entry count */
	e_shstrndx  uint16	          /* Section header string table index */
}

// static data for ELF header.
// e_shoff, e_shnum, and e_shstrndx will be set later dynamically.
var elfHeader = &Elf64_Ehdr{
	e_ident: [EI_NIDENT]uint8{
		0x7f, 0x45, 0x4c, 0x46, // 0x7F followed by "ELF"(45 4c 46) in ASCII;
		0x02,                                     // EI_CLASS:2=64-bit
		0x01,                                     // EI_DATA:1=little endian
		0x01,                                     // EI_VERSION:1=the original and current version of ELF.
		0x00,                                     // EI_OSABI: 0=System V
		0x00,                                     // EI_ABIVERSION:
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, // EI_PAD: always zero.
	},
	e_type:      1,    // ET_REL
	e_machine:   0x3e, // AMD x86-64
	e_version:   1,
	e_entry:     0,
	e_phoff:     0,
	e_flags:     0,
	e_ehsize:    uint16(unsafe.Sizeof(Elf64_Ehdr{})), // 64
	e_phentsize: 0,
	e_phnum:     0,
	e_shentsize: uint16(unsafe.Sizeof(Elf64_Shdr{})), // 64
}

// Part2: Section Bodies
type ElfSectionBodies struct {
	zeros  []uint8
	bodies []uint8
}

// Relocation entries (Rel & Rela)
// Relocation is the process of connecting symbolic references with
// symbolic definitions.  Relocatable files must have information
// that describes how to modify their section contents, thus
// allowing executable and shared object files to hold the right
// information for a process's program image.  Relocation entries
// are these data.
//
// Relocation structures that need an addend:
//     typedef struct {
//               Elf64_Addr r_offset;
//               uint64_t   r_info;
//               int64_t    r_addend;
//           } Elf64_Rela;
//
type Elf64_Rela struct {
	//              This member gives the location at which to apply the
	//              relocation action.  For a relocatable file, the value is
	//              the byte offset from the beginning of the section to the
	//              storage unit affected by the relocation.  For an
	//              executable file or shared object, the value is the virtual
	//              address of the storage unit affected by the relocation.
	r_offset uintptr
	//              This member gives both the symbol table index with respect
	//              to which the relocation must be made and the type of
	//              relocation to apply.  Relocation types are processor-
	//              specific.  When the text refers to a relocation entry's
	//              relocation type or symbol table index, it means the result
	//              of applying ELF[32|64]_R_TYPE or ELF[32|64]_R_SYM,
	//              respectively, to the entry's r_info member.
	r_info   uint64
	//              This member specifies a constant addend used to compute
	//              the value to be stored into the relocatable field.
	r_addend int64
}

const R_X86_64_PC32 = 2
const R_X86_64_PLT32 = 4


//  An object file's symbol table holds information needed to locate
//       and relocate a program's symbolic definitions and references.  A
//       symbol table index is a subscript into this array.
//
//   typedef struct {
//               uint32_t      st_name;
//               unsigned char st_info;
//               unsigned char st_other;
//               uint16_t      st_shndx;
//               Elf64_Addr    st_value;
//               uint64_t      st_size;
//           } Elf64_Sym;
//
type Elf64_Sym struct {
	// This member holds an index into the object file's symbol
	//              string table, which holds character representations of the
	//              symbol names.  If the value is nonzero, it represents a
	//              string table index that gives the symbol name.  Otherwise,
	//              the symbol has no name.
	st_name uint32

	/* Legal values for ST_TYPE subfield of st_info (symbol type).  */
	// #define STT_NOTYPE      0               /* Symbol type is unspecified */
	// #define STT_OBJECT      1               /* Symbol is a data object */
	// #define STT_FUNC        2               /* Symbol is a code object */
	// #define STT_SECTION     3               /* Symbol associated with a section */
	// #define STT_FILE        4               /* Symbol's name is file name */
	// #define STT_COMMON      5               /* Symbol is a common data object */
	// #define STT_TLS         6               /* Symbol is thread-local data object*/
	// #define STT_NUM         7               /* Number of defined types.  */
	// #define STT_LOOS        10              /* Start of OS-specific */
	// #define STT_GNU_IFUNC   10              /* Symbol is indirect code object */
	// #define STT_HIOS        12              /* End of OS-specific */
	// #define STT_LOPROC      13              /* Start of processor-specific */
	// #define STT_HIPROC      15              /* End of processor-specific */
	st_info  uint8
	st_other uint8
	//  Every symbol table entry is "defined" in relation to some
	//  section.  This member holds the relevant section header
	//  table index.
	st_shndx uint16
	// This member gives the value of the associated symbol.
	st_value uintptr
	st_size  uint64
}

// Part3: Section Header Table



//   typedef struct {
//               uint32_t   sh_name;
//               uint32_t   sh_type;
//               uint64_t   sh_flags;
//               Elf64_Addr sh_addr;
//               Elf64_Off  sh_offset;
//               uint64_t   sh_size;
//               uint32_t   sh_link;
//               uint32_t   sh_info;
//               uint64_t   sh_addralign;
//               uint64_t   sh_entsize;
//           } Elf64_Shdr;
//
type Elf64_Shdr struct {
	// This member specifies the name of the section.
	// Its value is an index into the section header string table section,
	// giving the location of a null-terminated string.
	sh_name   uint32
	sh_type   SHT
	sh_flags  uintptr
	sh_addr   uintptr
	sh_offset uintptr
	sh_size   uintptr

	// This member holds a section header table index link,
	// whose interpretation depends on the section type.
	sh_link uint32
	sh_info uint32

	// Some sections have address alignment constraints.  If a
	// section holds a doubleword, the system must ensure
	// doubleword alignment for the entire section.  That is, the
	// value of sh_addr must be congruent to zero, modulo the
	// value of sh_addralign.  Only zero and positive integral
	// powers of two are allowed.  The value 0 or 1 means that
	// the section has no alignment constraints.
	sh_addralign uintptr
	sh_entsize   uintptr
}

type SHT uint32
const SHT_PROGBITS SHT = 1 /* Program data */
const SHT_SYMTAB SHT = 2   /* Symbol table */
const SHT_STRTAB SHT = 3   /* String table */
const SHT_RELA SHT = 4     /* Relocation entries with addends */
const SHT_NOBITS SHT = 8   /* Program space with no data (bss) */

func (elfFile *ElfFile) writeTo(w io.Writer) {
	// Part 1: Write ELF Header
	h := elfFile.header
	buf := ((*[unsafe.Sizeof(Elf64_Ehdr{})]uint8)(unsafe.Pointer(h)))[:]
	w.Write(buf)

	// Part 2: Write section bodies
	for _, s := range elfFile.sectionBodies {
		w.Write(s.zeros)
		w.Write(s.bodies)
	}

	w.Write(elfFile.zeroPadding)

	// Part 3: Write section headers
	for _, sh := range elfFile.sectionHeaders {
		buf := ((*[unsafe.Sizeof(Elf64_Shdr{})]uint8)(unsafe.Pointer(sh)))[:]
		w.Write(buf)
	}
}
