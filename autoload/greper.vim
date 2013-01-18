function! s:command_args_for(args)
  if len(a:args) ==? 1 && type(a:args[0]) ==? type([])
    let l:args = a:args[0]
  else
    let l:args = a:args
  endif

  let l:size = len(l:args)
  if l:size ==? 0
    let l:pattern = expand("<cword>")
  else
    let l:pattern = l:args[0]
  endif
  if l:size >=? 2
    let l:files = join(l:args[1:], " ")
  else
    let l:files = "*"
  endif

  return l:pattern . " " . l:files
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
  if exists(":Ag")
    let l:utility = "ag"
  elseif exists(":Ack")
    let l:utility = "ack"
  elseif exists(":Grep")
    let l:utility = "grep"
  else
    return
  endif

  call greper#GreperUtility(l:utility, a:command, a:000)
endfunction

function! greper#GreperUtility(utility, command, ...)
  redraw
  execute "call greper#" . a:utility . "#save_grep_options()"
  let l:args = s:command_args_for(a:000)
  let l:window_command = s:window_command_for(a:command)
  silent execute a:command . " " . l:args
  silent execute l:window_command
  execute "call greper#" . a:utility . "#restore_grep_options()"
  redraw!
endfunction
