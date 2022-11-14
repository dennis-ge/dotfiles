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
" set display+=lastline "Always try to show a paragraph's last line
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
call plug#begin('~/.vim/plugged')
  Plug 'scrooloose/nerdtree'
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
call plug#end()

:nnoremap <C-g> :NERDTreeToggle<CR> " Map :NERDTreeToggle to Ctrl + g

" Also run `goimports` on your current file on every save
" Might be be slow on large codebases, if so, just comment it out
let g:go_fmt_command = "goimports"
let g:go_auto_type_info = 1 " Status line types/signatures
au filetype go inoremap <buffer> <C-a> <C-x><C-o>

" run :GoBuild or :GoTestCompile based on the go file: see vim-go-tutorial
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)

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
