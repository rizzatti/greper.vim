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
  redraw
  call self._sandbox(self._save, self._restore, self._execute)
  call self.quickfix.setup()
  redraw!
endfunction
"}}}

function! s:proto._args() dict abort "{{{
  return join([self.pattern] + self.files, ' ')
endfunction
"}}}

function! s:proto._commandLine() dict abort "{{{
  let executable = self._executable()
  let options = self._options()
  return join([executable, options], ' ')
endfunction
"}}}

function! s:proto._exCommand() dict abort "{{{
  return join([self.command, self._args()], ' ')
endfunction
"}}}

function! s:proto._executable() dict abort "{{{
  return self._get('executable')
endfunction
"}}}

function! s:proto._execute() dict abort "{{{
  silent execute self._exCommand()
endfunction
"}}}

function! s:proto._get(variable) dict abort "{{{
  return g:greper#{self.utility}#{a:variable}
endfunction
"}}}

function! s:proto._options() dict abort "{{{
  return join(self._get('options'), ' ')
endfunction
"}}}

function! s:proto._parse(args) dict abort "{{{
  let size = len(a:args)
  call self._parsePattern(size ? a:args[0] : expand('<cword>'))
  let self.files = size >= 2 ? a:args[1:] : self._get('files')
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

function! s:proto._restore(settings) dict abort "{{{
  let &l:grepprg    = a:settings.grepprg
  let &l:grepformat = a:settings.grepformat
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

function! s:proto._save(settings) dict abort "{{{
  let a:settings.grepprg    = &l:grepprg
  let a:settings.grepformat = &l:grepformat
  let &l:grepprg            = self._commandLine()
  let &l:grepformat         = self._get('grepformat')
endfunction
"}}}

call s:class.include(s:proto)

let greper#class = s:class

function! greper#run(utility, command, ...) abort "{{{
  let greper = g:greper#{a:utility}#class.new(a:command, a:000)
  call greper.run()
endfunction
"}}}
