" Guard
if exists("b:current_syntax")
  finish
endif

syn keyword gammaKeyword if else while for return break continue module import struct type as c_call sizeof defer
syn region gammaString start=/"/ skip=/\\"/ end=/"/
syn match gammaNumber /\v\d+/
syn match gammaSymbol /\v[\+\-\*\/%&!~\^=<>]+/
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
hi def link gammaSymbol  Operator

let b:current_syntax = "gamma"
