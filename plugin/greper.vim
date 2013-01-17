if exists("g:loaded_greper")
  finish
endif
let g:loaded_greper = 1

if executable("grep")
  let g:grepprg = "grep -nHR"
  let g:grepformat = "%f:%l:%m"
else
  finish
endif

command! -bang -nargs=* -complete=file Grep call greper#Greper("grep<bang>", <f-args>)
command! -bang -nargs=* -complete=file GrepAdd call greper#Greper("grepadd<bang>", <f-args>)
command! -bang -nargs=* -complete=file LGrep call greper#Greper("lgrep<bang>", <f-args>)
command! -bang -nargs=* -complete=file LGrepAdd call greper#Greper("lgrepadd<bang>", <f-args>)
