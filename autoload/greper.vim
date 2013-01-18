let s:greper_grepprg = "grep -nHR"
let s:greper_grepformat = "%f:%l:%m"

function! s:command_args_for(args)
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

function! s:restore_grep_options()
  let &grepprg    = s:grepprg
  let &grepformat = s:grepformat
endfunction

function! s:save_grep_options()
  let s:grepprg    = &grepprg
  let s:grepformat = &grepformat
  let &grepprg     = s:greper_grepprg
  let &grepformat  = s:greper_grepformat
endfunction

function! s:window_command_for(command)
  if a:command =~? "^l"
    let l:prefix = "l"
  else
    let l:prefix = "c"
  endif
  return "botright " . l:prefix . "open"
endfunction

function! greper#Greper(command, ...)
  call s:save_grep_options()
  let l:args = s:command_args_for(a:000)
  let l:window_command = s:window_command_for(a:command)
  silent execute a:command . " " . l:args
  silent execute l:window_command
  call s:restore_grep_options()
endfunction
