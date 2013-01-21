let g:greper#ack#grepprg    = 'ack -H --nocolor --nogroup --column'
let g:greper#ack#grepformat = '%f:%l:%c:%m'
let g:greper#ack#chars      = '*()+|?.^$[]\{}'

let s:ack = copy(g:greper#class)

function! s:ack.init(command, args) dict abort "{{{
  let self.utility = 'ack'
  let self._super = g:greper#class
  call call(self._super.init, [a:command, a:args], self)
endfunction
"}}}

let g:greper#ack#class = s:ack
