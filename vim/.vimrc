if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plug
" =============================================================================
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Remove this once ViM supports Python 3.7
if has('python3')
  silent! python3 1
endif

" Lean & mean status/tabline for vim that's light as air
Plug 'vim-airline/vim-airline'
" Tab bar
let g:airline#extensions#tabline#enabled=1

" Fuzzy File Finder
" (already installed via brew)
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
" Files (similar to :FZF)
nnoremap <Leader>ft :Files<CR>
" Recent files and open buffers
nnoremap <Leader>fr :History<CR>
" Git files (git status)
nnoremap <Leader>fs :GFiles?<CR>
" Files command (with preview window)
"command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, <bang>0)

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
nnoremap <Leader>tf :NERDTreeFind<CR>
let g:NERDCustomDelimiters = { 'tree': { 'left': '<', 'right': '>'}, 'asd': { 'left' : '//' } }

" Commenting/uncommenting
Plug 'scrooloose/nerdcommenter'

" YouCompleteMe
Plug 'Valloric/YouCompleteMe', { 'do': './install.sh --clang-completer' }
let g:ycm_always_populate_location_list=1
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_confirm_extra_conf=0
map <Leader>f :YcmCompleter FixIt<CR>
nnoremap <C-Space> :YcmCompleter GoTo<CR>
nnoremap <C-Return> :vsplit <bar> YcmCompleter GoTo<CR>

let g:ycm_complete_in_comments=1 
let g:ycm_seed_identifiers_with_syntax=1 
let g:ycm_collect_identifiers_from_comments_and_strings=1 

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
" space case (cr<Space>)
" Title Case (crt)
Plug 'tpope/vim-abolish'

" Git wrapper
Plug 'tpope/vim-fugitive'
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gr :Gread<CR>

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
nnoremap <Leader><Space> :noh<CR>:MarkClear<cr>

" Emile's additional syntax formatting
Plug 'Frydac/vim-tree'
" Emile's Auro stuff
Plug 'Frydac/vim-auro'
"
" UltiSnips, quick snippets
Plug 'SirVer/ultisnips'
let g:UltiSnipsSnippetsDir=$HOME.'/.my/setup/vim/snippets/UltiSnips'
let g:UltiSnipsSnippetDirectories=["UltiSnips"]
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-h>"
let g:UltiSnipsListSnippets="<c-h>"
 "If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" ctrlsf.vim
" An ack/ag/pt/rg powered code search and view tool, and lets you 
" edit in-place with powerful edit mode.
" Enter, o, double-click - Open corresponding file of current line in the window which CtrlSF is launched from.
" <C-O> - Like Enter but open file in a horizontal split window.
" t - Like Enter but open file in a new tab.
" p - Like Enter but open file in a preview window.
" P - Like Enter but open file in a preview window and switch focus to it.
" O - Like Enter but always leave CtrlSF window opening.
" T - Like t but focus CtrlSF window instead of new opened tab.
" M - Switch result window between normal view and compact view.
" q - Quit CtrlSF window.
" <C-J> - Move cursor to next match.
" <C-K> - Move cursor to previous match.
Plug 'dyng/ctrlsf.vim'
nmap     <C-F>f <Plug>CtrlSFPrompt
vmap     <C-F>f <Plug>CtrlSFVwordPath
vmap     <C-F>F <Plug>CtrlSFVwordExec
nmap     <C-F>n <Plug>CtrlSFCwordPath
nmap     <C-F>p <Plug>CtrlSFPwordPath
nnoremap <C-F>o :CtrlSFOpen<CR>
nnoremap <C-F>t :CtrlSFToggle<CR>
inoremap <C-F>t <Esc>:CtrlSFToggle<CR>

" A simple, easy-to-use Vim alignment plugin.
Plug 'junegunn/vim-easy-align'
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" Note: to allign a table: gaip*|

" Distraction-free writing in Vim
Plug 'junegunn/goyo.vim'
nnoremap <C-G>o :Goyo<CR>

" Script which generates a list of compiler flags from a project with an arbitrary build system
" :YcmGenerateConfig generates a config file for the current directory
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}

" Rg (ripgrep)
Plug 'jremmen/vim-ripgrep'

" TypeScript omni-completion
" Requires TypeScript to be installed: npm -g install typescript
Plug 'Quramy/tsuquyomi'
" TypeScript syntax highlighting
Plug 'leafgarland/typescript-vim'

" Initialize plugin system
call plug#end()
" =============================================================================

" General settings
" =============================================================================
syntax on
set hlsearch
set incsearch
set number
set autoindent
set expandtab
set tabstop=4
set shiftwidth=4
"set textwidth=80
set ruler
set cindent
set cinoptions=g-0
set laststatus=2
set noswapfile
set cursorline
set mouse=a
set encoding=utf-8
" Cursor never on first or last line
set scrolloff=10
set nocompatible
filetype plugin on
" Also match <> with highlight and % jump
set matchpairs+=<:>
" Set list prettier
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
" Fixes the weird behavior of backspace in terminal vim
set backspace=indent,eol,start 
" ‘yank’ and paste using y and p from Vim as well
set clipboard=unnamed
" Remove white borders and scrollbars across the GUI
set guioptions=
if has("gui_running")
    set guifont=Monospace\ 9
    set background=dark
    let g:palenight_terminal_italics=1
    nmap <Leader>csl :colorscheme xcode<CR>
    nmap <Leader>csd :colorscheme ir_black<CR>
    colorscheme xcode
else
    colorscheme default
end
" =============================================================================

" File type specific settings
" =============================================================================
" Set TypeScript indentation
autocmd BufNewFile,BufRead *.ts set shiftwidth=2
" =============================================================================

" Custom key mapping
" =============================================================================
" Delete all buffers except the current one
nmap <Leader>bda :%bda<CR>
nmap <Leader>bd :%bd<CR>
" Clang-format
noremap <C-K> :py3f ~/dev/repos/setup/clang-format/clang-format.py<cr>
inoremap <C-K> <c-o>:py3f ~/dev/repos/setup/clang-format/clang-format.py<cr>
" =============================================================================

