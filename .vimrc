if !has("nvim")
    set ttymouse=xterm2 " Allow mouse to drag splits
    set t_Co=256
endif

set mouse=a
syntax on

filetype plugin on

set path=$PWD/**

set dir=~/tmp/vim//
set bdir=~/tmp/vim//
set undodir=~/tmp/vim//

"function MyChecktime(timer)
"    checktime
"endfunction

"try to reload file every one second if the file changes
"let g:timer = timer_start(1000, 'MyChecktime', {'repeat': -1})

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
set norelativenumber
set number
set numberwidth=2
set hlsearch
set incsearch                   "show search matches as you type
set ignorecase
set smartcase                   "case sensitive if search contains uppercase character
set showmatch                   "show matching paranthesis
set nostartofline               "prevent the cursor from changing the current column when jumping to other lines
set autoread
set noequalalways               "prevent auto resize of windows on split and close
set history=1000
set colorcolumn=81
set cursorcolumn
set cursorline

"No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

colorscheme gruvbox
set background=dark

"insert new line in normal mode
nnoremap <CR> o<Esc>k

"switching buffers
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

set runtimepath^=~/.vim/bundle/command-t

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => persistent undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set undofile                " Save undos after file closes
set undodir=$HOME/.vim/undo " where to save undo histories
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

if has('nvim')
  call plug#begin('~/.local/share/nvim/plugged')
else
  call plug#begin('~/.vim/plugged')
endif

" Make sure you use single quotes

Plug 'christoomey/vim-tmux-navigator'

call plug#end()

" <F2>: Exit, like <Esc> but works in TERMINAL mode
imap    <silent> <F2> <Esc>l
vmap    <silent> <F2> <Esc><F2>
omap    <silent> <F2> <Esc><F2>
if has("nvim")
    tmap   <silent> <F2> <C-\><C-n>
endif

" <F4>: sync with filesystem: load & save changes
map     <silent> <F4> :checktime<CR>:wa<CR>:diffupdate<CR>
imap    <silent> <F4> <Esc><F4>i
vmap    <silent> <F4> <Esc><F4>gv
if has("nvim")
    tmap   <silent> <F4> <C-\><C-n><F4>i
endif

" Delete trailing white space on save
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.h,*.cpp :call CleanExtraSpaces()
endif
