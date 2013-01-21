if exists("g:loaded_greper")
  finish
endif
let g:loaded_greper = 1

let s:save_cpoptions = &cpoptions
set cpoptions&vim

function! s:CreateCommand(command, ex, utility) abort
  if exists(':' . a:command) == 2
    echoerr 'greper.vim: could not create :' . a:command
    return
  endif
  let definition = 'command -bang -nargs=* -complete=file ' . a:command
  let parens = '("' . a:ex . '<bang>", "' . a:utility . '", <f-args>)'
  let callee = ' call greper#Run' . parens
  execute definition . callee
endfunction

if executable('ag')
  if !exists('g:greper_utility')
    let g:greper_utility = 'ag'
  endif
  call s:CreateCommand('Ag', 'grep', 'ag')
  call s:CreateCommand('AgAdd', 'grepadd', 'ag')
  call s:CreateCommand('LAg', 'lgrep', 'ag')
  call s:CreateCommand('LAgAdd', 'lgrepadd', 'ag')
endif

if executable('ack')
  if !exists('g:greper_utility')
    let g:greper_utility = 'ack'
  endif
  call s:CreateCommand('Ack', 'grep', 'ack')
  call s:CreateCommand('AckAdd', 'grepadd', 'ack')
  call s:CreateCommand('LAck', 'lgrep', 'ack')
  call s:CreateCommand('LAckAdd', 'lgrepadd', 'ack')
endif

if executable('grep')
  if !exists('g:greper_utility')
    let g:greper_utility = 'grep'
  endif
  call s:CreateCommand('Grep', 'grep', 'grep')
  call s:CreateCommand('GrepAdd', 'grepadd', 'grep')
  call s:CreateCommand('LGrep', 'lgrep', 'grep')
  call s:CreateCommand('LGrepAdd', 'lgrepadd', 'grep')
endif

if exists('g:greper_utility')
  call s:CreateCommand('G', 'grep', g:greper_utility)
  call s:CreateCommand('GAdd', 'grepadd', g:greper_utility)
  call s:CreateCommand('LG', 'lgrep', g:greper_utility)
  call s:CreateCommand('LGAdd', 'lgrepadd', g:greper_utility)
  noremap <script> <unique> <Plug>Greper <SID>Greper
  noremap <SID>Greper :call <SID>Greper('', '<cword>')<CR>
  noremap <script> <unique> <Plug>Greper! <SID>Greper!
  noremap <SID>Greper! :call <SID>Greper('!', '<cword>')<CR>
  noremap <script> <unique> <Plug>GreperWORD <SID>GreperWORD
  noremap <SID>GreperWORD :call <SID>Greper('', '<cWORD>')<CR>
  noremap <script> <unique> <Plug>Greper!WORD <SID>Greper!WORD
  noremap <SID>Greper!WORD :call <SID>Greper('!', '<cWORD>')<CR>
else
  echoerr 'greper.vim: could not find any suitable greper utility'
endif

function! s:Greper(bang, word)
  call greper#Run('grep' . a:bang, g:greper_utility, expand(a:word))
endfunction

let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions
