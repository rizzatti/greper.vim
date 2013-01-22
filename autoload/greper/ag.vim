let s:executable      = 'ag'
let s:files           = []
let s:grepformat      = '%f:%l:%c:%m'
let s:options         = ['--nocolor', '--nogroup', '--column']
let s:literal_options = ['--literal']
let s:regexp_options  = []

let s:ag = copy(g:greper#class)

function! s:ag.init(command, args) dict abort "{{{
  let self.utility = 'ag'
  call call(g:greper#class.init, [a:command, a:args], self)
endfunction
"}}}

function! s:ag._get(variable) dict abort "{{{
  return s:{a:variable}
endfunction
"}}}

function! s:ag._options() dict abort "{{{
  let options = self._get('options')
  let modeOptions = self._get(self.patternType . '_options')
  return join(options + modeOptions, ' ')
endfunction
"}}}

let g:greper#ag#class = s:ag
