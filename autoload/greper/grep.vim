" Description: Make grep commands more useful
" Author: Zeh Rizzatti <zehrizzatti@gmail.com>
" License: MIT

let s:class = greper#class.extend()
let s:proto = {}

function! s:proto.constructor(command, args) dict abort "{{{
  let self.utility = 'grep'
  call self.__super('constructor', a:command, a:args)
endfunction
"}}}

function! s:proto._executable() dict abort "{{{
  return self._get(self.patternType . '_executable')
endfunction
"}}}

call s:class.include(s:proto)

let greper#grep#files              = ['*']
let greper#grep#grepformat         = '%f:%l:%m'
let greper#grep#literal_executable = 'fgrep'
let greper#grep#options            = ['-n', '-H', '-R']
let greper#grep#regexp_executable  = 'egrep'
let greper#grep#class              = s:class
