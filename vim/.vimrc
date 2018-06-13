" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Lean & mean status/tabline for vim that's light as air
Plug 'vim-airline/vim-airline'
" Tab bar
let g:airline#extensions#tabline#enabled=1

" Fuzzy File Finder
" (already installed via brew)
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
" Files (similar to :FZF)
nnoremap <leader>ft :Files<CR>
" Recent files and open buffers
nnoremap <leader>fr :History<CR>
" Git files (git status)
nnoremap <leader>fs :GFiles?<CR>
" Files command with preview window
command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" NERDTree file manager
Plug 'scrooloose/nerdtree'
" Open
map <C-T> :NERDTreeToggle<CR>
" Close if no other buffers
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Set the width of the nerdtree window bigger, default is 31
let g:NERDTreeWinSize=50
let g:NERDTreeDirArrows=0
let g:NERDTreeQuitOnOpen=1
" Find current file in nerdtree
nnoremap <leader>tf :NERDTreeFind<CR>
let g:NERDCustomDelimiters = { 'tree': { 'left': '<', 'right': '>'}, 'asd': { 'left' : '//' } }

" Commenting/uncommenting
Plug 'scrooloose/nerdcommenter'

" YouCompleteMe
Plug 'Valloric/YouCompleteMe'
let g:ycm_always_populate_location_list = 1
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_confirm_extra_conf=0
map <leader>f :YcmCompleter FixIt<CR>
nnoremap <C-Space> :YcmCompleter GoTo<CR>
nnoremap <C-Return> :vsplit <bar> YcmCompleter GoTo<CR>

" Multiple cursor editing
Plug 'terryma/vim-multiple-cursors'

" Jump to any location specified by two characters
Plug 'justinmk/vim-sneak'

" Shortcuts that make life easier (like jumping to next error, etc.)
Plug 'tpope/vim-unimpaired'

" Surround.vim is all about surroundings: parentheses, brackets, quotes, XML tags, and more
Plug 'tpope/vim-surround'

" Working with variants of a word:
" crs (coerce to snake_case)
" MixedCase (crm)
" camelCase (crc)
" snake_case (crs)
" UPPER_CASE (cru)
" dash-case (cr-)
" dot.case (cr.)
" space case (cr<space>)
" Title Case (crt)
Plug 'tpope/vim-abolish'

" Git wrapper
Plug 'tpope/vim-fugitive'
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gr :Gread<CR>

" Git gutter
Plug 'airblade/vim-gitgutter'
set updatetime=100

" Mark
" <Leader>* Jump to the next occurrence of current mark and remember it as
" last mark
" <Leader>/ Jump to the next occurrence of any mark
Plug 'Tuxdude/mark.vim'
"nnoremap <Plug>IgnoreMarkRegex <Plug>MarkRegex
" Disable highlight from search
nnoremap <leader><space> :noh<CR>:MarkClear<cr>

" Emile's additional syntax formatting
Plug 'Frydac/Vim-Tree'

" Track the engine.
Plug 'SirVer/ultisnips'

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-h>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
if has('win32')
    let g:UltiSnipsSnippetsDir='~/vimfiles/snippets/UltiSnips'
else
    let g:UltiSnipsSnippetsDir='~/.vim/snippets/UltiSnips'
endif

" Initialize plugin system
call plug#end()

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
set encoding=utf-8
" Also match <> with highlight and % jump
set matchpairs+=<:>
" Set list prettier
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
" Fixes the weird behavior of backspace in terminal vim
set backspace=indent,eol,start 
" ‘yank’ and paste using y and p from Vim as well
set clipboard=unnamed
" Clang-format
noremap <C-K> :pyf ~/dev/bin/clang-format.py<cr>
inoremap <C-K> <c-o>:pyf ~/dev/bin/clang-format.py<cr>
" Remove white borders and scrollbars across the GUI
set guioptions=
" Set the GUI font
set guifont=Hack\ Regular\ Nerd\ Font\ Complete
" Set the colorscheme
if has("gui_running")
    colorscheme xcode
end
