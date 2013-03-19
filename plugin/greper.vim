" Description: Make grep commands more useful
" Author: José Otávio Rizzatti <zehrizzatti@gmail.com>
" License: MIT

if exists('loaded_greper') || &compatible || v:version < 700
  finish
endif
let loaded_greper = 1

let s:save_cpoptions = &cpoptions
set cpoptions&vim

"{{{ Load funcoo.vim
if !exists('g:loaded_funcoo')
  let funcoo = findfile('plugin/funcoo.vim', &runtimepath)
  if empty(funcoo)
    echohl WarningMsg
    echomsg 'greper.vim: dependencies are not met. please install funcoo.vim'
    echohl None
    finish
  endif
endif
"}}}

if exists('greper["utility"]')
  let s:utility = greper.utility
endif

function! s:CreateCommand(command, ex, utility) abort "{{{
  let command = ':'.a:command
  if exists(command) == 2
    echohl WarningMsg
    echomsg 'greper.vim:' 'could not create command' command
    echohl None
    return
  endif
  let definition = 'command -bang -nargs=* -complete=file'
  let parens = '("'.a:utility.'", "'.a:ex.'<bang>", <f-args>)'
  let callee = 'call greper#run'.parens
  execute definition a:command callee
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
  let utility = s:utility
  call s:CreateCommand('G', 'grep', utility)
  call s:CreateCommand('GAdd', 'grepadd', utility)
  call s:CreateCommand('LG', 'lgrep', utility)
  call s:CreateCommand('LGAdd', 'lgrepadd', utility)
  "{{{ <Plug> mappings
  noremap <script> <unique> <Plug>GreperWord <SID>GreperWord
  noremap <SID>GreperWord
        \ :call greper#run(utility, 'grep', expand('<cword>'))<CR>
  noremap <script> <unique> <Plug>GreperWord! <SID>GreperWord!
  noremap <SID>GreperWord
        \ :call greper#run(utility, 'grep!', expand('<cword>'))<CR>
  noremap <script> <unique> <Plug>GreperWORD <SID>GreperWORD
  noremap <SID>GreperWord
        \ :call greper#run(utility, 'grep', expand('<cWORD>'))<CR>
  noremap <script> <unique> <Plug>GreperWORD! <SID>GreperWORD!
  noremap <SID>GreperWord
        \ :call greper#run(utility, 'grep!', expand('<cWORD>'))<CR>
  "}}}
else
  echohl WarningMsg
  echomsg 'greper.vim:' 'could not find any suitable utility'
  echohl None
endif
"}}}

delfunction s:CreateCommand

let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions
