let s:ackprg = "ack -H --nocolor --nogroup --column"
let s:ackformat = "%f:%l:%c:%m"

function! greper#ack#restore_grep_options()
  let &grepprg    = s:oldprg
  let &grepformat = s:oldformat
endfunction

function! greper#ack#save_grep_options()
  let s:oldprg    = &grepprg
  let s:oldformat = &grepformat
  let &grepprg    = s:ackprg
  let &grepformat = s:ackformat
endfunction
