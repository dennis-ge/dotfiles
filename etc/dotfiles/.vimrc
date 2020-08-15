set nocompatible " Set compatibility to Vim only

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
" set display+=lastline "Always try to show a paragraph’s last line
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
set wildmenu " Display command line’s tab complete options as a menu
set cursorline " Highlight the line currently under cursor
set number " Show line numbers on the sidebar
set showtabline=2 " Always show tab bar
set noerrorbells " Disable beep on errors
set mouse=a " Enable mouse in all modes
set ttymouse=xterm2 " Ensure mouse works inside tmux
set title " Show the filename in the window titlebar
set background=dark " Use colors that suit a dark background
set matchpairs+=<:> " Highlight matching pairs of brackets. Use the '%' character to jump between them
set showmode "If in Insert, Replace or Visual mode put a message on the last line
set showcmd " Show command in the last line of the screen

set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ [BUFFER=%n]\ %{strftime('%c')} " Set status line display

" -------------------------------------------------------------------------- "
" Key Mappings                                                               "
" -------------------------------------------------------------------------- "
" Vim's auto indentation feature does not work properly with text copied from outside of Vim. Press the <F2> key to toggle paste mode on/off.
nnoremap <F2> :set invpaste paste?<CR> " nnoremap = normal mode map
imap <F2> <C-O>:set invpaste paste?<CR> " imap = insert mode map
set pastetoggle=<F2>

" Map the <Space> key to toggle a selected fold opened/closed.
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

" -------------------------------------------------------------------------- "
" Miscellaneous                                                              "
" -------------------------------------------------------------------------- "
set autoread " Automatically re-read files if unmodified inside Vim
set backspace=indent,eol,start " Allow backspacing over indention, line breaks and insertion start
set hidden " Hide files in the background instead of closing them
set history=1000 " Increase the undo limit
set nomodeline " Ignore file’s mode lines; use vimrc configurations instead
set wildignore+=.pyc,.swp " Ignore files matching these patterns when opening files based on a glob pattern
set report=0 " Show all changes
set shortmess+=I " Hide intro menu
set viminfo='100,<9999,s100 " Store info from no more than 100 files at a time, 9999 lines of text, 100kb of data

" Display different types of white spaces.
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.

" -------------------------------------------------------------------------- "
" Plugins                                                                    "
" -------------------------------------------------------------------------- "

" https://github.com/junegunn/vim-plug
" Reload .vimrc and :PlugInstall to install plugins.
call plug#begin('~/.vim/plugged')
  Plug 'scrooloose/nerdtree'
  Plug 'valloric/youcompleteme'
call plug#end()

map <C-m> :NERDTreeToggle<CR> " Map :NERDTreeToggle to Ctrl + m
