" Description: Make grep commands more useful
" Author: Zeh Rizzatti <zehrizzatti@gmail.com>
" License: MIT

function! s:new(class, ...) abort "{{{
  let instance = copy(a:class)
  call call(instance.init, a:000, instance)
  return instance
endfunction
"}}}

let s:greper = {}

function! s:greper.init(command, args) dict abort "{{{
  let self.command = a:command
  call self._parse(a:args)
  let self.quickfix = s:new(s:quickfix, a:command)
endfunction
"}}}

function! s:greper.run() dict abort "{{{
  redraw
  call self._sandbox(self._save, self._restore, self._execute)
  call self.quickfix.setup()
  redraw!
endfunction
"}}}

function! s:greper._args() dict abort "{{{
  return join([self.pattern] + self.files, ' ')
endfunction
"}}}

function! s:greper._commandLine() dict abort "{{{
  let executable = self._executable()
  let options = self._options()
  return join([executable, options], ' ')
endfunction
"}}}

function! s:greper._exCommand() dict abort "{{{
  return join([self.command, self._args()], ' ')
endfunction
"}}}

function! s:greper._executable() dict abort "{{{
  return self._get('executable')
endfunction
"}}}

function! s:greper._execute() dict abort "{{{
  silent execute self._exCommand()
endfunction
"}}}

function! s:greper._get(variable) dict abort "{{{
  return g:greper#{self.utility}#{a:variable}
endfunction
"}}}

function! s:greper._options() dict abort "{{{
  return join(self._get('options'), ' ')
endfunction
"}}}

function! s:greper._parse(args) dict abort "{{{
  let size = len(a:args)
  call self._parsePattern(size ? a:args[0] : expand('<cword>'))
  let self.files = size >= 2 ? a:args[1:] : self._get('files')
endfunction
"}}}

function! s:greper._parsePattern(pattern) dict abort "{{{
  let matches = matchlist(a:pattern, '^\/\(.*\)\/$')
  if len(matches)
    let self.pattern = shellescape(matches[1])
    let self.patternType = 'regexp'
  else
    let self.pattern = shellescape(a:pattern)
    let self.patternType = 'literal'
  endif
endfunction
"}}}

function! s:greper._restore(settings) dict abort "{{{
  let &l:grepprg    = a:settings.grepprg
  let &l:grepformat = a:settings.grepformat
endfunction
"}}}

function! s:greper._sandbox(before, after, worker) dict abort "{{{
  let sandbox = {}
  call call(a:before, [sandbox], self)
  try
    let result = call(a:worker, [], self)
  finally
    call call(a:after, [sandbox], self)
  endtry
  return result
endfunction
"}}}

function! s:greper._save(settings) dict abort "{{{
  let a:settings.grepprg    = &l:grepprg
  let a:settings.grepformat = &l:grepformat
  let &l:grepprg            = self._commandLine()
  let &l:grepformat         = self._get('grepformat')
endfunction
"}}}

let s:quickfix = {}

function! s:quickfix.init(command) dict abort "{{{
  let self.prefix         = a:command =~? '^l' ? 'l' : 'c'
  let self.originalWindow = bufwinnr(bufnr('%'))
  let self.previewWindow  = 0
endfunction
"}}}

function! s:quickfix.setup() dict abort "{{{
  call self._open()
  call self._addMappings()
endfunction
"}}}

function! s:quickfix._addMappings() dict abort "{{{
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

function! s:quickfix._open() dict abort "{{{
  let command = 'botright ' . self.prefix . 'open'
  silent execute command
endfunction
"}}}

let greper#class = s:greper

function! greper#run(utility, command, ...) abort "{{{
  let greper = s:new(g:greper#{a:utility}#class, a:command, a:000)
  call greper.run()
endfunction
"}}}
