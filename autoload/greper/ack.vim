" Description: Make grep commands more useful
" Author: Zeh Rizzatti <zehrizzatti@gmail.com>
" License: MIT

let s:class = greper#class.extend()

let s:options                 = {}
let s:options.executable      = executable('ack-grep') ? 'ack-grep' : 'ack'
let s:options.grepformat      = '%f:%l:%c:%m'
let s:options.options         = ['-H', '--nocolor', '--nogroup', '--column']
let s:options.literal_options = ['--literal']

if exists('greper["ack"]')
  let s:dict = g:funcoo#dict#module
  let s:userOptions = s:dict.get(greper, 'ack', {})
  call s:dict.extend(s:class.options, s:userOptions)
endif

let s:class.options = s:options

let s:proto = {}

function! s:proto.constructor(command, args) dict abort "{{{
  let self.utility = 'ack'
  call self.__super('constructor', a:command, a:args)
endfunction
"}}}

function! s:proto._executableOptions() dict abort "{{{
  let options     = self._options('options', [])
  let modeOptions = self._options(self.patternType.'_options', [])
  return join(options + modeOptions)
endfunction
"}}}

call s:class.include(s:proto)

let greper#ack#class = s:class

if !exists('greper_debug') || !greper_debug
  lockvar! greper#ack#class
endif
