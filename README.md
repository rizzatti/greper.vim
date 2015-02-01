# greper.vim

This vim plugin improves *searching*, for words and with regular
expressions, using a simple syntax.

It allows using any of these tools: [ag][ag], [ack][ack] and
[grep][grep]. Whichever is avaiable, greper.vim will pick the fastest.

It provides a new set of commands, easy navigation of the search results
window and (recommended) mappings.

## Commands, Mappings and Configuration

Read the [help][vim-doc] to know more.

## Installation

### Using [Vundle][vundle]:

Just add this 2 lines to your `~/.vimrc`:

```vim
Plugin 'rizzatti/funcoo.vim'
Plugin 'rizzatti/greper.vim'
```

And run `:PluginInstall` inside Vim.

### Using [pathogen.vim][pathogen]:

Copy and paste in your shell:

```bash
cd ~/.vim/bundle
git clone https://github.com/rizzatti/funcoo.vim.git
git clone https://github.com/rizzatti/greper.vim.git
```

### Using [vpm][vpm]:

Run this command in your shell:

```bash
vpm insert rizzatti/funcoo.vim
vpm insert rizzatti/greper.vim
```

### Using [Plug][plug]:

Just add this line to your `~/.vimrc` inside plug call:

```vim
Plug 'rizzatti/funcoo.vim'
Plug 'rizzatti/greper.vim'
```

And run `:PlugInstall` inside Vim or `vim +PlugInstall +qa` from shell.

## License

MIT

[ack]: http://beyondgrep.com/
[ag]: https://github.com/ggreer/the_silver_searcher
[grep]: https://www.gnu.org/software/grep/
[pathogen]: https://github.com/tpope/vim-pathogen
[vim-doc]: https://vim-doc.herokuapp.com/view?https://raw.githubusercontent.com/rizzatti/greper.vim/master/doc/greper.txt
[vpm]: https://github.com/KevinSjoberg/vpm
[vundle]: https://github.com/gmarik/vundle
[plug]: https://github.com/junegunn/vim-plug
