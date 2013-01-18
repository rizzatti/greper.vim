function! s:add_mappings(prefix)
  nnoremap <silent> <buffer> go <CR><C-w>p<C-w>=
  nnoremap <silent> <buffer> gs <C-w>p<C-w>s<C-w>b<CR><C-w>p<C-w>=
  nnoremap <silent> <buffer> gt <C-w><CR><C-w>TgT<C-w>p
  nnoremap <silent> <buffer> gv <C-w>p<C-w>v<C-w>b<CR><C-w>p<C-w>=
  nnoremap <silent> <buffer> o <CR>
  execute "nnoremap <silent> <buffer> q :" . a:prefix . "close<CR>"
  nnoremap <silent> <buffer> s <C-w>p<C-w>s<C-w>b<CR><C-w>=
  nnoremap <silent> <buffer> t <C-w><CR><C-w>T
  nnoremap <silent> <buffer> v <C-w>p<C-w>v<C-w>b<CR><C-w>=
endfunction

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

function! s:prefix_for(command)
  if a:command =~? "^l"
    return "l"
  else
    return "c"
  endif
endfunction

function! s:window_handler_for(prefix)
  return "botright " . a:prefix . "open"
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
  let l:prefix = s:prefix_for(a:command)
  execute "call greper#" . a:utility . "#save_grep_options()"
  silent execute a:command . " " . s:command_args_for(a:000)
  silent execute s:window_handler_for(l:prefix)
  call s:add_mappings(l:prefix)
  execute "call greper#" . a:utility . "#restore_grep_options()"
  redraw!
endfunction
