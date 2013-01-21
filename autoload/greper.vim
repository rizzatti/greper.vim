function! s:new(object, ...) abort
  let instance = copy(a:object)
  call call(instance.init, a:000, instance)
  return instance
endfunction

let s:greper = {}
function! s:greper.init(ex, utility, args) dict abort
  let self.ex = a:ex
  let self.utility = a:utility
  let self.args = self._parse(a:args)
endfunction

function! s:greper.execute() dict abort
  call self._save_options()
  silent execute join([self.ex, self.args], ' ')
  call self._restore_options()
endfunction

function! s:greper._escape(pattern) dict abort
  let matches = matchlist(a:pattern, '^\/\(.*\)\/$')
  if len(matches) == 0
    let pattern = escape(a:pattern, self._get('chars'))
  else
    let pattern = matches[1]
  endif
  return shellescape(pattern, 1)
endfunction

function! s:greper._get(variable) dict abort
  let variable = 'g:greper#' . self.utility . '#' . a:variable
  return eval(variable)
endfunction

function! s:greper._parse(args) dict abort
  let size = len(a:args)
  if size == 0
    let pattern = self._escape(expand('<cword>'))
  else
    let pattern = self._escape(a:args[0])
  endif
  if size >= 2
    let files = a:args[1:]
  else
    let files = ['*']
  endif
  return join([pattern] + files, ' ')
endfunction

function! s:greper._restore_options() dict abort
  let &grepprg    = self._save.grepprg
  let &grepformat = self._save.grepformat
endfunction

function! s:greper._save_options() dict abort
  let self._save = {}
  let self._save.grepprg    = &grepprg
  let self._save.grepformat = &grepformat
  let &grepprg              = self._get('grepprg')
  let &grepformat           = self._get('grepformat')
endfunction

let s:window = {}
function! s:window.init(ex) dict abort
  if a:ex =~? '^l'
    let self.prefix = 'l'
  else
    let self.prefix = 'c'
  endif
endfunction

function! s:window.setup() dict abort
  call self._open()
  call self._add_mappings()
endfunction

function! s:window._add_mappings() dict abort
  noremap <silent> <buffer> go <CR><C-w>p<C-w>=
  noremap <silent> <buffer> gs <C-w>p<C-w>s<C-w>b<CR><C-w>p<C-w>=
  noremap <silent> <buffer> gt <C-w><CR><C-w>TgT<C-w>p
  noremap <silent> <buffer> gv <C-w>p<C-w>v<C-w>b<CR><C-w>p<C-w>=
  noremap <silent> <buffer> o <CR>
  execute 'noremap <silent> <buffer> q :' . self.prefix . 'close<CR>'
  noremap <silent> <buffer> s <C-w>p<C-w>s<C-w>b<CR><C-w>=
  noremap <silent> <buffer> t <C-w><CR><C-w>T
  noremap <silent> <buffer> v <C-w>p<C-w>v<C-w>b<CR><C-w>=
endfunction

function! s:window._open() dict abort
  let command = 'botright ' . self.prefix . 'open'
  silent execute command
endfunction

function! greper#Run(ex, utility, ...) abort
  redraw
  let greper = s:new(s:greper, a:ex, a:utility, a:000)
  let window = s:new(s:window, a:utility)
  call greper.execute()
  call window.setup()
  redraw!
endfunction
