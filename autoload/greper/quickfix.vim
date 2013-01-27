" Description: Make grep commands more useful
" Author: Zeh Rizzatti <zehrizzatti@gmail.com>
" License: MIT

" function! s:proto._addMappings() dict abort "{{{
"   noremap <silent> <buffer> go <CR><C-w>p<C-w>=
"   noremap <silent> <buffer> gs <C-w>p<C-w>s<C-w>b<CR><C-w>p<C-w>=
"   noremap <silent> <buffer> gt <C-w><CR><C-w>TgT<C-w>p
"   noremap <silent> <buffer> gv <C-w>p<C-w>v<C-w>b<CR><C-w>p<C-w>=
"   noremap <silent> <buffer> o <CR>
"   execute 'noremap <silent> <buffer> q :' . self.prefix . 'close<CR>'
"   noremap <silent> <buffer> s <C-w>p<C-w>s<C-w>b<CR><C-w>=
"   noremap <silent> <buffer> t <C-w><CR><C-w>T
"   noremap <silent> <buffer> v <C-w>p<C-w>v<C-w>b<CR><C-w>=
" endfunction
" "}}}

function! greper#quickfix#for(command) abort "{{{
  if a:command =~? '^l'
    let class = g:funcoo#locationwindow#class
  else
    let class = g:funcoo#quickfixwindow#class
  endif
  return class.new()
endfunction
"}}}
