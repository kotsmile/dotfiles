" zylo.vim - Syntax highlighting for Zylo language
" Maintainer: kotsmile

" Clear any existing syntax
syntax clear

if exists("b:current_syntax")
  finish
endif

" === Keywords ===
syntax keyword zyloKeyword fn struct return let if else while for in true false

" === Built-in VM intrinsics ===
syntax keyword zyloBuiltin tx_start tx_add_account tx_sign tx_abort tx_submit

" === Types ===
syntax keyword zyloType int bool float
syntax match zyloType /\v[A-Z][a-zA-Z0-9_]*/           " user-defined types (e.g. Point)
syntax match zyloType /\v[a-zA-Z_][a-zA-Z0-9_]*\[\]/   " array types (e.g. int[], Point[])

" === Function definitions and calls ===
syntax match zyloFunctionDef /\vfn\s+\zs[a-zA-Z_][a-zA-Z0-9_]*/
syntax match zyloFunctionCall /\v[a-zA-Z_][a-zA-Z0-9_]*\ze\(/

" === Constants ===
syntax match zyloNumber /\v-?\d+(\.\d+)?/
syntax match zyloBoolean /\v(true|false)/

" === Strings, escapes, placeholders ===
syntax region zyloString start=/"/ skip=/\\"/ end=/"/ contains=zyloEscape,zyloPlaceholder
syntax match zyloEscape /\\[ntr"\\]/ contained
syntax match zyloPlaceholder /{[^}]*}/ contained

" === Identifiers (only used where untyped) ===
syntax match zyloIdentifier /\v[a-z_][a-zA-Z0-9_]*/ contained

" === Comments ===
syntax match zyloComment "//.*$"

" === Operators ===
syntax match zyloOperator /==\|!=\|<=\|>=/
syntax match zyloOperator /[-+*/%=<>!]/

" === Punctuation ===
syntax match zyloPunctuation /[{}()\[\];.,]/

" === Highlight Links ===
highlight link zyloKeyword       Keyword
highlight link zyloBuiltin       Function
highlight link zyloType          Type
highlight link zyloFunctionDef   Function
highlight link zyloFunctionCall  Function
highlight link zyloNumber        Number
highlight link zyloBoolean       Boolean
highlight link zyloString        String
highlight link zyloEscape        SpecialChar
highlight link zyloPlaceholder   SpecialChar
highlight link zyloIdentifier    Identifier
highlight link zyloComment       Comment
highlight link zyloOperator      Operator
highlight link zyloPunctuation   Delimiter

" Register the filetype
let b:current_syntax = "zylo"
