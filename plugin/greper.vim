if exists("g:loaded_greper")
  finish
endif
let g:loaded_greper = 1

if executable("grep")
  let s:grepprg = "grep -nHR"
  let s:grepformat = "%f:%l:%m"
else
  finish
endif

function! s:Grep(command, bang, ...)
  if a:0 ==? 0
    let l:pattern = expand("<cword>")
  else
    let l:pattern = a:000[0]
  endif
  if a:0 >=? 2
    let l:files = join(a:000[1:], " ")
  else
    let l:files = "*"
  endif
  if a:command =~? "^l"
    let l:prefix = "l"
  else
    let l:prefix = "c"
  endif
  let l:grepprg    = &grepprg
  let l:grepformat = &grepformat
  let &grepprg     = s:grepprg
  let &grepformat  = s:grepformat
  silent execute a:command . a:bang . " " . l:pattern . " " . l:files
  execute "botright " . l:prefix . "open"
  wincmd p
  let &grepprg    = l:grepprg
  let &grepformat = l:grepformat
endfunction

command! -bang -nargs=* -complete=file Grep call s:Grep("grep", "<bang>", <f-args>)
command! -bang -nargs=* -complete=file GrepAdd call s:Grep("grepadd", "<bang>", <f-args>)
command! -bang -nargs=* -complete=file LGrep call s:Grep("lgrep", "<bang>", <f-args>)
command! -bang -nargs=* -complete=file LGrepAdd call s:Grep("lgrepadd", "<bang>", <f-args>)
