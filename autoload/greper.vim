" Description: Make grep commands more useful
" Author: Zeh Rizzatti <zehrizzatti@gmail.com>
" License: MIT

let s:class = funcoo#object#class.extend()
let s:proto = {}

function! s:proto.constructor(command, args) dict abort "{{{
  let self.command = a:command
  call self._parse(a:args)
  let self.quickfix = g:greper#quickfix#class.new(a:command)
endfunction
"}}}

function! s:proto.run() dict abort "{{{
  call self._sandbox(self._save, self._restore, self._execute)
  call self.quickfix.setup()
  redraw!
endfunction
"}}}

function! s:proto._executableName() dict abort "{{{
  return self._options('executable')
endfunction
"}}}

function! s:proto._executableOptions() dict abort "{{{
  return join(self._options('options'))
endfunction
"}}}

function! s:proto._execute() dict abort "{{{
  silent execute self.command self.pattern join(self.files)
endfunction
"}}}

function! s:proto._grepprg() dict abort "{{{
  return join([self._executableName(), self._executableOptions()])
endfunction
"}}}

function! s:proto._options(variable, ...) dict abort "{{{
  return get(self.__class__.options, a:variable, a:0 ? a:1 : 0)
endfunction
"}}}

function! s:proto._parse(args) dict abort "{{{
  let size = len(a:args)
  call self._parsePattern(size ? a:args[0] : expand('<cword>'))
  let self.files = size > 1 ? a:args[1:] : self._options('files', [])
endfunction
"}}}

function! s:proto._parsePattern(pattern) dict abort "{{{
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

function! s:proto._restore(sandbox) dict abort "{{{
  let &l:grepprg    = a:sandbox.grepprg
  let &l:grepformat = a:sandbox.grepformat
endfunction
"}}}

function! s:proto._sandbox(before, after, worker) dict abort "{{{
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

function! s:proto._save(sandbox) dict abort "{{{
  let a:sandbox.grepprg    = &l:grepprg
  let a:sandbox.grepformat = &l:grepformat
  let &l:grepprg           = self._grepprg()
  let &l:grepformat        = self._options('grepformat')
endfunction
"}}}

call s:class.include(s:proto)

let greper#class = s:class

function! greper#run(utility, command, ...) abort "{{{
  let greper = g:greper#{a:utility}#class.new(a:command, a:000)
  call greper.run()
endfunction
"}}}

if !exists('greper_debug') || !greper_debug
  lockvar! s:class
endif
