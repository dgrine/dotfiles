if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plug
" =============================================================================
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Tag bar
" Dependency on universal-ctags https://github.com/universal-ctags/homebrew-universal-ctags
" On macOS:
"   brew install --HEAD universal-ctags/universal-ctags/universal-ctags
Plug 'majutsushi/tagbar'
nmap <Leader> tb :TagbarToggle<CR>
let g:tagbar_width = 75
let g:tagbar_compact = 1
let g:tagbar_indent = 1
let g:tagbar_autofocus = 1

" Lean & mean status/tabline for vim that's light as air
Plug 'vim-airline/vim-airline'
" Powerline fonts: disable this if things look weird (no powerline fonts
" available)
let g:airline_powerline_fonts = 1

" Tab bar
let g:airline#extensions#tabline#enabled = 1

" Fuzzy File Finder
" On macOS:
"   brew install fzf
"   ln -s /usr/local/opt/fzf ~/.fzf
" location (/usr/local/opt/fzf)
" On Linux:
"   git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
"   ~/.fzf/install
Plug '~/.fzf'
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
" Per command history
let g:fzf_history_dir = '~/.fzf-history'

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

" Multiple cursor editing
Plug 'terryma/vim-multiple-cursors'

" Jump to any location specified by two characters
Plug 'justinmk/vim-sneak'

" Shortcuts that make life easier (like jumping to next error, etc.)
Plug 'tpope/vim-unimpaired'

" Javascript
Plug 'maksimr/vim-jsbeautify'

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

" Git gutter
Plug 'airblade/vim-gitgutter'
set updatetime=1000

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
let g:UltiSnipsSnippetsDir=$HOME.'/dev/repos/setup/vim/snippets/UltiSnips'
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
" Note: to align a table: gaip*|

" Rg (ripgrep)
Plug 'jremmen/vim-ripgrep'

" Kivy language support
"Plug 'farfanoide/vim-kivy'

" Tmux integration: status bar
Plug 'edkolev/tmuxline.vim'
let g:airline#extensions#tmuxline#enabled = 1

" Tmux: navigation
Plug 'christoomey/vim-tmux-navigator' 
" Disable tmux navigator when zooming the Vim pane
let g:tmux_navigator_disable_when_zoomed = 1

" Deeper integration (specifically running tests and commands) between Vim and
" Tmux
" See https://blog.bugsnag.com/tmux-and-vim/
Plug 'benmills/vimux'
" Prompt for a command to run
map <Leader>rp :VimuxPromptCommand<CR>
" Run last command executed by VimuxRunCommand
map <Leader>rr :VimuxRunLastCommand<CR>
" Inspect runner pane (already brings you in copy mode)
map <Leader>ri :VimuxInspectRunner<CR>
" Close the tmux runner
map <Leader>rq :VimuxCloseRunner<CR>
" Runner pane
let g:VimuxOrientation = 'h'
let g:VimuxHeight = '40'

" Clang formatting
Plug 'rhysd/vim-clang-format'
let g:clang_format#detect_style_file=1

" map to <Leader>cf in C++ code
autocmd FileType javascript,c,cpp,objc nnoremap <buffer><C-F> :<C-u>ClangFormat<CR>
autocmd FileType javascript,c,cpp,objc vnoremap <buffer><C-F> :ClangFormat<CR>
" if you install vim-operator-user
"autocmd FileType c,cpp,objc map <buffer><Leader>x <Plug>(operator-clang-format)
" Toggle auto formatting:
"nmap <Leader>C :ClangFormatAutoToggle<CR><Paste>

" Coc
" See https://github.com/neoclide/coc.nvim and personal dev docs
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> <Leader>g[ <Plug>(coc-diagnostic-prev)
nmap <silent> <Leader>g] <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> <Leader>gd <Plug>(coc-definition)
nmap <silent> <Leader>gy <Plug>(coc-type-definition)
nmap <silent> <Leader>gi <Plug>(coc-implementation)
nmap <silent> <Leader>gr <Plug>(coc-references)

" When on a typename, show member variables / variables in a namespace
nn <silent> <Leader>gm :call CocLocations('ccls','$ccls/member')<cr>
" When on a typename, member functions / functions in a namespace
nn <silent> <Leader>gf :call CocLocations('ccls','$ccls/member',{'kind':3})<cr>

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
"autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <Leader>gn <Plug>(coc-rename)

" Remap for format selected region
"xmap <Leader>f  <Plug>(coc-format-selected)
"nmap <Leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<Leader>aap` for current paragraph
"xmap <Leader>a  <Plug>(coc-codeaction-selected)
"nmap <Leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
"nmap <Leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <Leader>gq  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
"xmap if <Plug>(coc-funcobj-i)
"xmap af <Plug>(coc-funcobj-a)
"omap if <Plug>(coc-funcobj-i)
"omap af <Plug>(coc-funcobj-a)

" Use <TAB> for select selections ranges, needs server support, like: coc-tsserver, coc-python
"nmap <silent> <TAB> <Plug>(coc-range-select)
"xmap <silent> <TAB> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <Leader>ga  :<C-u>CocList diagnostics<cr>
" Manage extensions
"nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
"nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
"nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
"nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
"nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
"nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
"nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" Python Black formatter (PEP8)
Plug 'psf/black'
autocmd FileType python nnoremap <buffer><C-F> :Black<CR>

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
"set signcolumn=auto:2 " useful for having git-gutter and coc info
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
set clipboard=unnamedplus
" Indents word-wrapped lines as much as the 'parent' line
set breakindent
" Ensures word-wrap does not split words
set formatoptions=l
set lbr

" Visuals
set termguicolors
let g:dracula_italic = 0
highlight Normal ctermbg=None
"nmap <Leader>csl :colorscheme xcode<CR>
"nmap <Leader>csd :colorscheme dracula<CR>
nmap <Leader>csd :colorscheme tomorrow_night<CR>
colorscheme tomorrow_night

" =============================================================================

" File type specific settings
" =============================================================================
" Set TypeScript indentation
autocmd BufNewFile,BufRead *.ts call SetTypeScriptOptions()
function SetTypeScriptOptions()
    set shiftwidth=2
endfunction
" Set ReStructured Text indentation
function SetReStructuredTextOptions()
    set indentexpr="" 
    set shiftwidth=2
endfunction
autocmd BufNewFile,BufRead *.rst call SetReStructuredTextOptions()
autocmd BufNewFile,BufRead *.md call SetReStructuredTextOptions()
" =============================================================================

" Custom key mapping
" =============================================================================
" Delete all buffers except the current one
nmap <Leader>bda :%bda<CR>
nmap <Leader>bd :%bd<CR>
" =============================================================================

