if exists("g:loaded_greper")
  finish
endif
let g:loaded_greper = 1

function! s:create_command(name, command, ...)
  if a:0 ==? 1
    let l:utility = a:000[0]
    let l:parens = "('" . l:utility . "', '" . a:command . "<bang>', <f-args>)"
    let l:suffix = "_for"
  else
    let l:parens = "('" . a:command . "<bang>', <f-args>)"
    let l:suffix = ""
  endif

  let l:definition = "command! -bang -nargs=* -complete=file " . a:name
  let l:call = "call greper#greper" . l:suffix . l:parens
  execute l:definition . " " . l:call
endfunction

let s:found = 0

if executable("grep")
  let s:found = 1
  call s:create_command("Grep", "grep", "grep")
  call s:create_command("GrepAdd", "grepadd", "grep")
  call s:create_command("LGrep", "lgrep", "grep")
  call s:create_command("LGrepAdd", "lgrepadd", "grep")
endif

if executable("ag")
  let s:found = 1
  call s:create_command("Ag", "grep", "ag")
  call s:create_command("AgAdd", "grepadd", "ag")
  call s:create_command("LAg", "lgrep", "ag")
  call s:create_command("LAgAdd", "lgrepadd", "ag")
endif

if executable("ack")
  let s:found = 1
  call s:create_command("Ack", "grep", "ack")
  call s:create_command("AckAdd", "grepadd", "ack")
  call s:create_command("LAck", "lgrep", "ack")
  call s:create_command("LAckAdd", "lgrepadd", "ack")
endif

if s:found
  call s:create_command("G", "grep")
  call s:create_command("GAdd", "grepadd")
  call s:create_command("LG", "lgrep")
  call s:create_command("LGAdd", "lgrepadd")
endif
