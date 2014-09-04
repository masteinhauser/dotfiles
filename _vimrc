execute pathogen#infect()

" Cross-platform Vim Configuration goes in this file
"
" Contents
" Main configuration
" Visual Configuration
" Shortcut Key Configuration
" Plugin Configuration
" Private Configuration

" ----------- Main Configuration ----------------------------------

set nocompatible                         "don't need to keep compatibility with Vi
filetype plugin indent on                "enable detection, plugins and indenting in one step
syntax on                                "Turn on syntax highlighting
set ruler                                "Turn on the ruler
set number                               "Show line numbers
set cursorline                           "underline the current line in the file
set cursorcolumn                         "highlight the current column. Visible in GUI mode only.
set colorcolumn=80

set background=dark                      "make vim use colors that look good on a dark background

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

au FileType python setl sw=4 sts=4 et

set backspace=indent,eol,start           "allow backspacing over everything in insert mode
set cindent                              "recommended seting for automatic C-style indentation
set autoindent                           "automatic indentation in non-C files
set copyindent                           "copy the previous indentation on autoindenting

set noerrorbells                         "don't make noise
set wildmenu                             "make tab completion act more like bash
set wildmode=list:longest                "tab complete to longest common string, like bash

"set mouse-=a                             "disable mouse automatically entering visual mode
set mouse=a                              "enable mouse automatically entering visual mode
set hidden                               "allow hiding buffers with unsaved changes
set cmdheight=2                          "make the command line a little taller to hide 'press enter to viem more' text

set clipboard=unnamed                    "Use system clipboard by default

" Set up the backup directories to a central place.
set backupdir=$HOME/tmp/backup//
set directory=$HOME/tmp/backup//

" Autoremove trailing whitespace
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

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
autocmd FileType ruby nmap <Leader>g :!ruby "%"<cr>
autocmd FileType go  nmap <Leader>g :!go run "%"<cr>

if has('win32') || has ('win64')
  autocmd FileType html  nmap <Leader>g :silent ! start firefox "%"<cr>
elseif has('mac')
  autocmd FileType html  nmap <Leader>g :!open "%"<cr>
endif

autocmd FileType js  nmap <Leader>g :!node "%"<cr>
autocmd FileType markdown nmap <leader>g :silent !open -a Marked.app '%:p'<cr>:redraw!<cr>
autocmd FileType coffee  nmap <Leader>g :coffee "%"<cr>
autocmd FileType groovy  nmap <Leader>g :!groovy "%"<cr>

" NERDTree
autocmd vimenter * if !argc() | NERDTree | endif
map <C-n> :NERDTreeToggle<CR>

