module Syntax where
-- Context Free Grammar

{-
<program> -> [<stmt>]
<stmt> -> <var> : <type> = <value> | print <expr> | if <cond> then [<stmt>] else [<stmt>]
        | while <cond> [<stmt>]
<var> -> <string>
<type> -> bin | dec | hex
<expr> -> <expr> + <expr> | <value> | <var> | convert <expr> to <type> 
<cond> -> <expr> == <expr> | <expr> != <expr>
<value> -> <hexadecimal> | <binary> | <decimal>

<bindigit> -> 0 | 1
<binary> -> <bindigit> | <bindigit><binary>

<decdigit> -> 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9
<decimal> -> <decdigit> | <decdigit><decimal>

<hexdigit> -> 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | a | b | c | d | e | f
<hexadecimal> -> <hexdigit> | <hexdigit><hexadecimal>
-}

-- AST
type Program = [Stmt]
data Stmt = Assign Var Type Value | Print Expr | IfElse Cond [Stmt] [Stmt]
        | While Cond [Stmt]

type Var = String
data Type = Bin | Dec | Hex 
data Expr = Add Expr Expr | V Value | Ref Var | Convert Expr Type
data Cond = Equal Expr Expr | NEqual Expr Expr
data Value = B Binary | D Decimal | H Hexadecminal

data BinDigit = ZBin | OBin
data DecDigit = ZDec | ODec | TwDex | ThDec | FrDec | FvDec
        | SxDec | SnDex | EDec | NDec

data HexDigit = ZHex | OHex | TwHex | ThHex | FrHex | FvHex
            | SxHex | SnHex | EtHex | NHex | AHex | BHex | CHex
            | DHex | EHex | FHex

type Binary = [BinDigit]
type Hexadecminal = [HexDigit]
type Decimal = [DecDigit]