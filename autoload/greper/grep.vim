" Description: Make grep commands more useful
" Author: Zeh Rizzatti <zehrizzatti@gmail.com>
" License: MIT

let s:grep = copy(g:greper#class)

function! s:grep.init(command, args) dict abort "{{{
  let self.utility = 'grep'
  call call(g:greper#class.init, [a:command, a:args], self)
endfunction
"}}}

function! s:grep._executable() dict abort "{{{
  return self._get(self.patternType . '_executable')
endfunction
"}}}

let greper#grep#files              = ['*']
let greper#grep#grepformat         = '%f:%l:%m'
let greper#grep#literal_executable = 'fgrep'
let greper#grep#options            = ['-n', '-H', '-R']
let greper#grep#regexp_executable  = 'egrep'
let greper#grep#class              = s:grep
