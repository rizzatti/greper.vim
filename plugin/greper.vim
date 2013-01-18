if exists("g:loaded_greper")
  finish
endif
let g:loaded_greper = 1

function! s:create_command(name, exp)
  execute "command! -bang -nargs=* -complete=file " . a:name
        \ " call greper#Greper('" . a:exp . "<bang>', <f-args>)"
endfunction

if executable("grep")
  call s:create_command("Grep", "grep")
  call s:create_command("GrepAdd", "grepadd")
  call s:create_command("LGrep", "lgrep")
  call s:create_command("LGrepAdd", "lgrepadd")
endif
