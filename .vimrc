set ttymouse=xterm2 "Allow mouse to drag splits
set mouse=a
set t_Co=256
syntax on

filetype plugin on

set dir=~/tmp/vim//
set bdir=~/tmp/vim//
set undodir=~/tmp/vim//

"function MyChecktime(timer)
"    checktime
"endfunction

"try to reload file every one second if the file changes
"let g:timer = timer_start(1000, 'MyChecktime', {'repeat': -1})
set autoread

"highlight tabs and trailing whitespcae, put $ for extending offscreen
set list
set listchars=tab:>.,trail:.,extends:$,nbsp:.

set nowrap                      "don't wrap lines
set expandtab
set smarttab                    "insert tabs on the start of a line according shiftwidth, not tabstop
set tabstop=4                   "a hard tab is 4 spaces
set shiftwidth=4                "number of spaces for auto-indenting
set softtabstop=4               "indent w/ TAB key is 4 spaces
set backspace=indent,eol,start  "allow backspacing over everything in insert mode
set autoindent
set copyindent                  "copy previous indentation on autoindenting
set smartindent
set relativenumber
set number
set numberwidth=2
set hlsearch
set incsearch                   "show search matches as you type
set noignorecase                "don't ignore case when searching
set showmatch                   "show matching paranthesis
set undofile                    "so you undo files past file close
set nostartofline               "prevent the cursor from changing the current column when jumping to other lines
set noautoread
set noequalalways               "prevent auto resize of windows on split and close
set visualbell
set noerrorbells
set history=1000
set undolevels=1000
set colorcolumn=81
set cursorcolumn
set cursorline

colorscheme gruvbox
set background=dark

"insert new line in normal mode
nnoremap <CR> o<Esc>k

"switching buffers
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

let mapleader=","
set runtimepath^=~/.vim/bundle/command-t

"edit/reload vimrc
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'christoomey/vim-tmux-navigator'
call plug#end()

