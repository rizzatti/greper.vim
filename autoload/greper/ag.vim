let s:agprg = "ag --nocolor --nogroup --column"
let s:agformat = "%f:%l:%c:%m"
let s:escape_chars = '*()+|?.^$[]\{}'

function! greper#ag#escape_chars()
  return s:escape_chars
endfunction

function! greper#ag#restore_grep_options()
  let &grepprg    = s:oldprg
  let &grepformat = s:oldformat
endfunction

function! greper#ag#save_grep_options()
  let s:oldprg    = &grepprg
  let s:oldformat = &grepformat
  let &grepprg    = s:agprg
  let &grepformat = s:agformat
endfunction
