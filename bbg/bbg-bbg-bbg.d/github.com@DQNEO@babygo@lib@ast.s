#=== Package github.com/DQNEO/babygo/lib/ast
#--- walk 
# Package types:
# type ast.Signature struct{Params *ast.FieldList;Results *ast.FieldList;}
# type ast.ObjKind string
# type ast.Object struct{Kind ast.ObjKind;Name string;Decl interface{};Data interface{};}
# type ast.Expr interface{}
# type ast.Field struct{Names []*ast.Ident;Type ast.Expr;Offset int;}
# type ast.FieldList struct{List []*ast.Field;}
# type ast.Ident struct{Name string;Obj *ast.Object;}
# type ast.Ellipsis struct{Elt ast.Expr;}
# type ast.BasicLit struct{Kind token.Token;Value string;}
# type ast.CompositeLit struct{Type ast.Expr;Elts []ast.Expr;}
# type ast.KeyValueExpr struct{Key ast.Expr;Value ast.Expr;}
# type ast.ParenExpr struct{X ast.Expr;}
# type ast.SelectorExpr struct{X ast.Expr;Sel *ast.Ident;}
# type ast.IndexExpr struct{X ast.Expr;Index ast.Expr;}
# type ast.SliceExpr struct{X ast.Expr;Low ast.Expr;High ast.Expr;Max ast.Expr;Slice3 bool;}
# type ast.CallExpr struct{Fun ast.Expr;Args []ast.Expr;Ellipsis token.Pos;}
# type ast.StarExpr struct{X ast.Expr;}
# type ast.UnaryExpr struct{X ast.Expr;Op token.Token;}
# type ast.BinaryExpr struct{X ast.Expr;Y ast.Expr;Op token.Token;}
# type ast.TypeAssertExpr struct{X ast.Expr;Type ast.Expr;}
# type ast.ArrayType struct{Len ast.Expr;Elt ast.Expr;}
# type ast.StructType struct{Fields *ast.FieldList;}
# type ast.InterfaceType struct{Methods []string;}
# type ast.MapType struct{Key ast.Expr;Value ast.Expr;}
# type ast.FuncType struct{Params *ast.FieldList;Results *ast.FieldList;}
# type ast.Stmt interface{}
# type ast.DeclStmt struct{Decl ast.Decl;}
# type ast.ExprStmt struct{X ast.Expr;}
# type ast.IncDecStmt struct{X ast.Expr;Tok token.Token;}
# type ast.AssignStmt struct{Lhs []ast.Expr;Tok token.Token;Rhs []ast.Expr;IsRange bool;}
# type ast.ReturnStmt struct{Results []ast.Expr;}
# type ast.BranchStmt struct{Tok token.Token;Label string;}
# type ast.BlockStmt struct{List []ast.Stmt;}
# type ast.IfStmt struct{Init ast.Stmt;Cond ast.Expr;Body *ast.BlockStmt;Else ast.Stmt;}
# type ast.CaseClause struct{List []ast.Expr;Body []ast.Stmt;}
# type ast.SwitchStmt struct{Init ast.Expr;Tag ast.Expr;Body *ast.BlockStmt;}
# type ast.TypeSwitchStmt struct{Assign ast.Stmt;Body *ast.BlockStmt;}
# type ast.ForStmt struct{Init ast.Stmt;Cond ast.Expr;Post ast.Stmt;Body *ast.BlockStmt;}
# type ast.RangeStmt struct{Key ast.Expr;Value ast.Expr;X ast.Expr;Body *ast.BlockStmt;Tok token.Token;}
# type ast.GoStmt struct{Call *ast.CallExpr;}
# type ast.ImportSpec struct{Path *ast.BasicLit;}
# type ast.ValueSpec struct{Names []*ast.Ident;Type ast.Expr;Values []ast.Expr;}
# type ast.TypeSpec struct{Name *ast.Ident;Assign bool;Type ast.Expr;}
# type ast.Decl interface{}
# type ast.Spec interface{}
# type ast.GenDecl struct{Specs []ast.Spec;}
# type ast.FuncDecl struct{Recv *ast.FieldList;Name *ast.Ident;Type *ast.FuncType;Body *ast.BlockStmt;}
# type ast.File struct{Name *ast.Ident;Imports []*ast.ImportSpec;Decls []ast.Decl;Unresolved []*ast.Ident;Scope *ast.Scope;}
# type ast.Scope struct{Outer *ast.Scope;Objects map[string]*ast.Object;}
#--- string literals
.data
.string_0:
  .string "Con"
.string_1:
  .string "Typ"
.string_2:
  .string "Var"
.string_3:
  .string "Fun"
.string_4:
  .string "Pkg"
.string_5:
  .string "s sholud not be nil\n"
#--- global vars (static values)
.global ast.Con
ast.Con: # T T_STRING
  .quad .string_0
  .quad 3
.global ast.Typ
ast.Typ: # T T_STRING
  .quad .string_1
  .quad 3
.global ast.Var
ast.Var: # T T_STRING
  .quad .string_2
  .quad 3
.global ast.Fun
ast.Fun: # T T_STRING
  .quad .string_3
  .quad 3
.global ast.Pkg
ast.Pkg: # T T_STRING
  .quad .string_4
  .quad 3

#--- global vars (dynamic value setting)
.text
.global ast.__initGlobals
ast.__initGlobals:
  ret

# Method ast.ObjKind.String
.global ast.ObjKind.String
ast.ObjKind.String: # args 48, locals 0
  pushq %rbp
  movq %rsp, %rbp
  leaq 32(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  leaq 16(%rbp), %rax # local variable "ok"
  pushq %rax # variable address
  popq %rax # address of T_STRING
  movq 8(%rax), %rdx # len
  movq 0(%rax), %rax # ptr
  pushq %rdx # len
  pushq %rax # ptr
  popq %rax # string.ptr
  popq %rcx # string.len
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  leave
  ret
  leave
  ret

# Function ast.NewScope
.global ast.NewScope
ast.NewScope: # args 32, locals 0
  pushq %rbp
  movq %rsp, %rbp
  leaq 24(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  subq $8, %rsp # alloc return vars area
  pushq $16
  callq runtime.malloc
  addq $8, %rsp # free parameters area
  #  totalReturnSize=8
  movq 0(%rsp), %rax # copy stack top value (address of struct heaad) 
  pushq %rax
  popq %rax
  addq $0, %rax
  pushq %rax
  leaq 16(%rbp), %rax # local variable "outer"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  movq 0(%rsp), %rax # copy stack top value (address of struct heaad) 
  pushq %rax
  popq %rax
  addq $8, %rax
  pushq %rax
  subq $8, %rsp # alloc return vars area
  subq $16, %rsp # alloc parameters area
  pushq $0 # number literal
  popq %rax # result of T_UINTPTR
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  pushq $8 # number literal
  popq %rax # result of T_UINTPTR
  leaq 8(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  callq runtime.makeMap
  addq $16, %rsp # free parameters area
  #  totalReturnSize=8
  popq %rax # result of T_MAP
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leave
  ret
  leave
  ret

# Method ast.$Scope.Insert
.global ast.$Scope.Insert
ast.$Scope.Insert: # args 32, locals 0
  pushq %rbp
  movq %rsp, %rbp
  leaq 16(%rbp), %rax # local variable "s"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  pushq $0 # T_POINTER zero value (nil pointer)
  popq %rcx # right
  popq %rax # left
  cmpq %rcx, %rax
  sete %al
  movzbq %al, %rax
  pushq %rax
  popq %rax # result of if condition
  cmpq $1, %rax
  jne .L.endif.101 # jmp if false
  subq $16, %rsp # alloc parameters area
  pushq $20 # str len
  leaq .string_5(%rip), %rax # str ptr
  pushq %rax # str ptr
  subq $8, %rsp # alloc return vars area
  pushq $16
  callq runtime.malloc
  addq $8, %rsp # free parameters area
  #  totalReturnSize=8
  popq %rsi # lhs addr
  popq %rax # string.ptr
  popq %rcx # string.len
  pushq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  leaq .dtype.1(%rip), %rax # dtype label address "string"
  pushq %rax           # dtype label address
  popq %rax # eface.dtype
  popq %rcx # eface.data
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # store dtype
  movq %rcx, 8(%rsi) # store data
  callq runtime.panic
  addq $16, %rsp # free parameters area
  #  totalReturnSize=0
  .L.endif.101:
  subq $8, %rsp # alloc return vars area
  subq $24, %rsp # alloc parameters area
  leaq 16(%rbp), %rax # local variable "s"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax
  addq $8, %rax
  pushq %rax
  popq %rax # address of T_MAP
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_UINTPTR
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq 24(%rbp), %rax # local variable "obj"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax
  addq $16, %rax
  pushq %rax
  popq %rax # address of T_STRING
  movq 8(%rax), %rdx # len
  movq 0(%rax), %rax # ptr
  pushq %rdx # len
  pushq %rax # ptr
  subq $8, %rsp # alloc return vars area
  pushq $16
  callq runtime.malloc
  addq $8, %rsp # free parameters area
  #  totalReturnSize=8
  popq %rsi # lhs addr
  popq %rax # string.ptr
  popq %rcx # string.len
  pushq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  leaq .dtype.1(%rip), %rax # dtype label address "string"
  pushq %rax           # dtype label address
  popq %rax # eface.dtype
  popq %rcx # eface.data
  leaq 8(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # store dtype
  movq %rcx, 8(%rsi) # store data
  callq runtime.getAddrForMapSet
  addq $24, %rsp # free parameters area
  #  totalReturnSize=8
  leaq 24(%rbp), %rax # local variable "obj"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leave
  ret

# Method ast.$Scope.Lookup
.global ast.$Scope.Lookup
ast.$Scope.Lookup: # args 48, locals -16
  pushq %rbp
  movq %rsp, %rbp
  subq $16, %rsp # local area
  subq $16, %rsp # alloc return vars area
  subq $24, %rsp # alloc parameters area
  leaq 16(%rbp), %rax # local variable "s"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax
  addq $8, %rax
  pushq %rax
  popq %rax # address of T_MAP
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_UINTPTR
  leaq 0(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq 24(%rbp), %rax # local variable "name"
  pushq %rax # variable address
  popq %rax # address of T_STRING
  movq 8(%rax), %rdx # len
  movq 0(%rax), %rax # ptr
  pushq %rdx # len
  pushq %rax # ptr
  subq $8, %rsp # alloc return vars area
  pushq $16
  callq runtime.malloc
  addq $8, %rsp # free parameters area
  #  totalReturnSize=8
  popq %rsi # lhs addr
  popq %rax # string.ptr
  popq %rcx # string.len
  pushq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # ptr to ptr
  movq %rcx, 8(%rsi) # len to len
  leaq .dtype.1(%rip), %rax # dtype label address "string"
  pushq %rax           # dtype label address
  popq %rax # eface.dtype
  popq %rcx # eface.data
  leaq 8(%rsp), %rsi # place to save
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # store dtype
  movq %rcx, 8(%rsi) # store data
  callq runtime.getAddrForMapGet
  addq $24, %rsp # free parameters area
  #  totalReturnSize=16
  popq %rax # result of map get:  ok value
  cmpq $1, %rax
  jne .L.not_found.102 # jmp if false
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  pushq $1 # ok = true
  jmp .L.end_map_get.102
  .L.not_found.102:
  popq %rax # result of T_POINTER
  pushq $0 # T_POINTER zero value (nil pointer)
  pushq $0 # ok = false
  .L.end_map_get.102:
  leaq -16(%rbp), %rax # local variable "ok"
  pushq %rax # variable address
  popq %rsi # lhs addr
  popq %rax # result of T_BOOL
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign quad
  leaq -8(%rbp), %rax # local variable "obj"
  pushq %rax # variable address
  popq %rsi # lhs addr
  popq %rax # result of T_POINTER
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leaq -16(%rbp), %rax # local variable "ok"
  pushq %rax # variable address
  popq %rax # address of T_BOOL
  movq 0(%rax), %rax # load 64 bit
  pushq %rax
  popq %rax # result of 
  xor $1, %rax
  pushq %rax
  popq %rax # result of if condition
  cmpq $1, %rax
  jne .L.endif.103 # jmp if false
  leaq 40(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  pushq $0 # T_POINTER zero value (nil pointer)
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leave
  ret
  .L.endif.103:
  leaq 40(%rbp), %rax # local variable ".r0"
  pushq %rax # variable address
  leaq -8(%rbp), %rax # local variable "obj"
  pushq %rax # variable address
  popq %rax # address of T_POINTER
  movq 0(%rax), %rax # load 64 bit pointer
  pushq %rax
  popq %rax # result of T_POINTER
  popq %rsi # lhs addr
  pushq %rsi # place to save
  popq %rsi # place to save
  movq %rax, 0(%rsi) # assign ptr
  leave
  ret
  leave
  ret
# ------- Dynamic Types ------
.data
.dtype.1: # string
  .quad 1
  .quad .string.dtype.1
  .quad 6
.string.dtype.1:
  .string "string"


