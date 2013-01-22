let s:files              = ['*']
let s:grepformat         = '%f:%l:%m'
let s:literal_executable = 'fgrep'
let s:regexp_executable  = 'egrep'
let s:options            = ['-n', '-H', '-R']

let s:grep = copy(g:greper#class)

function! s:grep.init(command, args) dict abort "{{{
  let self.utility = 'grep'
  call call(g:greper#class.init, [a:command, a:args], self)
endfunction
"}}}

function! s:grep._get(variable) dict abort "{{{
  return s:{a:variable}
endfunction
"}}}

let g:greper#grep#class = s:grep
