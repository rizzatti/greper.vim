let s:files              = ['*']
let s:grepformat         = '%f:%l:%m'
let s:literal_executable = 'fgrep'
let s:regexp_executable  = 'egrep'
let s:options            = ['-n', '-H', '-R']

let s:grep = {}

function! s:grep.init(command, args) dict abort "{{{
  let self.utility = 'grep'
  let self.command = a:command
  call self._parse(a:args)
endfunction
"}}}

function! s:grep.run() dict abort "{{{
  call self._sandbox(self._save, self._restore, self._execute)
endfunction
"}}}

function! s:grep._args() dict abort "{{{
  return join([self.pattern] + self.files, ' ')
endfunction
"}}}

function! s:grep._commandLine() dict abort "{{{
  let executable = self._executable()
  let options = self._options()
  return join([executable, options], ' ')
endfunction
"}}}

function! s:grep._exCommand() dict abort "{{{
  return join([self.command, self._args()], ' ')
endfunction
"}}}

function! s:grep._executable() dict abort "{{{
  return self._get(self.patternType . '_executable')
endfunction
"}}}

function! s:grep._execute() dict abort "{{{
  silent execute self._exCommand()
endfunction
"}}}

function! s:grep._get(variable) dict abort "{{{
  return s:{a:variable}
endfunction
"}}}

function! s:grep._options() dict abort "{{{
  return join(self._get('options'), ' ')
endfunction
"}}}

function! s:grep._parse(args) dict abort "{{{
  let size = len(a:args)
  call self._parsePattern(size ? a:args[0] : expand('<cword>'))
  let self.files = size >= 2 ? a:args[1:] : self._get('files')
endfunction
"}}}

function! s:grep._parsePattern(pattern) dict abort "{{{
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

function! s:grep._restore(settings) dict abort "{{{
  let &l:grepprg    = a:settings.grepprg
  let &l:grepformat = a:settings.grepformat
endfunction
"}}}

function! s:grep._sandbox(before, after, worker) dict abort "{{{
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

function! s:grep._save(settings) dict abort "{{{
  let a:settings.grepprg    = &l:grepprg
  let a:settings.grepformat = &l:grepformat
  let &l:grepprg            = self._commandLine()
  let &l:grepformat         = self._get('grepformat')
endfunction
"}}}

let g:greper#grep#class = s:grep
