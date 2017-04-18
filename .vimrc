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
set noexpandtab
set tabstop=4
set shiftwidth=4
set ruler
set laststatus=2

filetype plugin on
let g:pydiction_location = '/Users/djamelg/.vim/bundle/pydiction/complete-dict' 
let g:airline#extensions#tabline#enabled = 1
set wildignore+=*/cache/*
nnoremap <leader>b :CtrlPBuffer<CR>

set cindent
set cinoptions+=t0
set cinoptions+=g0

" colorscheme summerfruit256
colorscheme seagull

" nnoremap <esc> :nohlsearch<CR><esc>

