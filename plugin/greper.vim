" Description: Make grep commands more useful
" Author: Zeh Rizzatti <zehrizzatti@gmail.com>
" License: MIT

if exists('loaded_greper') || &compatible || v:version < 700
  finish
endif
let loaded_greper = 1

let s:save_cpoptions = &cpoptions
set cpoptions&vim

if exists('greper_utility')
  let s:utility = greper_utility
endif

function! s:CreateCommand(command, ex, utility) abort "{{{
  if exists(':' . a:command) == 2
    echoerr 'greper.vim: could not create :' . a:command
    return
  endif
  let definition = 'command -bang -nargs=* -complete=file ' . a:command
  let parens = '("' . a:utility . '", "' . a:ex . '<bang>", <f-args>)'
  let callee = ' call greper#run' . parens
  execute definition . callee
endfunction
"}}}

function! s:Greper(bang, word) abort "{{{
  call greper#run(s:utility, 'grep' . a:bang, expand(a:word))
endfunction
"}}}

"{{{ ag commands
if executable('ag')
  if !exists('s:utility')
    let s:utility = 'ag'
  endif
  call s:CreateCommand('Ag', 'grep', 'ag')
  call s:CreateCommand('AgAdd', 'grepadd', 'ag')
  call s:CreateCommand('LAg', 'lgrep', 'ag')
  call s:CreateCommand('LAgAdd', 'lgrepadd', 'ag')
endif
"}}}

"{{{ ack commands
if executable('ack') || executable('ack-grep')
  if !exists('s:utility')
    let s:utility = 'ack'
  endif
  call s:CreateCommand('Ack', 'grep', 'ack')
  call s:CreateCommand('AckAdd', 'grepadd', 'ack')
  call s:CreateCommand('LAck', 'lgrep', 'ack')
  call s:CreateCommand('LAckAdd', 'lgrepadd', 'ack')
endif
"}}}

"{{{ grep commands
if executable('grep')
  if !exists('s:utility')
    let s:utility = 'grep'
  endif
  call s:CreateCommand('Grep', 'grep', 'grep')
  call s:CreateCommand('GrepAdd', 'grepadd', 'grep')
  call s:CreateCommand('LGrep', 'lgrep', 'grep')
  call s:CreateCommand('LGrepAdd', 'lgrepadd', 'grep')
endif
"}}}

"{{{ greper commands
if exists('s:utility')
  call s:CreateCommand('G', 'grep', s:utility)
  call s:CreateCommand('GAdd', 'grepadd', s:utility)
  call s:CreateCommand('LG', 'lgrep', s:utility)
  call s:CreateCommand('LGAdd', 'lgrepadd', s:utility)
  "{{{ <Plug> mappings
  noremap <script> <unique> <Plug>GreperWord <SID>GreperWord
  noremap <SID>GreperWord :call <SID>Greper('', '<cword>')<CR>
  noremap <script> <unique> <Plug>Greper!Word <SID>Greper!Word
  noremap <SID>Greper!Word :call <SID>Greper('!', '<cword>')<CR>
  noremap <script> <unique> <Plug>GreperWORD <SID>GreperWORD
  noremap <SID>GreperWORD :call <SID>Greper('', '<cWORD>')<CR>
  noremap <script> <unique> <Plug>Greper!WORD <SID>Greper!WORD
  noremap <SID>Greper!WORD :call <SID>Greper('!', '<cWORD>')<CR>
  "}}}
else
  echoerr 'greper.vim: could not find any suitable greper utility'
endif
"}}}

let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions
