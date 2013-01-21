let g:greper#grep#grepprg    = 'grep -nHR'
let g:greper#grep#grepformat = '%f:%l:%m'
let g:greper#grep#chars      = '.^$[]\'

let s:grep = copy(g:greper#class)

function! s:grep.init(command, args) dict abort "{{{
  let self.utility = 'grep'
  let self._super = g:greper#class
  call call(self._super.init, [a:command, a:args], self)
endfunction
"}}}

let g:greper#grep#class = s:grep
