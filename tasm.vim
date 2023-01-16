" Vim syntax file
" Language: TASM
" Maintainer: Andreas Krühlmann
" Latest Revision: 22 April 2022

if exists("b:current_syntax")
  finish
endif

syn keyword keywords if clone clone2 do drop else endif if load mem over put swap syscall1 syscall2 syscall3 unless wend while write
syn match functions 'syscall\d\+'
syn match celNumber '\d\+'
syn match string '".*"'

let b:current_syntax = "tasm"

hi def link keywords Statement
hi def link functions Function
hi def link string Constant
