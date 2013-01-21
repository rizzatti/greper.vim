let g:greper#ag#grepprg    = 'ag --nocolor --nogroup --column'
let g:greper#ag#grepformat = '%f:%l:%c:%m'
let g:greper#ag#chars      = '*()+|?.^$[]\{}'

let s:ag = copy(g:greper#class)

function! s:ag.init(command, args) dict abort "{{{
  let self.utility = 'ag'
  let self._super = g:greper#class
  call call(self._super.init, [a:command, a:args], self)
endfunction
"}}}

let g:greper#ag#class = s:ag
