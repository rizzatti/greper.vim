" Description: Make grep commands more useful
" Author: Zeh Rizzatti <zehrizzatti@gmail.com>
" License: MIT

let s:class = greper#class.extend()

let s:options                    = {}
let s:options.files              = ['*']
let s:options.grepformat         = '%f:%l:%m'
let s:options.literal_executable = 'fgrep'
let s:options.options            = ['-n', '-H', '-R']
let s:options.regexp_executable  = 'egrep'

if exists('greper["grep"]')
  let s:dict = g:funcoo#dict#module
  let s:userOptions = s:dict.get(greper, 'grep', {})
  call s:dict.extend(s:class.options, s:userOptions)
endif

let s:class.options = s:options

let s:proto = {}

function! s:proto.constructor(command, args) dict abort "{{{
  let self.utility = 'grep'
  call self.__super('constructor', a:command, a:args)
endfunction
"}}}

function! s:proto._executableName() dict abort "{{{
  return self._options(self.patternType . '_executable', 'grep')
endfunction
"}}}

call s:class.include(s:proto)

let greper#grep#class = s:class

if !exists('greper_debug') || !greper_debug
  lockvar! greper#grep#class
endif
