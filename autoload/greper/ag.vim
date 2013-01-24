" Description: Make grep commands more useful
" Author: Zeh Rizzatti <zehrizzatti@gmail.com>
" License: MIT

let s:class = greper#class.extend()
let s:proto = {}

function! s:proto.constructor(command, args) dict abort "{{{
  let self.utility = 'ag'
  call self.__super('constructor', a:command, a:args)
endfunction
"}}}

function! s:proto._options() dict abort "{{{
  let options = self._get('options')
  let modeOptions = self._get(self.patternType . '_options')
  return join(options + modeOptions, ' ')
endfunction
"}}}

call s:class.include(s:proto)

let greper#ag#executable      = 'ag'
let greper#ag#files           = []
let greper#ag#grepformat      = '%f:%l:%c:%m'
let greper#ag#options         = ['--nocolor', '--nogroup', '--column']
let greper#ag#literal_options = ['--literal']
let greper#ag#regexp_options  = []
let greper#ag#class           = s:class
