" Guard
if exists("b:current_syntax")
  finish
endif

" Keywords
syn keyword gammaKeyword if else while for return break continue module import struct type as c_call sizeof defer
" Strings
syn region gammaString start=/"/ skip=/\\"/ end=/"/
" Numbers
syn match gammaNumber /\v\d+/

" Comments (single line, starting with #)
syn match gammaComment /\/\/.*/
syn match gammaIdentifier /\<[A-Za-z_][A-Za-z0-9_?]*\>/
syn keyword gammaType void bool char str i8 i16 i32 i64 u8 u16 u32 u64 f32 f64 

" Highlight link
hi def link gammaType Type
hi def link gammaIdentifier Identifier
hi def link gammaKeyword Keyword
hi def link gammaString  String
hi def link gammaNumber  Number
hi def link gammaComment Comment

let b:current_syntax = "gamma"
