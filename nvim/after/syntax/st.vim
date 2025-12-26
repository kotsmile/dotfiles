" Clear existing syntax (Smalltalk's groups)
syntax clear

" Prevent default override from running again
if exists("b:current_syntax")
  finish
endif

" Keywords
syntax keyword stratosKeyword arg panic store load free push drop dup dup2 swap log float_to_int int_to_float if else endif while endwhile continue break array_init array_push array_pop array_get array_set array_remove array_len foreach endforeach rot macro endmacro
syntax match stratosDebugKeyword /#[a-zA-Z_][a-zA-Z0-9_]*/
syntax match stratosComment "//.*$"

" Strings and escapes
syntax region stratosString start=/"/ skip=/\\"/ end=/"/ contains=stratosEscape,stratosPlaceholder
syntax match stratosEscape /\\[ntr"\\]/ contained
syntax match stratosPlaceholder /{[^}]*}/ contained

" Identifiers
syntax match stratosIdentifier /\v[a-zA-Z_][a-zA-Z0-9_]*/

" Function calls like solana.get_balance
syntax match stratosFunction /\v[a-zA-Z_]+\.[a-zA-Z0-9_]+/

" Types like @sol_address[]
syntax match stratosType "@[a-zA-Z0-9_]\+\[*\]*"

" Highlighting
highlight link stratosKeyword Keyword
highlight link stratosDebugKeyword PreProc
highlight link stratosComment Comment
highlight link stratosString String
highlight link stratosEscape SpecialChar
highlight link stratosPlaceholder SpecialChar
highlight link stratosFunction Function
highlight link stratosType Type
highlight link stratosIdentifier Identifier

" Important: mark as custom syntax to avoid conflict with Smalltalk
let b:current_syntax = "stratos"
