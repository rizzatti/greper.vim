# greper.vim

This vim plugin improves *searching*, for words and with regular
expressions, using a simple syntax.

It allows using any of these tools: [ag][ag], [ack][ack] and
[grep][grep]. Whichever is avaiable, greper.vim will pick the fastest.

It provides a new set of commands, easy navigation of the search results
window and (recommended) mappings.

Read the [help][vim-doc] to know more.

## Installation

If you don't have a preferred installation method, I recommend
installing [pathogen.vim][pathogen], and then simply copy and paste:

```bash
cd ~/.vim/bundle
git clone https://github.com/rizzatti/funcoo.vim.git
git clone https://github.com/rizzatti/greper.vim.git
```

## License

MIT

[ack]: http://betterthangrep.com/
[ag]: https://github.com/ggreer/the_silver_searcher
[grep]: http://www.gnu.org/software/grep/
[pathogen]: https://github.com/tpope/vim-pathogen
[vim-doc]: http://vim-doc.heroku.com/view?https://raw.github.com/rizzatti/greper.vim/master/doc/greper.txt
