if exists("g:loaded_greper")
  finish
endif
let g:loaded_greper = 1

function! s:create_command(name, utility, exp)
  let l:args = "'" . a:utility . "', '" . a:exp . "<bang>', <f-args>"
  execute "command! -bang -nargs=* -complete=file " . a:name
        \ " call greper#Greper(" . l:args . ")"
endfunction

if executable("grep")
  call s:create_command("Grep", "grep", "grep")
  call s:create_command("GrepAdd", "grep", "grepadd")
  call s:create_command("LGrep", "grep", "lgrep")
  call s:create_command("LGrepAdd", "grep", "lgrepadd")
endif

if executable("ack")
  call s:create_command("Ack", "ack", "grep")
  call s:create_command("AckAdd", "ack", "grepadd")
  call s:create_command("LAck", "ack", "lgrep")
  call s:create_command("LAckAdd", "ack", "lgrepadd")
endif
