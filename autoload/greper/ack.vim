" Description: Make grep commands more useful
" Author: Zeh Rizzatti <zehrizzatti@gmail.com>
" License: MIT

let s:class = greper#class.extend()
let s:proto = {}

function! s:proto.constructor(command, args) dict abort "{{{
  let self.utility = 'ack'
  call call(self.__super__.constructor, [a:command, a:args], self)
endfunction
"}}}

function! s:proto._options() dict abort "{{{
  let options = self._get('options')
  let modeOptions = self._get(self.patternType . '_options')
  return join(options + modeOptions, ' ')
endfunction
"}}}

call s:class.include(s:proto)

let greper#ack#executable      = executable('ack-grep') ? 'ack-grep' : 'ack'
let greper#ack#files           = []
let greper#ack#grepformat      = '%f:%l:%c:%m'
let greper#ack#options         = ['-H', '--nocolor', '--nogroup', '--column']
let greper#ack#literal_options = ['--literal']
let greper#ack#regexp_options  = []
let greper#ack#class           = s:class
