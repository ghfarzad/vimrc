" ============================================================
"  Personal Vim Configuration
"  Windows Terminal + Development
"  Place at %USERPROFILE%\_vimrc
" ============================================================


" ------------------------------------------------------------
" Basic Settings
" ------------------------------------------------------------

set nocompatible              " Use Vim defaults (not vi)
set encoding=utf-8
set hidden                    " Allow switching buffers without saving
set history=1000
set autoread                  " Auto reload changed files

syntax on
filetype plugin indent on


" ------------------------------------------------------------
" Display / UI
" ------------------------------------------------------------

set number                    " Show line numbers
set relativenumber            " Relative line numbers
set cursorline                " Highlight current line
set nocursorcolumn            " Disable column highlight (performance)
set showcmd                   " Show command in status line
set showmode                  " Show current mode
set ruler
set laststatus=2              " Always show status line
set wildmenu                  " Better command completion
set scrolloff=5               " Keep context when scrolling
set sidescrolloff=5

set background=dark
colorscheme desert            " Default colorscheme (change if needed)


" ------------------------------------------------------------
" Input / Mouse / Terminal
" ------------------------------------------------------------

set mouse=a                   " Enable mouse support
set ttyfast                   " Faster terminal redraw
set lazyredraw                " Improve macro / scroll performance

" System clipboard (Windows)
set clipboard=unnamed


" ------------------------------------------------------------
" Windows Terminal — enable true color
" ------------------------------------------------------------

if has('termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif


" ------------------------------------------------------------
" Indentation / Formatting
" ------------------------------------------------------------

set expandtab                 " Use spaces instead of tabs
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smartindent
set autoindent

set wrap                      " Enable line wrapping
set linebreak                 " Wrap at word boundaries


" ------------------------------------------------------------
" Searching
" ------------------------------------------------------------

set ignorecase                " Case insensitive search
set smartcase                 " Case sensitive if uppercase
set incsearch                 " Incremental search
set hlsearch                  " Highlight matches


" ------------------------------------------------------------
" File / Backup / Undo
" ------------------------------------------------------------

set undofile                  " Persistent undo

" Windows-friendly temp paths
set dir=$TEMP\\vim\\          " Swap files
set backupdir=$TEMP\\vim\\    " Backup files
set undodir=$TEMP\\vim\\      " Undo files

set noswapfile                " Disable swap (optional)

" Create temp dir if it doesn't exist
if !isdirectory($TEMP . '\vim')
    call mkdir($TEMP . '\vim', 'p')
endif


" ------------------------------------------------------------
" Path / File Navigation
" ------------------------------------------------------------

" Allow recursive file search (:find, gf, etc.)
set path+=**

set wildignore+=*\\.git\\*,*\\node_modules\\*,*\\build\\*,*\\dist\\*


" ------------------------------------------------------------
" Window / Split Behavior
" ------------------------------------------------------------

set splitbelow                " Horizontal splits below
set splitright                " Vertical splits right
set noequalalways             " Do not auto-resize splits

" Normalize windows on startup
autocmd VimEnter * wincmd =


" ------------------------------------------------------------
" Split Navigation
" ------------------------------------------------------------

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Resize splits with Ctrl + Arrows
nnoremap <C-Up>    :resize +2<CR>
nnoremap <C-Down>  :resize -2<CR>
nnoremap <C-Left>  :vertical resize -2<CR>
nnoremap <C-Right> :vertical resize +2<CR>


" ------------------------------------------------------------
" Key Mappings
" ------------------------------------------------------------

let mapleader=","              " Leader key

" Clear search highlight
nnoremap <leader>h :nohlsearch<CR>

" Fast save
nnoremap <leader>w :w<CR>

" Quit
nnoremap <leader>q :q<CR>

" FZF file search
nnoremap <C-f> :Files<CR>

" Fast escape
inoremap jj <Esc>

" Highlight yanked text (Vim-native)
augroup YankHighlight
    autocmd!
    autocmd TextYankPost * call matchadd('IncSearch', '\%' . line('.') . 'l', 100, -1) |
                         \ call timer_start(200, {-> clearmatches()})
augroup END


" ------------------------------------------------------------
" Plugin Manager (vim-plug)
" ------------------------------------------------------------

" Auto-install vim-plug if missing
let s:plug_path = expand('~/vimfiles/autoload/plug.vim')
if empty(glob(s:plug_path))
    silent execute '!curl -fLo ' . s:plug_path . ' --create-dirs '
        \ . 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


call plug#begin('~/vimfiles/plugged')


" ------------------------------------------------------------
" Plugins
" ------------------------------------------------------------

" File search
" NOTE: fzf must be installed separately on Windows.
" Run in PowerShell: winget install junegunn.fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Better syntax highlighting
Plug 'sheerun/vim-polyglot'

" Git integration
Plug 'tpope/vim-fugitive'

" Status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'


call plug#end()


" ------------------------------------------------------------
" Plugin Settings
" ------------------------------------------------------------

" Airline
let g:airline_powerline_fonts = 1
let g:airline_theme='dark'

" FZF layout
let g:fzf_layout = { 'down': '40%' }


" ------------------------------------------------------------
" Filetype Specific Settings
" ------------------------------------------------------------

" C / C++
autocmd FileType c,cpp setlocal tabstop=4 shiftwidth=4 expandtab

" Python
autocmd FileType python setlocal tabstop=4 shiftwidth=4 expandtab

" Makefiles (use tabs)
autocmd FileType make setlocal noexpandtab


" ------------------------------------------------------------
" Session Support
" ------------------------------------------------------------

set sessionoptions+=globals


" ------------------------------------------------------------
" Misc
" ------------------------------------------------------------

set updatetime=300             " Faster CursorHold
set timeoutlen=500             " Faster mapped sequences


" ------------------------------------------------------------
" End of vimrc
" ------------------------------------------------------------
