package main

import (
	"bytes"
	"flag"
	"fmt"
	"os"
	"strings"
	"unsafe"
)

var oFlag = flag.String("o", "a.out", "output file")

var debug = flag.Bool("d", false, "show debug message")

func debugf(s string, a ...interface{}) {
	if !*debug {
		return
	}
	fmt.Fprintf(os.Stderr, s, a...)
}

func sortSectionsForBody(hasRelaText, hasRelaData, hasSymbols bool) []*section {
	var ss sections = make([]*section, 0, 8)
	ss.add(s_text)
	ss.add(s_data)
	ss.add(s_bss)

	if hasSymbols {
		ss.add(s_symtab)
		ss.add(s_strtab)
	}

	if hasRelaText {
		ss.add(s_rela_text)
	}

	if hasRelaData {
		ss.add(s_rela_data)
	}

	ss.add(s_shstrtab)
	return ss
}

type sections []*section

func (ss *sections) add(s *section) {
	*ss = append(*ss, s)
}

type section struct {
	name       string
	index      uint16
	header     *Elf64_Shdr
	numZeroPad uintptr
	zeros      []uint8
	contents   []uint8
}

func buildSectionHeaders(hasRelaText, hasRelaData, hasSymbols bool) []*section {
	var ss sections = make([]*section, 0, 8)
	ss.add(&section{header: &Elf64_Shdr{}}) // NULL section
	ss.add(s_text)
	if hasRelaText {
		ss.add(s_rela_text)
	}

	ss.add(s_data)

	if hasRelaData {
		ss.add(s_rela_data)
	}
	ss.add(s_bss)

	if hasSymbols {
		ss.add(s_symtab)
		ss.add(s_strtab)
	}
	ss.add(s_shstrtab)

	for i, s := range ss {
		s.index = uint16(i)
	}

	return ss
}

var s_text = &section{
	name: ".text",
	header: &Elf64_Shdr{
		sh_type:      SHT_PROGBITS,
		sh_flags:     0x06, // SHF_ALLOC|SHF_EXECINSTR
		sh_addr:      0,
		sh_link:      0,
		sh_info:      0,
		sh_addralign: 0x01,
		sh_entsize:   0,
	},
}

var s_rela_text = &section{
	name: ".rela.text",
	header: &Elf64_Shdr{
		sh_type:      SHT_RELA,
		sh_flags:     0x40, // * ??
		sh_link:      0x00, // The section header index of the associated symbol table
		sh_info:      0x01,
		sh_addralign: 0x08,
		sh_entsize:   0x18,
	},
}

var s_rela_data = &section{
	name: ".rela.data",
	header: &Elf64_Shdr{
		sh_type:      SHT_RELA,
		sh_flags:     0x40, // I ??
		sh_info:      0x02, // section idx of .data
		sh_addralign: 0x08,
		sh_entsize:   0x18,
	},
}

var s_data = &section{
	name: ".data",
	header: &Elf64_Shdr{
		sh_type:      SHT_PROGBITS,
		sh_flags:     0x03, // SHF_WRITE|SHF_ALLOC
		sh_addr:      0,
		sh_link:      0,
		sh_info:      0,
		sh_addralign: 0x01,
		sh_entsize:   0,
	},
}

var s_bss = &section{
	name: ".bss",
	header: &Elf64_Shdr{
		sh_type:      SHT_NOBITS,
		sh_flags:     0x03, // SHF_WRITE|SHF_ALLOC
		sh_addr:      0,
		sh_link:      0,
		sh_info:      0,
		sh_addralign: 0x01,
		sh_entsize:   0,
	},
}

// ".symtab"
// SHT_SYMTAB (symbol table)
var s_symtab = &section{
	name: ".symtab",
	header: &Elf64_Shdr{
		sh_type:  SHT_SYMTAB, // SHT_SYMTAB
		sh_flags: 0,
		sh_addr:  0,
		//	sh_link:      0x05, // section index of .strtab ?
		sh_addralign: 0x08,
		sh_entsize:   0x18,
	},
}

var s_shstrtab = &section{
	name: ".shstrtab",
	header: &Elf64_Shdr{
		sh_type:      SHT_STRTAB,
		sh_flags:     0,
		sh_addr:      0,
		sh_link:      0,
		sh_info:      0,
		sh_addralign: 0x01,
		sh_entsize:   0,
	},
}

// ".strtab"
//
// This section holds strings, most commonly the strings that
//
//	represent the names associated with symbol table entries.
//	If the file has a loadable segment that includes the
//	symbol string table, the section's attributes will include
//	the SHF_ALLOC bit.  Otherwise, the bit will be off.
//
// This section is of type SHT_STRTAB.
var s_strtab = &section{
	name: ".strtab",
	header: &Elf64_Shdr{
		sh_type:      SHT_STRTAB,
		sh_flags:     0,
		sh_addr:      0,
		sh_link:      0,
		sh_info:      0,
		sh_addralign: 0x01,
		sh_entsize:   0,
	},
}

func calcOffsetOfSection(s *section, prev *section) {
	tentative_offset := prev.header.sh_offset + prev.header.sh_size
	var align = s.header.sh_addralign
	if align == 0 || align == 1 {
		s.numZeroPad = 0
	} else {
		mod := tentative_offset % align
		if mod == 0 {
			s.numZeroPad = 0
		} else {
			s.numZeroPad = align - mod
		}
	}
	s.header.sh_offset = tentative_offset + s.numZeroPad
	s.header.sh_size = uintptr(len(s.contents))
}

func makeStrTab(symbols []string) []byte {
	var nameOffset uint32
	var data []byte = []byte{0x00}
	nameOffset++
	for _, sym := range symbols {
		//sym.nameOffset = nameOffset
		buf := append([]byte(sym), 0x00)
		data = append(data, buf...)
		nameOffset += uint32(len(buf))
	}

	return data
}

func makeSectionNames(hasRelaText, hasRelaData, hasSymbols bool) []string {
	var r []string

	if hasSymbols {
		r = append(r, ".symtab", ".strtab")
	}

	var dataName string
	var textName string

	if hasRelaData {
		dataName = ".rela.data"
	} else {
		dataName = ".data"
	}

	if hasRelaText {
		textName = ".rela.text"
	} else {
		textName = ".text"
	}

	r = append(r, ".shstrtab", textName, dataName, ".bss")
	return r
}

// Make contents of .shstrtab"
func makeShStrTab(sectionNames []string) []byte {
	buf := []byte{0x00}
	for _, name := range sectionNames {
		buf = append(buf, name...)
		buf = append(buf, 0)
	}
	return buf
}

func resolveShNames(shstrtab_contents []byte, ss []*section) {
	for _, s := range ss {
		idx := bytes.Index(shstrtab_contents, []byte(s.name))
		if idx <= 0 {
			panic(s.name + " is not found in .strtab contents")
		}
		s.header.sh_name = uint32(idx)
	}
}

type symbolDefinition struct {
	name    string
	section string
	address uintptr
	instr   *Instruction
}

var definedSymbols = make(map[string]*symbolDefinition)

const STT_SECTION = 0x03

func isDataSymbolUsed(definedSymbols map[string]*symbolDefinition, relaTextUsers []*relaTextUser, relaDataUsers []*relaDataUser) bool {
	for _, rel := range relaTextUsers {
		symdef, ok := definedSymbols[rel.uses]
		if ok {
			if symdef.section == ".data" {
				return true
			}
		}
	}

	for _, rel := range relaDataUsers {
		symdef, ok := definedSymbols[rel.uses]
		if ok {
			if symdef.section == ".data" {
				return true
			}
		}
	}
	return false
}

func buildSymbolTable(addData bool, globalSymbols map[string]bool, symbolsInLexicalOrder []string) (uint32, []uint8, map[string]int) {
	var symbolIndex = make(map[string]int)

	var symbolTable = []*Elf64_Sym{
		&Elf64_Sym{}, // NULL entry
	}

	if addData {
		symbolIndex[".data"] = len(symbolTable)
		symbolTable = append(symbolTable, &Elf64_Sym{
			st_name:  0,
			st_info:  STT_SECTION,
			st_other: 0,
			st_shndx: uint16(s_data.index),
			st_value: 0,
			st_size:  0,
		})
	}

	var localSymbols []string
	var globalDefinedSymbols []string
	var globalUndefinedSymbols []string
	for _, sym := range symbolsInLexicalOrder {
		if strings.HasPrefix(sym, ".L") {
			// https://sourceware.org/binutils/docs-2.37/as.html#Symbol-Names
			// Local Symbol Names
			// A local symbol is any symbol beginning with certain local label prefixes. By default, the local label prefix is ‘.L’ for ELF systems or ‘L’ for traditional a.out systems, but each target may have its own set of local label prefixes. On the HPPA local symbols begin with ‘L$’.
			//
			// Local symbols are defined and used within the assembler, but they are normally not saved in object files. Thus, they are not visible when debugging. You may use the ‘-L’ option (see Include Local Symbols) to retain the local symbols in the object files.
			continue
		}
		isGlobal := globalSymbols[sym]
		_, isDefined := definedSymbols[sym]
		if !isDefined {
			isGlobal = true
		}

		if !isGlobal {
			localSymbols = append(localSymbols, sym)
		} else {
			if isDefined {
				globalDefinedSymbols = append(globalDefinedSymbols, sym)
			} else {
				globalUndefinedSymbols = append(globalUndefinedSymbols, sym)
			}
		}
	}

	// local => global defined => global undefined
	allSymbolsForElf := append(localSymbols, globalDefinedSymbols...)
	allSymbolsForElf = append(allSymbolsForElf, globalUndefinedSymbols...)

	s_strtab.contents = makeStrTab(allSymbolsForElf)

	// https://reviews.llvm.org/D28950
	// The sh_info field of the SHT_SYMTAB section holds the index for the first non-local symbol.
	var indexOfFirstNonLocalSymbol int

	for _, symname := range allSymbolsForElf {
		isGlobal := globalSymbols[symname]
		sym, isDefined := definedSymbols[symname]
		var addr uintptr
		var shndx uint16
		if isDefined {
			switch sym.section {
			case ".text":
				shndx = s_text.index
				addr = sym.instr.addr
			case ".data":
				shndx = s_data.index
				addr = sym.address
			default:
				panic("TBI")
			}
		} else {
			isGlobal = true
		}

		name_offset := bytes.Index(s_strtab.contents, append([]byte(symname), 0x0))
		if name_offset < 0 {
			panic("name_offset should not be negative")
		}
		var st_info uint8
		if isGlobal {
			st_info = 0x10 // GLOBAL ?
		}
		e := &Elf64_Sym{
			st_name:  uint32(name_offset),
			st_info:  st_info,
			st_other: 0,
			st_shndx: shndx,
			st_value: addr,
		}
		index := len(symbolTable)
		symbolTable = append(symbolTable, e)

		symbolIndex[symname] = index
		if isGlobal {
			if indexOfFirstNonLocalSymbol == 0 {
				indexOfFirstNonLocalSymbol = index
			}
		}
	}

	var sh_info uint32
	// I don't know why we need this. Just Follow GNU.
	if indexOfFirstNonLocalSymbol == 0 {
		sh_info = uint32(len(symbolTable))
	} else {
		sh_info = uint32(indexOfFirstNonLocalSymbol)
	}

	var contents []uint8
	for _, entry := range symbolTable {
		buf := ((*[unsafe.Sizeof(Elf64_Sym{})]byte)(unsafe.Pointer(entry)))[:]
		contents = append(contents, buf...)
	}

	return sh_info, contents, symbolIndex
}

type relaDataUser struct {
	addr uintptr
	uses string
}

var relaDataUsers []*relaDataUser

type relaTextUser struct {
	instr  *Instruction
	offset uintptr
	toJump bool
	uses   string
	adjust int64
}

var relaTextUsers []*relaTextUser

func assert(bol bool, errorMsg string) {
	if !bol {
		panic("assert failed: " + errorMsg)
	}
}

var first *Instruction

func resolveVariableLengthInstrs(instrs []*Instruction) []*Instruction {
	var todos []*Instruction
	for _, vr := range instrs {
		sym, ok := definedSymbols[vr.varcode.trgtSymbol]
		if !ok {
			continue
		}
		diff, min, max, isLenDecided := calcDistance(vr, sym)
		if isLenDecided {
			if isInInt8Range(diff) {
				// rel8
				vr.code = vr.varcode.rel8Code
				vr.code[vr.varcode.rel8Offset] = uint8(diff)
			} else {
				// rel32
				diffInt32 := int32(diff)
				var buf *[4]byte = (*[4]byte)(unsafe.Pointer(&diffInt32))
				code, offset := vr.varcode.rel32Code, vr.varcode.rel32Offset
				code[offset] = buf[0]
				code[offset+1] = buf[1]
				code[offset+2] = buf[2]
				code[offset+3] = buf[3]
				vr.code = code
			}
			vr.isLenDecided = true
		} else {
			if isInInt8Range(max) {
				vr.isLenDecided = true
				vr.varcode.rel32Code = nil
				vr.code = vr.varcode.rel8Code
			} else if !isInInt8Range(min) {
				vr.isLenDecided = true
				vr.varcode.rel8Code = nil
				vr.code = vr.varcode.rel32Code
			}
			todos = append(todos, vr)
		}
	}

	return todos
}

func encodeAllText(ss []*Stmt) []byte {
	var insts []*Instruction
	var index int
	var prev *Instruction
	for _, s := range ss {
		if s.labelSymbol == "" && s.keySymbol == "" {
			continue
		}
		instr := encode(s)
		if s.labelSymbol != "" {
			definedSymbols[s.labelSymbol].instr = instr
		}
		insts = append(insts, instr)
		instr.index = index
		index++
		if first == nil {
			first = instr
		} else {
			prev.next = instr
		}
		prev = instr
	}

	// Optimize instructions length
	for len(variableInstrs) > 0 {
		variableInstrs = resolveVariableLengthInstrs(variableInstrs)
	}

	var allText []byte
	var textAddr uintptr
	for instr := first; instr != nil; instr = instr.next {
		instr.addr = textAddr
		allText = append(allText, instr.code...)
		textAddr += uintptr(len(instr.code))
	}

	// Resolve call targets
	for _, call := range callTargets {
		callee, ok := definedSymbols[call.trgtSymbol]
		if !ok {
			continue
		}
		diff := callee.instr.addr - call.caller.next.addr
		placeToEmbed := call.caller.addr + call.offset
		diffInt32 := int32(diff)
		var buf *[4]byte = (*[4]byte)(unsafe.Pointer(&diffInt32))
		allText[placeToEmbed] = buf[0]
		allText[placeToEmbed+1] = buf[1]
		allText[placeToEmbed+2] = buf[2]
		allText[placeToEmbed+3] = buf[3]
	}
	return allText
}

func encodeAllData(ss []*Stmt) []byte {
	var dataAddr uintptr
	var allData []byte
	for _, s := range ss {
		buf := encodeData(s, dataAddr)
		dataAddr += uintptr(len(buf))
		allData = append(allData, buf...)
	}
	return allData
}

func main() {
	flag.Parse()

	var inFiles []string

	if flag.NArg() > 0 {
		inFiles = flag.Args()
	} else {
		inFiles = []string{"/dev/stdin"}
	}
	debugf("[main] input files are: %s\n", inFiles)
	outputFile := *oFlag
	debugf("[main] output file is: %s\n", outputFile)
	w, err := os.Create(outputFile)
	if err != nil {
		panic(err)
	}

	stmts, symbolsInLexicalOrder := ParseFiles(inFiles)

	var textStmts []*Stmt
	var dataStmts []*Stmt

	var globalSymbols = make(map[string]bool)
	var currentSection = ".text"
	for _, s := range stmts {

		if s.labelSymbol != "" {
			definedSymbols[s.labelSymbol] = &symbolDefinition{
				name:    s.labelSymbol,
				section: currentSection,
			}
		}

		switch s.keySymbol {
		case ".data":
			currentSection = ".data"
			continue
		case ".text":
			currentSection = ".text"
			continue
		case ".global":
			globalSymbols[s.operands[0].(*symbolExpr).name] = true
			continue
		}

		switch currentSection {
		case ".data":
			dataStmts = append(dataStmts, s)
		case ".text":
			textStmts = append(textStmts, s)
		}
	}

	s_text.contents = encodeAllText(textStmts)
	s_data.contents = encodeAllData(dataStmts)

	hasRelaText := len(relaTextUsers) > 0
	hasRelaData := len(relaDataUsers) > 0
	hasSymbols := len(definedSymbols) > 0

	sectionHeaders := buildSectionHeaders(hasRelaText, hasRelaData, hasSymbols)

	if hasSymbols {
		s_symtab.header.sh_link = uint32(s_strtab.index) // @TODO confirm the reason to do this

		if hasRelaText {
			s_rela_text.header.sh_link = uint32(s_symtab.index)
		}

		if hasRelaData {
			s_rela_data.header.sh_link = uint32(s_symtab.index)
			s_rela_data.header.sh_info = uint32(s_data.index)
		}
	}

	var symbolIndex map[string]int

	if len(definedSymbols) > 0 {
		dataSymbolUsed := isDataSymbolUsed(definedSymbols, relaTextUsers, relaDataUsers)
		s_symtab.header.sh_info, s_symtab.contents, symbolIndex = buildSymbolTable(dataSymbolUsed, globalSymbols, symbolsInLexicalOrder)
	}

	debugf("[main] building sections ...\n")
	sectionNames := makeSectionNames(hasRelaText, hasRelaData, hasSymbols)
	s_shstrtab.contents = makeShStrTab(sectionNames)
	resolveShNames(s_shstrtab.contents, sectionHeaders[1:])

	s_rela_text.contents = buildRelaTextBody(relaTextUsers, symbolIndex)
	s_rela_data.contents = buildRelaDataBody(relaDataUsers)

	sectionInBodyOrder := sortSectionsForBody(hasRelaText, hasRelaData, hasSymbols)
	assert(len(sectionInBodyOrder) == len(sectionHeaders)-1, "sections len unmatch")
	debugf("[main] writing ELF file ...\n")
	elfFile := prepareElfFile(sectionInBodyOrder, sectionHeaders)
	elfFile.writeTo(w)
}

func buildRelaTextBody(relaTextUsers []*relaTextUser, symbolIndex map[string]int) []byte {
	var contents []byte

	for _, ru := range relaTextUsers {
		sym, defined := definedSymbols[ru.uses]
		var addr int64
		if defined {
			// skip symbols that belong to the same section
			if sym.section == ".text" {
				continue
			}
			addr = int64(sym.address)
		}

		var typ uint64
		if ru.toJump {
			typ = R_X86_64_PLT32
		} else {
			typ = R_X86_64_PC32
		}

		var symIdx int
		if defined && sym.section == ".data" {
			symIdx = symbolIndex[".data"]
		} else {
			symIdx = symbolIndex[ru.uses]
		}

		rela := &Elf64_Rela{
			r_offset: ru.instr.addr + ru.offset,
			r_info:   uint64(symIdx)<<32 + typ,
			r_addend: addr + ru.adjust - 4,
		}
		p := (*[unsafe.Sizeof(Elf64_Rela{})]byte)(unsafe.Pointer(rela))[:]
		contents = append(contents, p...)
	}
	return contents
}

func buildRelaDataBody(relaDataUsers []*relaDataUser) []byte {
	var contents []byte
	for _, ru := range relaDataUsers {
		sym, ok := definedSymbols[ru.uses]
		if !ok {
			panic("label not found")
		}

		var addr uintptr
		if sym.section == ".text" {
			addr = sym.instr.addr
		} else {
			addr = sym.address
		}

		rela := &Elf64_Rela{
			r_offset: ru.addr,
			r_info:   0x0100000001,
			r_addend: int64(addr),
		}
		p := (*[unsafe.Sizeof(Elf64_Rela{})]byte)(unsafe.Pointer(rela))[:]
		contents = append(contents, p...)
	}
	return contents
}

func determineSectionOffsets(sectionBodies []*section) {
	firstSection := sectionBodies[0]
	firstSection.header.sh_offset = unsafe.Sizeof(Elf64_Ehdr{})
	firstSection.header.sh_size = uintptr(len(firstSection.contents))
	for i := 1; i < len(sectionBodies); i++ {
		calcOffsetOfSection(
			sectionBodies[i], sectionBodies[i-1])
	}
}

func calcEShoff(last *Elf64_Shdr) (uintptr, uintptr) {

	endOfLastSection := last.sh_offset + last.sh_size

	var paddingBeforeSHT uintptr
	// align shoff so that e_shoff % 8 be zero. (This is not required actually. Just following gcc's practice)
	mod := endOfLastSection % 8
	if mod != 0 {
		paddingBeforeSHT = 8 - mod
	}
	eshoff := endOfLastSection + paddingBeforeSHT
	return paddingBeforeSHT, eshoff
}

func prepareElfFile(sectionBodies []*section, sectionHeaders []*section) *ElfFile {

	// Calculates offset and zero padding
	determineSectionOffsets(sectionBodies)

	lastSectionHeader := sectionHeaders[len(sectionHeaders)-1].header
	paddingBeforeSHT, eshoff := calcEShoff(lastSectionHeader)

	elfHeader.e_shoff = eshoff
	elfHeader.e_shnum = uint16(len(sectionHeaders))
	elfHeader.e_shstrndx = s_shstrtab.index

	// adjust zero padding before each section
	var sbs []*ElfSectionBodies
	for _, sect := range sectionBodies {
		// Some sections may not have any contents
		if sect.contents != nil {
			sc := &ElfSectionBodies{
				bodies: sect.contents,
			}
			if sect.numZeroPad > 0 {
				// pad zeros when required
				sc.zeros = make([]uint8, sect.numZeroPad)
			}
			sbs = append(sbs, sc)
		}
	}

	var sht []*Elf64_Shdr
	for _, s := range sectionHeaders {
		sht = append(sht, s.header)
	}

	return &ElfFile{
		header:         elfHeader,
		sectionBodies:  sbs,
		zeroPadding:    make([]uint8, paddingBeforeSHT),
		sectionHeaders: sht,
	}
}
