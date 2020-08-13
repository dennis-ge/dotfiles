" Set compatibility to Vim only.
set nocompatible

" Theme / Syntax highlighting
set cursorline " Highlight current line
set number " Show line numbers
set showtabline=2 " Always show tab bar.
set title " Show the filename in the window titlebar.
set wrap " wrap lines.
set noshowmode " Don't show the current mode (airline.vim takes care of us)
set laststatus=2 " Always show status line

" Indentation
set autoindent " Copy indent from last line when starting new line.
set shiftwidth=2 " The # of spaces for indenting.
set smarttab " At start of line, <Tab> inserts shiftwidth spaces, <Bs> deletes shiftwidth spaces.
set softtabstop=2 " Tab key results in 2 spaces
set tabstop=2 " Tabs indent only 2 spaces
set expandtab " Expand tabs to spaces

" Scrolling
set scrolloff=3 " Start scrolling three lines before horizontal border of window.
set sidescrolloff=3 " Start scrolling three columns before vertical border of window.

" Helps force plug-ins to load correctly when it is turned back on below.
filetype off

" Turn on syntax highlighting.
syntax on

" For plug-ins to load correctly.
filetype plugin indent on

" Turn off modelines
set modelines=0


" Vim's auto indentation feature does not work properly with text copied from outside of Vim. Press the <F2> key to toggle paste mode on/off.
" nnoremap = normal mode map
nnoremap <F2> :set invpaste paste?<CR>
" imap = insert mode map
imap <F2> <C-O>:set invpaste paste?<CR> 
set pastetoggle=<F2>

" Fixes common backspace problems
set backspace=indent,eol,start

" Speed up scrolling in Vim
set ttyfast

" Display options
set showmode
set showcmd

" Highlight matching pairs of brackets. Use the '%' character to jump between them.
set matchpairs+=<:>

" Display different types of white spaces.
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.

" Vim commands
set hidden " When a buffer is brought to foreground, remember undo history and marks.
set report=0 " Show all changes.
set mouse=a " Enable mouse in all modes.
set ttymouse=xterm2 " Ensure mouse works inside tmux
set shortmess+=I " Hide intro menu.

" Set status line display
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ [BUFFER=%n]\ %{strftime('%c')}

" Encoding
set encoding=utf-8

" Highlight matching search patterns
set hlsearch
" Enable incremental search
set incsearch
" Include matching uppercase words with lowercase search term
set ignorecase
" Include only uppercase words with uppercase search term
set smartcase

" Store info from no more than 100 files at a time, 9999 lines of text, 100kb of data. Useful for copying large amounts of data between files.
set viminfo='100,<9999,s100

" Map the <Space> key to toggle a selected fold opened/closed.
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

" Automatically save and load folds
"autocmd!
"au BufWinLeave ?* mkview 1
"au BufWinEnter ?* silent loadview 1

" https://github.com/junegunn/vim-plug
" Reload .vimrc and :PlugInstall to install plugins.
call plug#begin('~/.vim/plugged')
  Plug 'scrooloose/nerdtree'
  Plug 'valloric/youcompleteme'
call plug#end()

" Map :NERDTreeToggle to Ctrl + m
map <C-m> :NERDTreeToggle<CR>
