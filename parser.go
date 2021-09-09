package main

import (
	"fmt"
	"os"
	"strconv"
)

// parser's global vars
var symbolsInLexicalOrder []string
var symbolsAppeared = make(map[string]bool)

func collectAppearedSymbols(symbol string) {
	if !symbolsAppeared[symbol] {
		symbolsInLexicalOrder = append(symbolsInLexicalOrder, symbol)
		symbolsAppeared[symbol] = true
	}
}

// https://sourceware.org/binutils/docs-2.37/as.html#Symbol-Names
// Symbol names begin with a letter or with one of ‘._’.
// Symbol names do not start with a digit.
//  An exception to this rule is made for Local Labels.
func isSymbolBeginning(ch byte) bool {
	return ('a' <= ch && ch <= 'z') || ('A' <= ch && ch <= 'Z') || ch == '.' || ch == '_'
}

// On most machines, you can also use $ in symbol names.
func isSymbolLetter(ch byte) bool {
	return isSymbolBeginning(ch) || '0' <= ch && ch <= '9' || ch == '$'
}

func (p *parser) atEOF() bool {
	return p.idx >= len(p.source)
}

func (p *parser) peekChorEOF() (byte, bool) {
	if p.idx == len(p.source) {
		return 0, true
	}
	return p.source[p.idx], false
}

func (p *parser) peekCh() byte {
	if p.idx == len(p.source) {
		panic("Sudden EOF")
	}
	return p.source[p.idx]
}

// https://sourceware.org/binutils/docs-2.37/as.html#Whitespace
// Whitespace is one or more blanks or tabs, in any order.
// Whitespace is used to separate symbols, and to make programs neater for people to read.
// Unless within character constants (see Character Constants), any whitespace means the same as exactly one space.
func (p *parser) skipWhitespaces() {
	for p.idx < len(p.source) && p.source[p.idx] != '\n' {
		ch := p.source[p.idx]
		if ch == ' ' || ch == '\t' {
			p.idx++
			continue
		}
		return
	}
}

func (p *parser) skipToEOL() {
	for ; p.source[p.idx] != '\n'; p.idx++ {
	}
}

func (p *parser) readParenthRegister() *register {
	p.expect('(')
	if p.source[p.idx] == '%' {
		regi := p.readRegi()
		p.expect(')')
		return &register{name: regi}
	} else {
		p.parseFail("TBI")
		return nil
	}
}

func (p *parser) expect(ch byte) {
	if p.source[p.idx] != ch {
		panic(fmt.Sprintf("[parser] %c is expected, but got %c at line %d", ch, p.source[p.idx], p.lineno))
	}
	p.idx++
}

func isAlphabet(ch byte) bool {
	return ('a' <= ch && ch <= 'z') || ('A' <= ch && ch <= 'Z')
}

func (p *parser) readRegi() string {
	p.expect('%')
	var buf []byte
	for {
		ch := p.source[p.idx]
		if isAlphabet(ch) {
			p.idx++
			buf = append(buf, ch)
		} else {
			return string(buf)
		}
	}
}

func (p *parser) readSymbol(first byte) string {
	p.expect(first)
	var buf []byte = []byte{first}
	for {
		ch := p.source[p.idx]
		if isSymbolLetter(ch) {
			buf = append(buf, ch)
			p.idx++
		} else {
			sym := string(buf)
			return sym
		}
	}
}

func (p *parser) readStringLiteral() string {
	p.expect('"')
	var buf []byte
	for {
		ch := p.peekCh()
		switch ch {
		case '\\':
			p.expect('\\')
			ch := p.peekCh()
			var out byte
			switch ch {
			case 'n':
				out = '\n'
			case 'r':
				out = '\n'
			case 't':
				out = '\t'
			default:
				out = ch
			}
			p.idx++
			buf = append(buf, out)
			continue
		case '"':
			p.idx++
			return string(buf)
		default:
			p.idx++
			buf = append(buf, ch)
		}
	}
}

func evalNumExpr(expr expr) int {
	switch e := expr.(type) {
	case *numberLit:
		num, err := strconv.ParseInt(e.val, 0, 32)
		if err != nil {
			panic(err)
		}
		return int(num)
	case *charLit:
		return int(e.val)
	case *binaryExpr:
		switch e.op {
		case "*":
			return evalNumExpr(e.left) * evalNumExpr(e.right)
		case "+":
			return evalNumExpr(e.left) + evalNumExpr(e.right)
		case "-":
			return evalNumExpr(e.left) - evalNumExpr(e.right)
		default:
			panic("Unsupported binary operation: " + e.op)
		}
	}
	panic(fmt.Sprintf("unkonwn type %T", expr))
}

// binary or unary or primary expr
func (p *parser) parseArithExpr() expr {

	n := p.readNumberLitral()
	p.skipWhitespaces()
	ch := p.source[p.idx]
	switch ch {
	case '+', '-', '*', '/':
		p.idx++
		n2 := p.readNumberLitral()
		return &binaryExpr{
			op:    string(ch),
			left:  n,
			right: n2,
		}
	default:
		// number literal
		return n
	}
}

type charLit struct {
	val uint8
}
type numberLit struct {
	val string
}

func (p *parser) readNumberLitral() *numberLit {
	p.skipWhitespaces()
	first := p.source[p.idx]
	p.idx++
	var buf []byte = []byte{first}
	for {
		ch := p.peekCh()
		if ('0' <= ch && ch <= '9') || ch == 'x' || ('a' <= ch && ch <= 'f') {
			buf = append(buf, ch)
			p.idx++
		} else {
			return &numberLit{val: string(buf)}
		}
	}
}

func isDirective(symbol string) bool {
	return len(symbol) > 0 && symbol[0] == '.'
}

func (p *parser) parseOperand() operand {
	p.skipWhitespaces()
	ch := p.source[p.idx]
	p.parserAssert(ch != '\n', "")

	switch {
	case isSymbolBeginning(ch):
		symbol := p.readSymbol(ch)
		collectAppearedSymbols(symbol)
		switch p.source[p.idx] {
		case '(':
			// indirection e.g. 24(%rbp)
			regi := p.readParenthRegister()
			return &indirection{
				expr: &symbolExpr{
					name: symbol,
				},
				regi: regi,
			}
		case '+': // e.g. foo+8(%rip)
			p.expect('+')
			e := p.parseArithExpr()
			switch p.source[p.idx] {
			case '(':
				regi := p.readParenthRegister()
				return &indirection{
					expr: &binaryExpr{
						op:    "+",
						left:  &symbolExpr{name: symbol},
						right: e,
					},
					regi: regi,
				}
			default:
				panic("Unexpected operand format")
			}
		default:
			// just a symbol
			return &symbolExpr{name: symbol}
		}
	case ch == '\'':
		p.expect('\'')
		b := p.source[p.idx]
		p.idx++
		p.expect('\'')
		return &charLit{
			val: b,
		}
	case ch == '"':
		s := p.readStringLiteral()
		return s
	case '0' <= ch && ch <= '9' || ch == '-': // "24", "-24(%rbp)"
		e := p.parseArithExpr()
		if p.source[p.idx] == '(' {
			// indirection e.g. 24(%rbp)
			regi := p.readParenthRegister()
			return &indirection{
				expr: e,
				regi: regi,
			}
		} else {
			// just a number
			numExpr := e
			return numExpr
		}
	case ch == '(':
		regi := p.readParenthRegister()
		return &indirection{
			regi: regi,
		}
	case ch == '$':
		// AT&T immediate operands are preceded by ‘$’;
		p.expect('$')
		// "$123" "$-7", "$ 2 * 3"
		e := p.parseArithExpr()
		return &immediate{
			expr: e,
		}
	case ch == '%':
		regName := p.readRegi()
		return &register{
			name: regName,
		}
	default:
		p.parseFail("default:buf=" + string(p.source[p.idx:p.idx+4]))
	}
	return nil
}

func (p *parser) parseOperands(keySymbol string) []operand {
	//if keySymbol[0] == '.' {
	//	// directive
	//} else {
	//	// instruction
	//}
	var operands []operand
	for !p.atEOL() {
		op := p.parseOperand()
		operands = append(operands, op)
		p.skipWhitespaces()
		if p.source[p.idx] == ',' {
			p.idx++
			continue
		} else {
			break
		}
	}
	return operands
}

func (p *parser) trySymbol() string {
	first := p.source[p.idx]
	if isSymbolBeginning(first) {
		return p.readSymbol(first)
	} else {
		p.idx++
		return ""
	}
}

type parser struct {
	path   string
	lineno int
	source []byte
	idx    int
}

type operand interface{}

type register struct {
	name string // e.g. "rax"
}

func (reg *register) is64() bool {
	return reg.name[0] == 'r'
}

func (reg *register) toBits() uint8 {
	if reg.is64() {
		return regBits(reg.name[1:])
	} else {
		return regBits(reg.name)
	}
}

// e.g. (%reg), 24(%reg), -24(%reg), foo(%rip), foo+8(%rip)
type indirection struct {
	expr expr
	regi *register
}

func (op *indirection) isRipRelative() bool {
	return op.regi.name == "rip"
}

// $numberExpr
type immediate struct {
	expr expr // "7", "-7", "2+3"
}

// "foo" in ".quad foo" or "foo(%rip)"
type symbolExpr struct {
	name string
}

type expr interface{}

type binaryExpr struct {
	op    string /// "+" or "-"
	left  expr
	right expr
}

type statement struct {
	filePath    *string
	lineno      int
	source      string // for debug output
	labelSymbol string
	keySymbol   string
	operands    []operand
}

func (p *parser) atEOL() bool {
	return p.source[p.idx] == '\n' || p.source[p.idx] == '#'
}

func (p *parser) parseFail(msg string) {
	panic(msg + " at line " + strconv.Itoa(p.lineno))
}

func (p *parser) parserAssert(bol bool, errorMsg string) {
	if !bol {
		p.parseFail("assert failed: " + errorMsg)
	}
}

func (p *parser) consumeEOL() {
	if p.source[p.idx] == '#' {
		p.expect('#')
		p.skipToEOL()
	}
	if p.idx == len(p.source) {
		return
	}
	p.parserAssert(p.source[p.idx] == '\n', "not newline, but got "+string(p.source[p.idx]))
	p.idx++
	p.lineno++
}

// https://sourceware.org/binutils/docs-2.37/as.html#Statements
//
// A statement ends at a newline character (‘\n’) or a line separator character.
// The newline or line separator character is considered to be part of the preceding statement.
// Newlines and separators within character constants are an exception: they do not end statements.
//
// It is an error to end any statement with end-of-file: the last character of any input file should be a newline.
//
// An empty statement is allowed, and may include whitespace. It is ignored.
//
// A statement begins with zero or more labels, optionally followed by a key symbol
// which determines what kind of statement it is.
// The key symbol determines the syntax of the rest of the statement.
// If the symbol begins with a dot ‘.’ then the statement is an assembler directive: typically valid for any computer. If the symbol begins with a letter the statement is an assembly language instruction: it assembles into a machine language instruction. Different versions of as for different computers recognize different instructions. In fact, the same symbol may represent a different instruction in a different computer’s assembly language.
//
// A label is a symbol immediately followed by a colon (:).
// Whitespace before a label or after a colon is permitted, but you may not have whitespace between a label’s symbol and its colon. See Labels.
func (p *parser) parseStmt() *statement {
	var stmt = &statement{
		filePath: &p.path,
		lineno:   p.lineno,
	}
	p.skipWhitespaces()
	if p.source[p.idx] == '/' { // expect // comment
		p.expect('/')
		p.expect('/')
		p.skipToEOL()
		p.consumeEOL()
		return stmt
	}
	if p.atEOL() {
		p.consumeEOL()
		return stmt
	}
	symbol := p.trySymbol()
	//println("  got symbol " + symbol)
	//println("(a) next char is  " + string(source[p.idx]) + ".")
	if symbol == "" {
		p.parserAssert(p.atEOL(), "not at EOL")
		p.consumeEOL()
		return stmt
	}

	var keySymbol string

	if p.source[p.idx] == ':' {
		// this symbol is a label
		stmt.labelSymbol = symbol
		collectAppearedSymbols(symbol)
		p.skipWhitespaces()
		if p.atEOL() {
			p.consumeEOL()
			return stmt
		}
		keySymbol = p.trySymbol()
		if len(keySymbol) == 0 {
			p.skipWhitespaces()
			p.parserAssert(p.atEOL(), "not at EOL")
			p.consumeEOL()
			return stmt
		}
	} else {
		// this symbol is the key symbol in this statement
		keySymbol = symbol
	}
	stmt.keySymbol = keySymbol

	p.skipWhitespaces()
	//println("(b) next char is  " + string(source[p.idx]))
	if p.atEOL() {
		p.consumeEOL()
		return stmt
	}

	//println("  parsing operands...")
	operands := p.parseOperands(keySymbol)
	stmt.operands = operands
	p.consumeEOL()
	return stmt
}

func (p *parser) parse() []*statement {
	var stmts []*statement
	for !p.atEOF() {
		idxBegin := p.idx
		s := p.parseStmt()
		idxEnd := p.idx - 1
		s.source = string(p.source[idxBegin:idxEnd])
		stmts = append(stmts, s)
	}
	return stmts
}

func ParseFile(path string) []*statement {
	src, err := os.ReadFile(path)
	if err != nil {
		panic(err)
	}

	p := &parser{
		path:   path,
		lineno: 1,
		source: src,
		idx:    0,
	}
	return p.parse()

}
