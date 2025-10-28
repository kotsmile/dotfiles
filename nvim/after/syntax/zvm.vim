if exists("b:current_syntax")
  finish
endif

" Comment
syntax match zvmComment "//.*$"
highlight link zvmComment Comment

" Label definition
syntax match zvmLabel /^[ \t]*\w\+\s*:/
highlight link zvmLabel Label

" Instructions
syntax keyword zvmInstruction
      \ psh pop dup swp
      \ add sub mul div mod
      \ and or not xor
      \ eq neq lt gt le ge
      \ jmp jz jnz jmpl jzl jnzl
      \ halt nop log dmp

highlight link zvmInstruction Keyword

" Hexadecimal values
syntax match zvmHex /\<0x[0-9A-Fa-f]\+\>/
highlight link zvmHex Number

" Integer values
syntax match zvmInteger /\<-\=\d\+\>/
highlight link zvmInteger Number

" Escape sequences inside strings
syntax match zvmEscape /\\[abtnvfre"\\]/ contained
highlight link zvmEscape SpecialChar

" String values
syntax region zvmString start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=zvmEscape
highlight link zvmString String

let b:current_syntax = "zvm"
