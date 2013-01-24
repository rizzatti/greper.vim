" Description: Make grep commands more useful
" Author: Zeh Rizzatti <zehrizzatti@gmail.com>
" License: MIT

let s:class = funcoo#object#class.extend()
let s:proto = {}

function! s:proto.constructor(command) dict abort "{{{
  let self.prefix         = a:command =~? '^l' ? 'l' : 'c'
  let self.originalWindow = bufwinnr(bufnr('%'))
  let self.previewWindow  = 0
endfunction
"}}}

function! s:proto.setup() dict abort "{{{
  call self._open()
  call self._addMappings()
endfunction
"}}}

function! s:proto._addMappings() dict abort "{{{
  noremap <silent> <buffer> go <CR><C-w>p<C-w>=
  noremap <silent> <buffer> gs <C-w>p<C-w>s<C-w>b<CR><C-w>p<C-w>=
  noremap <silent> <buffer> gt <C-w><CR><C-w>TgT<C-w>p
  noremap <silent> <buffer> gv <C-w>p<C-w>v<C-w>b<CR><C-w>p<C-w>=
  noremap <silent> <buffer> o <CR>
  execute 'noremap <silent> <buffer> q :' . self.prefix . 'close<CR>'
  noremap <silent> <buffer> s <C-w>p<C-w>s<C-w>b<CR><C-w>=
  noremap <silent> <buffer> t <C-w><CR><C-w>T
  noremap <silent> <buffer> v <C-w>p<C-w>v<C-w>b<CR><C-w>=
endfunction
"}}}

function! s:proto._open() dict abort "{{{
  let command = 'botright ' . self.prefix . 'open'
  silent execute command
endfunction
"}}}

call s:class.include(s:proto)

let greper#quickfix#class = s:class
