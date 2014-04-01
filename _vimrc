call pathogen#incubate()

" Some Linux distributions set filetype in /etc/vimrc.
"   " Clear filetype flags before changing runtimepath to force Vim to reload
"   them.
filetype off
filetype plugin indent off
set runtimepath+=$GOROOT/misc/vim
filetype plugin indent on
filetype indent plugin on

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

autocmd Filetype dot setlocal ts=2 sts=2 sw=2
autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
autocmd Filetype ruby setlocal expandtab ts=2 sts=2 sw=2

" Pretty Print JSON in files
map jpp :%!python -m json.tool<CR>
