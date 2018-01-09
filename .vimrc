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
Plugin 'Frydac/Vim-Tree'
Plugin 'tpope/vim-fugitive'
Plugin 'gregsexton/gitv'
Plugin 'scrooloose/nerdcommenter'
Plugin 'stefandtw/quickfix-reflector.vim'
Plugin 'danchoi/ri.vim'
Plugin 'dkprice/vim-easygrep'
Plugin 'Tuxdude/mark.vim'
Plugin 'bronson/vim-visual-star-search'
Plugin 'Valloric/ListToggle'
Plugin 'scrooloose/nerdtree'
Plugin 'mileszs/ack.vim'
Plugin 'kshenoy/vim-signature'
Plugin 'tpope/vim-unimpaired' " shortcuts that make life easier
Plugin 'nathanaelkane/vim-indent-guides' " indent guides
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'yuttie/comfortable-motion.vim'

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
set wildignore+=*/cache/*,*/*.wav,*/node_modules/*
nnoremap <leader>b :CtrlPBuffer<CR>

set cindent
set cinoptions+=t0
set cinoptions+=g0

if v:version >= 800
    set termguicolors
    set t_Co=16
endif
if has("gui_running")
    colorscheme xcode
else
    colorscheme molokai
end
"colorscheme angr
" colorscheme summerfruit256
" colorscheme seagull
"colorscheme solarized
" colorscheme sidonia
"colorscheme messy
"if has("gui_running")
"    colorscheme messy
"else
"    set termguicolors
"    set t_Co=16
"    colorscheme messy
"endif
" colorscheme vim-material
" let g:airline_theme='material'

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
nnoremap <C-Space> :YcmCompleter GoTo<CR>
nnoremap <C-Return> :vsplit <bar> YcmCompleter GoTo<CR>

let g:ycm_always_populate_location_list = 1
if has('unix')
    if has('mac')
        let g:clang_library_path = '/usr/local/Cellar/llvm/3.8.1/lib/'
    endif
endif
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_confirm_extra_conf=0
" Apply YCM FixIt
map <leader>f :YcmCompleter FixIt<CR>

" Disable highlight from search (last part is for vim-mark)
nnoremap <leader><space> :noh<CR>:MarkClear<cr>

" Ignore
set wildignore+=*/env/*,*/cache/*,*/.git/*,*/deliverables/*

" Search for selected text
vnoremap // y/<C-R>"<CR>

" CtrlP
" show open buffers
nnoremap <leader>b :CtrlPBuffer<CR>
" show most recent used files
nnoremap <leader>k :CtrlPMRUFiles<CR>
let g:ctrlp_working_path_mode = ''
let g:ctrlp_match_window = 'min:4,max:999'
let g:ctrlp_switch_buffer = 'e'

" vim-mark
" ignore leader r
nnoremap <Plug>IgnoreMarkRegex <Plug>MarkRegex

" Hide all scrollbars
set guioptions=

" NERDTree
" Open
map <C-T> :NERDTreeToggle<CR>
" Close if no other buffers
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" set the width of the nerdtree window bigger, default is 31
let g:NERDTreeWinSize=50
let g:NERDTreeDirArrows=0
let g:NERDTreeQuitOnOpen=1
" find current file in nerdtree
nnoremap <leader>tf :NERDTreeFind<CR>
let g:NERDCustomDelimiters = { 'tree': { 'left': '<', 'right': '>'}, 'asd': { 'left' : '//' } }

" set list prettier
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+

" vim-indent-guides
let g:indent_guides_guide_size=1
let g:indent_guides_start_level=2
"set ts=4 sw=4 et

" Ulti-Snips
" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-h>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
" Where should UltiSnipsEdit put its files, by default it just went into the
" home directory, rather in the vim folder
if has('win32')
    let g:UltiSnipsSnippetsDir='~/vimfiles/bundle/vim-auro/UltiSnips'
else
    let g:UltiSnipsSnippetsDir='~/.vim/bundle/vim-auro/UltiSnips'
endif 

" EasyGrep
let g:EasyGrepMode='TrackExt'
let g:EasyGrepJumpToMatch=0
let g:EasyGrepRecursive=1
let g:EasyGrepCommand=1
let g:EasyGrepSearchCurrentBufferDir=0

" Clang-format
noremap <C-K> :pyf ~/dev/bin/clang-format.py<cr>
inoremap <C-K> <c-o>:pyf ~/dev/bin/clang-format.py<cr>

" comfortable-motion
"let g:comfortable_motion_friction = 80.0
"let g:comfortable_motion_air_drag = 2.0

"let g:comfortable_motion_friction = 200.0
"let g:comfortable_motion_air_drag = 0.0

"let g:comfortable_motion_friction = 0.0
"let g:comfortable_motion_air_drag = 4.0

let g:comfortable_motion_no_default_key_mappings = 1
let g:comfortable_motion_impulse_multiplier = 1  " Feel free to increase/decrease this value.
nnoremap <silent> <C-d> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * 2)<CR>
nnoremap <silent> <C-u> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * -2)<CR>
nnoremap <silent> <C-f> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * 4)<CR>
nnoremap <silent> <C-b> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * -4)<CR>
