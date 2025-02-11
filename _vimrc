" Cross-platform Vim Configuration goes in this file
"
" Contents
" Main configuration
" Visual Configuration
" Shortcut Key Configuration
" Plugin Configuration
" Private Configuration

" ----------- Vundle Configuration ----------------------------------
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'altercation/vim-colors-solarized'
Plugin 'airblade/vim-gitgutter'
Plugin 'ntpeters/vim-better-whitespace'

" All of your Plugins must be added before the following line
call vundle#end()            " required

" ----------- Main Configuration ----------------------------------
au BufRead,BufNewFile *.md set filetype=markdown

set nocompatible                         "don't need to keep compatibility with Vi
filetype plugin indent on                "enable detection, plugins and indenting in one step
syntax on                                "Turn on syntax highlighting
set synmaxcol=256                        " Syntax coloring lines that are too long just slows down the world

set lazyredraw                           " to avoid scrolling problems
set ruler                                "Turn on the ruler
set number                               "Show line numbers
set cursorline                           "underline the current line in the file
set cursorcolumn                         "highlight the current column. Visible in GUI mode only.
set colorcolumn=80

set background=dark                      "make vim use colors that look good on a dark background
"set background=light                      "make vim use colors that look good on a light background

set showcmd                              "show incomplete cmds down the bottom
set showmode                             "show current mode down the bottom
set foldenable                           "enable folding
set showmatch                            "set show matching parenthesis
set noexrc                               "don't use the local config
"set virtualedit=all                      "allow the cursor to go in to "invalid" places
"
set incsearch                            "find the next match as we type the search
set hlsearch                             "hilight searches by default
set ignorecase                           "ignore case when searching

set shiftwidth=2                         "number of spaces to use in each autoindent step
set tabstop=2                            "two tab spaces
set softtabstop=2                        "number of spaces to skip or insert when <BS>ing or <Tab>ing
set expandtab                            "spaces instead of tabs for better cross-editor compatibility
set smarttab                             "use shiftwidth and softtabstop to insert or delete (on <BS>) blanks
set shiftround                           "when at 3 spaces, and I hit > ... go to 4, not 5
set nowrap                               "no wrapping

set backspace=indent,eol,start           "allow backspacing over everything in insert mode
set cindent                              "recommended seting for automatic C-style indentation
set autoindent                           "automatic indentation in non-C files
set copyindent                           "copy the previous indentation on autoindenting

set noerrorbells                         "don't make noise
set wildmenu                             "make tab completion act more like bash
set wildmode=list:longest                "tab complete to longest common string, like bash

set mouse-=a                             "disable mouse automatically entering visual mode
"set mouse=a                              "enable mouse automatically entering visual mode
set hidden                               "allow hiding buffers with unsaved changes
set cmdheight=2                          "make the command line a little taller to hide 'press enter to viem more' text

set clipboard=unnamed                    "Use system clipboard by default
set viminfo='20,<1000,s1000              "Keep up to 1000 lines or 1000KB in copy buffer

" Set up the backup directories to a central place.
set backupdir=$HOME/tmp/vim-backup/
set directory=$HOME/tmp/vim-backup/

" ----------- Visual Configuration ----------------------------------
" colorscheme mycontrast
colorscheme solarized

set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]
"              | | | | |  |   |      |  |     |    |
"              | | | | |  |   |      |  |     |    + current
"              | | | | |  |   |      |  |     |       column
"              | | | | |  |   |      |  |     +-- current line
"              | | | | |  |   |      |  +-- current % into file
"              | | | | |  |   |      +-- current syntax in
"              | | | | |  |   |          square brackets
"              | | | | |  |   +-- current fileformat
"              | | | | |  +-- number of lines
"              | | | | +-- preview flag in square brackets
"              | | | +-- help flag in square brackets
"              | | +-- readonly flag in square brackets
"              | +-- rodified flag in square brackets
"              +-- full path to file in the buffer

" Use a bar-shaped cursor for insert mode, even through tmux.
if has("gui_running")
  if exists('$TMUX')
      let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
      let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
  else
      let &t_SI = "\<Esc>]50;CursorShape=1\x7"
      let &t_EI = "\<Esc>]50;CursorShape=0\x7"
  endif
endif

au FileType python setl ts=4 sw=4 sts=4 et
au FileType xml setl wrap linebreak
au FileType markdown set tw=79
let NERDTreeIgnore = ['\.pyc$']

" ----------- Shortcut Key Configuration ----------------------------------
let mapleader = ","                      "remap leader to ',' which is much easier than '\'

"Switch to previous file with ',,'
nmap <leader><leader> <C-^>

" Exit insert mode with ii
imap ii <Esc>

" reload current file
map <Leader>r :so %<CR>

" Exit insert mode and save with jj
imap jj <Esc>:w<CR>

" Supports pasting in from the clipboard
set pastetoggle=<F2>

" Write with Sudo
cmap w!! w !sudo tee > /dev/null %

" Pretty Print JSON in files
map jpp :%!python -m json.tool<CR>

" Search current keyword in Dash
nmap <silent> <leader>d <Plug>DashSearch

" ----------- Launch configs ---------------------------------------
autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown

autocmd FileType ruby nmap <Leader>g :!ruby "%"<cr>
autocmd FileType go  nmap <Leader>g :!go run "%"<cr>

if has('win32') || has ('win64')
  autocmd FileType html  nmap <Leader>g :silent ! start firefox "%"<cr>
elseif has('mac')
  autocmd FileType html  nmap <Leader>g :!open "%"<cr>
endif

autocmd FileType js  nmap <Leader>g :!node "%"<cr>
autocmd FileType markdown nmap <leader>g :silent !open -a Marked\ 2.app '%:p'<cr>
autocmd FileType coffee  nmap <Leader>g :coffee "%"<cr>
autocmd FileType groovy  nmap <Leader>g :!groovy "%"<cr>

" NERDTree
autocmd vimenter * if !argc() | NERDTree | endif
map <C-n> :NERDTreeToggle<CR>

" --- Support auto-pastemode even in tmux ---
function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif

  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"

  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
