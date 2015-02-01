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
Bundle 'rizzatti/funcoo.vim'
Bundle 'rizzatti/greper.vim'
```

And run `:BundleInstall` inside Vim.

### Using [pathogen.vim][pathogen]:

Copy and paste in your shell:

```bash
cd ~/.vim/bundle
git clone https://github.com/rizzatti/funcoo.vim.git
git clone https://github.com/rizzatti/greper.vim.git
```

## License

MIT

[ack]: http://beyondgrep.com/
[ag]: https://github.com/ggreer/the_silver_searcher
[grep]: https://www.gnu.org/software/grep/
[pathogen]: https://github.com/tpope/vim-pathogen
[vim-doc]: https://vim-doc.herokuapp.com/view?https://raw.githubusercontent.com/rizzatti/greper.vim/master/doc/greper.txt
[vundle]: https://github.com/gmarik/vundle
