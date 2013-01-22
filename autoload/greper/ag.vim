" Description: Make grep commands more useful
" Author: Zeh Rizzatti <zehrizzatti@gmail.com>
" License: MIT

let s:ag = copy(g:greper#class)

function! s:ag.init(command, args) dict abort "{{{
  let self.utility = 'ag'
  call call(g:greper#class.init, [a:command, a:args], self)
endfunction
"}}}

function! s:ag._options() dict abort "{{{
  let options = self._get('options')
  let modeOptions = self._get(self.patternType . '_options')
  return join(options + modeOptions, ' ')
endfunction
"}}}

let greper#ag#executable      = 'ag'
let greper#ag#files           = []
let greper#ag#grepformat      = '%f:%l:%c:%m'
let greper#ag#options         = ['--nocolor', '--nogroup', '--column']
let greper#ag#literal_options = ['--literal']
let greper#ag#regexp_options  = []
let greper#ag#class           = s:ag
