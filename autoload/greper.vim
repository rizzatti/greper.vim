function! s:New(class, ...) abort
  let instance = copy(a:class)
  call call(instance.Init, a:000, instance)
  return instance
endfunction

let s:Greper = {}
function! s:Greper.Init(ex, utility, args) dict abort
  let self.ex      = a:ex
  let self.utility = a:utility
  let self.args    = self._Parse(a:args)
endfunction

function! s:Greper.Execute() dict abort
  call self._SaveOptions()
  silent execute join([self.ex, self.args], ' ')
  call self._RestoreOptions()
endfunction

function! s:Greper._Escape(pattern) dict abort
  let matches = matchlist(a:pattern, '^\/\(.*\)\/$')
  if len(matches) == 0
    let pattern = escape(a:pattern, self._Get('chars'))
  else
    let pattern = matches[1]
  endif
  return shellescape(pattern, 1)
endfunction

function! s:Greper._Get(variable) dict abort
  return g:greper#{self.utility}#{a:variable}
endfunction

function! s:Greper._Parse(args) dict abort
  let size    = len(a:args)
  let pattern = self._Escape(size == 0 ? expand('<cword>') : a:args[0])
  let files   = size >= 2 ? a:args[1:] : ['*']
  return join([pattern] + files, ' ')
endfunction

function! s:Greper._RestoreOptions() dict abort
  let &grepprg    = self._save.grepprg
  let &grepformat = self._save.grepformat
endfunction

function! s:Greper._SaveOptions() dict abort
  let self._save = {}
  let self._save.grepprg    = &grepprg
  let self._save.grepformat = &grepformat
  let &grepprg              = self._Get('grepprg')
  let &grepformat           = self._Get('grepformat')
endfunction

let s:Window = {}
function! s:Window.Init(ex) dict abort
  let self.prefix = a:ex =~? '^l' ? 'l' : 'c'
endfunction

function! s:Window.Setup() dict abort
  call self._Open()
  call self._AddMappings()
endfunction

function! s:Window._AddMappings() dict abort
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

function! s:Window._Open() dict abort
  let command = 'botright ' . self.prefix . 'open'
  silent execute command
endfunction

function! greper#Run(ex, utility, ...) abort
  redraw
  let greper = s:New(s:Greper, a:ex, a:utility, a:000)
  let window = s:New(s:Window, a:utility)
  call greper.Execute()
  call window.Setup()
  redraw!
endfunction
