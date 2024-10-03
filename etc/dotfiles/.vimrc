set nocompatible " Set compatibility to Vim only
let mapleader = ","

" -------------------------------------------------------------------------- "
" Indentation                                                                "
" -------------------------------------------------------------------------- "
set autoindent " Copy indent from last line when starting new line
set shiftwidth=2 " The # of spaces for indenting
set smarttab " At start of line, <Tab> inserts shiftwidth spaces, <Bs> deletes shiftwidth spaces
set softtabstop=2 " Tab key results in 2 spaces
set tabstop=2 " Tabs indent only 2 spaces
set expandtab " Convert tabs to spaces

" -------------------------------------------------------------------------- "
" Search                                                                     "
" -------------------------------------------------------------------------- "
set hlsearch " Highlight matching search patterns
set incsearch " Incremental search that shows partial matches
set ignorecase " Ignore case when searching
set smartcase " Automatically switch search to case-sensitive when search query contains an uppercase letter

" -------------------------------------------------------------------------- "
" Text Rendering                                                             "
" -------------------------------------------------------------------------- "
set display+=lastline "Always try to show a paragraph's last line
set encoding=utf-8 "Use an encoding that supports unicode
set linebreak "Avoid wrapping a line in the middle of a word
set scrolloff=3 " Start scrolling three lines before horizontal border of window
set sidescrolloff=3 " Start scrolling three columns before vertical border of window
set ttyfast " Speed up scrolling in Vim
syntax on " Turn on syntax highlighting
set wrap " Enable line wrapping
set modelines=0 " Turn off modelines


" -------------------------------------------------------------------------- "
" User Interface                                                             "
" -------------------------------------------------------------------------- "
set laststatus=2 " Always display the status bar
set ruler " Always show cursor position
set wildmenu " Display command line tab complete options as a menu
set cursorline " Highlight the line currently under cursor
set cursorcolumn
set number " Show line numbers on the sidebar
set showtabline=2 " Always show tab bar
set noerrorbells " Disable beep on errors
set mouse=a " Enable mouse in all modes
set title " Show the filename in the window titlebar
set background=dark " Use colors that suit a dark background
set matchpairs+=<:> " Highlight matching pairs of brackets. Use the '%' character to jump between them
set showmode "If in Insert, Replace or Visual mode put a message on the last line
set showcmd " Show command in the last line of the screen

set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ [BUFFER=%n]\ %{strftime('%c')} " Set status line display

" -------------------------------------------------------------------------- "
" Miscellaneous                                                              "
" -------------------------------------------------------------------------- "
set autoread " Automatically re-read files if unmodified inside Vim
set backspace=indent,eol,start " Allow backspacing over indention, line breaks and insertion start
set hidden " Hide files in the background instead of closing them
set history=1000 " Increase the undo limit
set nomodeline " Ignore file's mode lines; use vimrc configurations instead
set wildignore+=.pyc,.swp " Ignore files matching these patterns when opening files based on a glob pattern
set report=0 " Show all changes
set shortmess+=I " Hide intro menu
set viminfo='100,<9999,s100 " Store info from no more than 100 files at a time, 9999 lines of text, 100kb of data

" Display different types of white spaces.
set list
set listchars=tab:>\ ,trail:•,extends:#,nbsp:.
filetype plugin indent on

" -------------------------------------------------------------------------- "
" Plugins                                                                    "
" -------------------------------------------------------------------------- "

" https://github.com/junegunn/vim-plug
" Reload .vimrc and :PlugInstall to install plugins.

let data_dir = '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
  Plug 'scrooloose/nerdtree'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
call plug#end()

:nnoremap <C-g> :NERDTreeToggle<CR> " Map :NERDTreeToggle to Ctrl + g

map <C-x> :cnext<CR>
map <C-y> :cprevious<CR>

"let g:airline_powerline_fonts = 1 " air-line plugin specific commands
let g:airline_theme='papercolor'

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
