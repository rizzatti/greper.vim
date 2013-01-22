let s:executable      = executable('ack-grep') ? 'ack-grep' : 'ack'
let s:files           = []
let s:grepformat      = '%f:%l:%c:%m'
let s:options         = ['-H', '--nocolor', '--nogroup', '--column']
let s:literal_options = ['--literal']
let s:regexp_options  = []

let s:ack = copy(g:greper#class)

function! s:ack.init(command, args) dict abort "{{{
  let self.utility = 'ack'
  call call(g:greper#class.init, [a:command, a:args], self)
endfunction
"}}}

function! s:ack._get(variable) dict abort "{{{
  return s:{a:variable}
endfunction
"}}}

function! s:ack._options() dict abort "{{{
  let options = self._get('options')
  let modeOptions = self._get(self.patternType . '_options')
  return join(options + modeOptions, ' ')
endfunction
"}}}

let g:greper#ack#class = s:ack
