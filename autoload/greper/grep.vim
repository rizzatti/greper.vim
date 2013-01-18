let s:grepprg = "grep -nHR"
let s:grepformat = "%f:%l:%m"

function! greper#grep#restore_grep_options()
  let &grepprg    = s:oldprg
  let &grepformat = s:oldformat
endfunction

function! greper#grep#save_grep_options()
  let s:oldprg    = &grepprg
  let s:oldformat = &grepformat
  let &grepprg    = s:grepprg
  let &grepformat = s:grepformat
endfunction
