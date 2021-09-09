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

func peekCh() byte {
	if idx == len(source) {
		return 255
	}
	return source[idx]
}

// https://sourceware.org/binutils/docs-2.37/as.html#Whitespace
// Whitespace is one or more blanks or tabs, in any order.
// Whitespace is used to separate symbols, and to make programs neater for people to read.
// Unless within character constants (see Character Constants), any whitespace means the same as exactly one space.
func skipWhitespaces() {
	for idx < len(source) && source[idx] != '\n' {
		ch := source[idx]
		if ch == ' ' || ch == '\t' {
			idx++
			continue
		}
		return
	}
}

func skipToEOL() {
	for ; source[idx] != '\n'; idx++ {
	}
}

func readParenthRegister() *register {
	expect('(')
	if source[idx] == '%' {
		regi := readRegi()
		expect(')')
		return &register{name: regi}
	} else {
		parseFail("TBI")
		return nil
	}
}

func expect(ch byte) {
	if source[idx] != ch {
		panic(fmt.Sprintf("[parser] %c is expected, but got %c at line %d", ch, source[idx], lineno))
	}
	idx++
}

func isAlphabet(ch byte) bool {
	return ('a' <= ch && ch <= 'z') || ('A' <= ch && ch <= 'Z')
}

func readRegi() string {
	expect('%')
	var buf []byte
	for {
		ch := source[idx]
		if isAlphabet(ch) {
			idx++
			buf = append(buf, ch)
		} else {
			return string(buf)
		}
	}
}

func readSymbol(first byte) string {
	expect(first)
	var buf []byte = []byte{first}
	for {
		ch := source[idx]
		if isSymbolLetter(ch) {
			buf = append(buf, ch)
			idx++
		} else {
			sym := string(buf)
			return sym
		}
	}
}

func readStringLiteral() string {
	expect('"')
	var buf []byte
	for {
		ch := peekCh()
		switch ch {
		case '\\':
			expect('\\')
			ch := peekCh()
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
			idx++
			buf = append(buf, out)
			continue
		case '"':
			idx++
			return string(buf)
		default:
			idx++
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
func parseArithExpr() expr {

	n := readNumberLitral()
	skipWhitespaces()
	ch := source[idx]
	switch ch {
	case '+', '-', '*', '/':
		idx++
		n2 := readNumberLitral()
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

func readNumberLitral() *numberLit {
	skipWhitespaces()
	first := source[idx]
	idx++
	var buf []byte = []byte{first}
	for {
		ch := peekCh()
		if ('0' <= ch && ch <= '9') || ch == 'x' || ('a' <= ch && ch <= 'f') {
			buf = append(buf, ch)
			idx++
		} else {
			return &numberLit{val: string(buf)}
		}
	}
}

func isDirective(symbol string) bool {
	return len(symbol) > 0 && symbol[0] == '.'
}

func parseOperand() operand {
	skipWhitespaces()
	ch := source[idx]
	parserAssert(ch != '\n', "")

	switch {
	case isSymbolBeginning(ch):
		symbol := readSymbol(ch)
		collectAppearedSymbols(symbol)
		switch source[idx] {
		case '(':
			// indirection e.g. 24(%rbp)
			regi := readParenthRegister()
			return &indirection{
				expr: &symbolExpr{
					name: symbol,
				},
				regi: regi,
			}
		case '+': // e.g. foo+8(%rip)
			expect('+')
			e := parseArithExpr()
			switch source[idx] {
			case '(':
				regi := readParenthRegister()
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
		expect('\'')
		b := source[idx]
		idx++
		expect('\'')
		return &charLit{
			val: b,
		}
	case ch == '"':
		s := readStringLiteral()
		return s
	case '0' <= ch && ch <= '9' || ch == '-': // "24", "-24(%rbp)"
		e := parseArithExpr()
		if source[idx] == '(' {
			// indirection e.g. 24(%rbp)
			regi := readParenthRegister()
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
		regi := readParenthRegister()
		return &indirection{
			regi: regi,
		}
	case ch == '$':
		// AT&T immediate operands are preceded by ‘$’;
		expect('$')
		// "$123" "$-7", "$ 2 * 3"
		e := parseArithExpr()
		return &immediate{
			expr: e,
		}
	case ch == '%':
		regName := readRegi()
		return &register{
			name: regName,
		}
	default:
		parseFail("default:buf=" + string(source[idx:idx+4]))
	}
	return nil
}

func parseOperands(keySymbol string) []operand {
	//if keySymbol[0] == '.' {
	//	// directive
	//} else {
	//	// instruction
	//}
	var operands []operand
	for !atEOL() {
		op := parseOperand()
		operands = append(operands, op)
		skipWhitespaces()
		if source[idx] == ',' {
			idx++
			continue
		} else {
			break
		}
	}
	return operands
}

func trySymbol() string {
	first := source[idx]
	if isSymbolBeginning(first) {
		return readSymbol(first)
	} else {
		idx++
		return ""
	}
}

var filename string
var source []byte
var idx int
var lineno int = 1

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
	filename    *string
	lineno      int
	raw         string
	labelSymbol string
	keySymbol   string
	operands    []operand
}

func atEOL() bool {
	return source[idx] == '\n' || source[idx] == '#'
}

func parseFail(msg string) {
	panic(msg + " at line " + strconv.Itoa(lineno))
}

func parserAssert(bol bool, errorMsg string) {
	if !bol {
		parseFail("assert failed: " + errorMsg)
	}
}

func consumeEOL() {
	if source[idx] == '#' {
		expect('#')
		skipToEOL()
	}
	if idx == len(source) {
		return
	}
	parserAssert(source[idx] == '\n', "not newline, but got "+string(source[idx]))
	idx++
	lineno++
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
func parseStmt() *statement {
	var stmt = &statement{
		filename: &filename,
		lineno:   lineno,
	}
	skipWhitespaces()
	if source[idx] == '/' { // expect // comment
		expect('/')
		expect('/')
		skipToEOL()
		consumeEOL()
		return stmt
	}
	if atEOL() {
		consumeEOL()
		return stmt
	}
	symbol := trySymbol()
	//println("  got symbol " + symbol)
	//println("(a) next char is  " + string(source[idx]) + ".")
	if symbol == "" {
		parserAssert(atEOL(), "not at EOL")
		consumeEOL()
		return stmt
	}

	var keySymbol string

	if source[idx] == ':' {
		// this symbol is a label
		stmt.labelSymbol = symbol
		collectAppearedSymbols(symbol)
		skipWhitespaces()
		if atEOL() {
			consumeEOL()
			return stmt
		}
		keySymbol = trySymbol()
		if len(keySymbol) == 0 {
			skipWhitespaces()
			parserAssert(atEOL(), "not at EOL")
			consumeEOL()
			return stmt
		}
	} else {
		// this symbol is the key symbol in this statement
		keySymbol = symbol
	}
	stmt.keySymbol = keySymbol

	skipWhitespaces()
	//println("(b) next char is  " + string(source[idx]))
	if atEOL() {
		consumeEOL()
		return stmt
	}

	//println("  parsing operands...")
	operands := parseOperands(keySymbol)
	stmt.operands = operands
	consumeEOL()
	return stmt
}

func parseFile(path string) []*statement {
	src, err := os.ReadFile(path)
	if err != nil {
		panic(err)
	}
	source = src
	filename = path
	idx = 0
	lineno = 1

	var stmts []*statement
	var i int = 1
	for idx < len(source) {
		//println(i, " reading...")
		idxBegin := idx
		s := parseStmt()
		idxEnd := idx
		s.raw = string(source[idxBegin : idxEnd-1])
		stmts = append(stmts, s)
		i++
	}
	return stmts
}
