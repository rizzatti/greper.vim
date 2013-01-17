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

function! s:Grep(bang, ...)
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
  let l:grepprg    = &grepprg
  let l:grepformat = &grepformat
  let &grepprg     = s:grepprg
  let &grepformat  = s:grepformat
  silent execute "grep" . a:bang . " " . l:pattern . " " . l:files
  botright copen
  wincmd p
  let &grepprg    = l:grepprg
  let &grepformat = l:grepformat
endfunction

command! -bang -nargs=* -complete=file Grep call s:Grep("<bang>", <f-args>)
