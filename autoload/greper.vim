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

function! s:args_for(args, chars)
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
  let l:pattern = s:escape(l:pattern, a:chars)

  return l:pattern . " " . l:files
endfunction

function! s:escape(pattern, chars)
  return shellescape(escape(a:pattern, a:chars), 1)
endfunction

function! s:escape_chars_for(utility)
  return call("greper#" . a:utility . "#escape_chars", [])
endfunction

function! s:execute(command, args, utility)
  let l:args = s:args_for(a:args, s:escape_chars_for(a:utility))
  silent execute a:command . " " . l:args
endfunction

function! s:prefix_for(command)
  if a:command =~? "^l"
    return "l"
  else
    return "c"
  endif
endfunction

function! s:restore_options(utility)
  call call("greper#" . a:utility . "#restore_grep_options", [])
endfunction

function! s:save_options(utility)
  call call("greper#" . a:utility . "#save_grep_options", [])
endfunction

function! s:setup_window_for(command)
  let l:prefix = s:prefix_for(a:command)
  silent execute s:window_handler_for(l:prefix)
  call s:add_mappings(l:prefix)
endfunction

function! s:window_handler_for(prefix)
  return "botright " . a:prefix . "open"
endfunction

function! greper#greper(command, ...)
  if exists(":Ag")
    let l:utility = "ag"
  elseif exists(":Ack")
    let l:utility = "ack"
  elseif exists(":Grep")
    let l:utility = "grep"
  else
    return
  endif

  call call("greper#greper_for", [l:utility, a:command] + a:000)
endfunction

function! greper#greper_for(utility, command, ...)
  redraw
  call s:save_options(a:utility)
  call s:execute(a:command, a:000, a:utility)
  call s:setup_window_for(a:command)
  call s:restore_options(a:utility)
  redraw!
endfunction
