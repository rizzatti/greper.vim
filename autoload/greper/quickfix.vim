" Description: Make grep commands more useful
" Author: Zeh Rizzatti <zehrizzatti@gmail.com>
" License: MIT

let s:quickfix = funcoo#quickfixwindow#class.extend()
let s:location = funcoo#locationwindow#class.extend()
let s:proto    = {}

function! s:proto.setup() dict abort "{{{
  call self.open()
  if self.number()
    redraw!
    call self._mappings()
  else
    call g:funcoo#util#module.echo('[WarningMsg]', 'No results were found.')
  endif
endfunction
"}}}

function! s:proto._mappings() dict abort "{{{
  noremap <silent> <buffer> go <CR><C-w>p<C-w>=
  noremap <silent> <buffer> gs <C-w>p<C-w>s<C-w>b<CR><C-w>p<C-w>=
  noremap <silent> <buffer> gt <C-w><CR><C-w>TgT<C-w>p
  noremap <silent> <buffer> gv <C-w>p<C-w>v<C-w>b<CR><C-w>p<C-w>=
  noremap <silent> <buffer> o <CR>
  noremap <silent> <buffer> q <C-w>c
  noremap <silent> <buffer> s <C-w>p<C-w>s<C-w>b<CR><C-w>=
  noremap <silent> <buffer> t <C-w><CR><C-w>T
  noremap <silent> <buffer> v <C-w>p<C-w>v<C-w>b<CR><C-w>=
endfunction
"}}}

call s:quickfix.include(s:proto)
call s:location.include(s:proto)

function! greper#quickfix#for(command) abort "{{{
  let class = a:command =~? '^l' ? s:location : s:quickfix
  return class.new()
endfunction
"}}}
