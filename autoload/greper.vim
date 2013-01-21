function! s:new(class, ...) abort "{{{
  let instance = copy(a:class)
  call call(instance.init, a:000, instance)
  return instance
endfunction
"}}}

let s:greper = {}

function! s:greper.init(command, args) dict abort "{{{
  let self.command = a:command
  let self.args    = self._parse(a:args)
endfunction
"}}}

function! s:greper.execute() dict abort "{{{
  call self._saveOptions()
  silent execute join([self.command, self.args], ' ')
  call self._restoreOptions()
endfunction
"}}}

function! s:greper._escape(pattern) dict abort "{{{
  let matches = matchlist(a:pattern, '^\/\(.*\)\/$')
  if len(matches) == 0
    let pattern = escape(a:pattern, self._get('chars'))
  else
    let pattern = matches[1]
  endif
  return shellescape(pattern, 1)
endfunction
"}}}

function! s:greper._get(variable) dict abort "{{{
  return g:greper#{self.utility}#{a:variable}
endfunction
"}}}

function! s:greper._parse(args) dict abort "{{{
  let size    = len(a:args)
  let pattern = self._escape(size ? a:args[0] : expand('<cword>'))
  let files   = size >= 2 ? a:args[1:] : ['*']
  return join([pattern] + files, ' ')
endfunction
"}}}

function! s:greper._restoreOptions() dict abort "{{{
  let &grepprg    = self._grepprg
  let &grepformat = self._grepformat
endfunction
"}}}

function! s:greper._saveOptions() dict abort "{{{
  let self._grepprg    = &grepprg
  let self._grepformat = &grepformat
  let &grepprg         = self._get('grepprg')
  let &grepformat      = self._get('grepformat')
endfunction
"}}}

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
  call greper.execute()
  call window.setup()
  redraw!
endfunction
"}}}
