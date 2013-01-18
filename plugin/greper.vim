if exists("g:loaded_greper")
  finish
endif
let g:loaded_greper = 1

function! s:create_command(name, utility, exp)
  let l:args = "'" . a:utility . "', '" . a:exp . "<bang>', <f-args>"
  execute "command! -bang -nargs=* -complete=file " . a:name
        \ " call greper#GreperUtility(" . l:args . ")"
endfunction

let s:found = 0

if executable("grep")
  let s:found = 1
  call s:create_command("Grep", "grep", "grep")
  call s:create_command("GrepAdd", "grep", "grepadd")
  call s:create_command("LGrep", "grep", "lgrep")
  call s:create_command("LGrepAdd", "grep", "lgrepadd")
endif

if executable("ag")
  let s:found = 1
  call s:create_command("Ag", "ag", "grep")
  call s:create_command("AgAdd", "ag", "grepadd")
  call s:create_command("LAg", "ag", "lgrep")
  call s:create_command("LAgAdd", "ag", "lgrepadd")
endif

if executable("ack")
  let s:found = 1
  call s:create_command("Ack", "ack", "grep")
  call s:create_command("AckAdd", "ack", "grepadd")
  call s:create_command("LAck", "ack", "lgrep")
  call s:create_command("LAckAdd", "ack", "lgrepadd")
endif

if s:found
  command! -bang -nargs=* -complete=file G
        \ call greper#Greper("<bang>", <f-args>)
endif
