call pathogen#incubate()

" Some Linux distributions set filetype in /etc/vimrc.
"   " Clear filetype flags before changing runtimepath to force Vim to reload
"   them.
filetype off
filetype plugin indent off
set runtimepath+=$GOROOT/misc/vim
filetype plugin indent on

syntax on
set nu " Default to line numbers on
set incsearch   " Set incremental search on

set background=dark
colorscheme solarized

" Write with Sudo
cmap w!! w !sudo tee > /dev/null %

" NERDTree
autocmd vimenter * if !argc() | NERDTree | endif
map <C-n> :NERDTreeToggle<CR>

" Go Lang
""" au BufWritePost *.go silent! !ctags -R &

" SuperTab
let g:SuperTabDefaultCompletionType = "context"

" Markdown
au BufRead,BufNewFile *.md set filetype=markdown
