if exists("g:loaded_greper")
  finish
endif
let g:loaded_greper = 1

function! s:CreateCommand(name, exp)
  execute "command! -bang -nargs=* -complete=file " . a:name
        \ " call greper#Greper('" . a:exp . "<bang>', <f-args>)"
endfunction

if executable("grep")
  call s:CreateCommand("Grep", "grep")
  call s:CreateCommand("GrepAdd", "grepadd")
  call s:CreateCommand("LGrep", "lgrep")
  call s:CreateCommand("LGrepAdd", "lgrepadd")
endif
