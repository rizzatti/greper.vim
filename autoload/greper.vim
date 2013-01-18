let s:greper_grepprg = "grep -nHR"
let s:greper_grepformat = "%f:%l:%m"

function! s:ArgsFor(args)
  let l:size = len(a:args)
  if l:size ==? 0
    let l:pattern = expand("<cword>")
  else
    let l:pattern = a:args[0]
  endif
  if l:size >=? 2
    let l:files = join(a:args[1:], " ")
  else
    let l:files = "*"
  endif
  return l:pattern . " " . l:files
endfunction

function! s:RestoreGrepOptions()
  let &grepprg    = s:grepprg
  let &grepformat = s:grepformat
endfunction

function! s:SaveGrepOptions()
  let s:grepprg    = &grepprg
  let s:grepformat = &grepformat
  let &grepprg     = s:greper_grepprg
  let &grepformat  = s:greper_grepformat
endfunction

function! s:WindowCommandFor(command)
  if a:command =~? "^l"
    let l:prefix = "l"
  else
    let l:prefix = "c"
  endif
  return "botright " . l:prefix . "open"
endfunction

function! greper#Greper(command, ...)
  call s:SaveGrepOptions()
  let l:args = s:ArgsFor(a:000)
  let l:window_command = s:WindowCommandFor(a:command)
  silent execute a:command . " " . l:args
  silent execute l:window_command
  call s:RestoreGrepOptions()
endfunction
