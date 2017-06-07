set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'rkulla/pydiction.git'
Plugin 'flazz/vim-colorschemes'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-surround'
Plugin 'justinmk/vim-sneak'
Plugin 'Valloric/YouCompleteMe'
Plugin 'leafgarland/typescript-vim'
Plugin 'Frydac/Vim-Auro'
Plugin 'tpope/vim-fugitive'
Plugin 'gregsexton/gitv'
Plugin 'terryma/vim-expand-region'
Plugin 'scrooloose/nerdcommenter'
Plugin 'stefandtw/quickfix-reflector.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

syntax on
set hlsearch
set incsearch
set number
set autoindent
set expandtab
set tabstop=4
set shiftwidth=4
set ruler
set laststatus=2
set noswapfile
set cursorline
set mouse=a

filetype plugin on
let g:pydiction_location = '/Users/djamelg/.vim/bundle/pydiction/complete-dict' 
let g:airline#extensions#tabline#enabled = 1
set wildignore+=*/cache/*,*/*.wav
nnoremap <leader>b :CtrlPBuffer<CR>

set cindent
set cinoptions+=t0
set cinoptions+=g0

if v:version >= 800
    set termguicolors
    set t_Co=16
endif
"colorscheme summerfruit256
colorscheme seagull
"colorscheme solarized
"colorscheme sidonia
"colorscheme messy
"if has("gui_running")
"    colorscheme messy
"else
"    set termguicolors
"    set t_Co=16
"    colorscheme messy
"endif

" Disable middle mouse buttons
nnoremap <MiddleMouse> <Nop>
nnoremap <2-MiddleMouse> <Nop>
nnoremap <3-MiddleMouse> <Nop>
nnoremap <4-MiddleMouse> <Nop>
inoremap <MiddleMouse> <Nop>
inoremap <2-MiddleMouse> <Nop>
inoremap <3-MiddleMouse> <Nop>
inoremap <4-MiddleMouse> <Nop>

" Vertical split with new buffer
nnoremap <leader>vn :vnew<CR>
nnoremap <leader>hn :new<CR>

" YcmCompleter GoTo mapping
nnoremap <C-Space> :YcmCompleter GoTo <Enter>

" Disable highlight from search
nnoremap <leader>l :noh<CR>

" Ignore
set wildignore+=*/env/*,*/cache/*,*/.git/*,*/deliverables/*

" Search for selected text
vnoremap // y/<C-R>"<CR>

" CtrlP
" show open buffers
nnoremap <leader>pb :CtrlPBuffer<CR>
" show most recent used files
nnoremap <leader>m :CtrlPMRUFiles<CR>
