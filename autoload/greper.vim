function! s:new(class, ...) abort "{{{
  let instance = copy(a:class)
  call call(instance.init, a:000, instance)
  return instance
endfunction
"}}}

let s:greper = {}

let s:window = {}

function! s:window.init(command) dict abort "{{{
  let self.prefix = a:command =~? '^l' ? 'l' : 'c'
endfunction
"}}}

function! s:window.setup() dict abort "{{{
  call self._open()
  call self._addMappings()
endfunction
"}}}

function! s:window._addMappings() dict abort "{{{
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

function! s:window._open() dict abort "{{{
  let command = 'botright ' . self.prefix . 'open'
  silent execute command
endfunction
"}}}

let g:greper#class = s:greper

function! greper#run(utility, command, ...) abort "{{{
  redraw
  let greper = s:new(g:greper#{a:utility}#class, a:command, a:000)
  let window = s:new(s:window, a:command)
  call greper.run()
  call window.setup()
  redraw!
endfunction
"}}}
