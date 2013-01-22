" Description: Make grep commands more useful
" Author: Zeh Rizzatti <zehrizzatti@gmail.com>
" License: MIT

let s:ack = copy(g:greper#class)

function! s:ack.init(command, args) dict abort "{{{
  let self.utility = 'ack'
  call call(g:greper#class.init, [a:command, a:args], self)
endfunction
"}}}

function! s:ack._options() dict abort "{{{
  let options = self._get('options')
  let modeOptions = self._get(self.patternType . '_options')
  return join(options + modeOptions, ' ')
endfunction
"}}}

let greper#ack#executable      = executable('ack-grep') ? 'ack-grep' : 'ack'
let greper#ack#files           = []
let greper#ack#grepformat      = '%f:%l:%c:%m'
let greper#ack#options         = ['-H', '--nocolor', '--nogroup', '--column']
let greper#ack#literal_options = ['--literal']
let greper#ack#regexp_options  = []
let greper#ack#class           = s:ack
