set nocompatible               " be iMproved

"  ---------------------------------------------------------------------------
"  Plugins
"  ---------------------------------------------------------------------------

call plug#begin('~/.vim/plugged')

" Color schemes
Plug 'rainux/vim-desert-warm-256'

" Files
Plug 'mileszs/ack.vim'
Plug 'scrooloose/nerdtree', { 'on': ['NERDTree', 'NERDTreeToggle', 'NERDTreeMirror'] }

" Plug 'kien/ctrlp.vim'
"
" brew install fzf
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
"
" " Utility
Plug 'tpope/vim-surround'
Plug 'Townk/vim-autoclose'
Plug 'tomtom/tcomment_vim'
Plug 'vim-scripts/ZoomWin'
Plug 'airblade/vim-rooter'
Plug 'vim-scripts/YankRing.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'godlygeek/tabular'
"
if executable('ag')
  Plug 'epmatsw/ag.vim'
elseif executable('ack')
  Plug 'mileszs/ack.vim'
endif

" Plug 'kien/rainbow_parentheses.vim'
" Plug 'guns/vim-sexp'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'vim-scripts/paredit.vim'

" Evaluate Clojure buffers on load
autocmd BufRead *.clj try | silent! Require | catch /^Fireplace/ | endtry

" Vala
Plug 'arrufat/vala.vim'

" Crystal
Plug 'rhysd/vim-crystal', { 'for': 'crystal' }

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

call plug#end()

runtime macros/matchit.vim

"  ---------------------------------------------------------------------------
"  General
"  ---------------------------------------------------------------------------

syntax enable
filetype plugin indent on
let mapleader = ","
let g:mapleader = ","
set modelines=0
set history=1000
set nobackup
set nowritebackup
set noswapfile
set autoread
set undofile
set nofoldenable

"  ---------------------------------------------------------------------------
"  UI
"  ---------------------------------------------------------------------------

set title
set encoding=utf-8
set scrolloff=3
set autoindent
set smartindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set cursorline
set ttyfast
"set lazyredraw
set ruler
set backspace=indent,eol,start
set laststatus=2
set number
set relativenumber
set previewheight=20
set cinoptions=:0,l1,t0,g0,(0

set t_Co=256
set background=dark
colorscheme desert-warm-256
highlight clear SignColumn
highlight CursorLine term=NONE cterm=NONE ctermbg=236

" set the title
set titlestring=%{substitute(getcwd(),\ $HOME,\ '~',\ '')}/
set titlestring+=%f

" make vertical split bar character a space (so not visible)
set fillchars+=vert:\ 

set splitbelow splitright

" switch to relative numbers in normal mode
autocmd BufLeave * :set norelativenumber
autocmd BufEnter * :set relativenumber
autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber

set regexpengine=1 " use old, faster, regex engine

"  ---------------------------------------------------------------------------
"  Text Formatting
"  ---------------------------------------------------------------------------

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set shiftround

set nowrap
set textwidth=79
set formatoptions=n

if exists("+colorcolumn")
  set colorcolumn=80
  highlight ColorColumn ctermbg=236
endif

" display tabs and trailing spaces
set list listchars=tab:▷⋅,trail:⋅,nbsp:⋅"

"  ---------------------------------------------------------------------------
"  Misc
"  ---------------------------------------------------------------------------

set tildeop

"  ---------------------------------------------------------------------------
"  Status Line
"  ---------------------------------------------------------------------------

" path
set statusline+=%f
" flags
set statusline+=%m%r%h%w
" git branch
set statusline+=\ %{fugitive#statusline()}
" encoding
set statusline+=\ [%{strlen(&fenc)?&fenc:&enc}]
" rvm
if exists("$rvm_path")
  set statusline+=\ %{rvm#statusline()}
end
" line x of y
set statusline+=\ [line\ %l\/%L]

" Colour
hi StatusLine ctermfg=Black ctermbg=White
hi StatusLineNC ctermfg=Black ctermbg=Grey

" Change colour of statusline in insert mode
"au InsertEnter * hi StatusLine ctermbg=DarkBlue
"au InsertLeave * hi StatusLine ctermfg=Black ctermbg=White


"  ---------------------------------------------------------------------------
"  Mappings
"  ---------------------------------------------------------------------------

" yank to system clipboard
vnoremap yy :w !xclip -selection clipboard<CR><CR>

" Searching / moving
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set incsearch
set showmatch
" set nohlsearch

hi Search ctermfg=NONE ctermbg=NONE cterm=underline

" Toggle search highlighting
noremap <F4> :set hlsearch! hlsearch?<CR>

" Center screen when scrolling search results
nmap n nzz
nmap N Nzz

nnoremap j gj
nnoremap k gk

" To search in files (,a) we can use ack or ag

if executable('ag')
  nnoremap <leader>a :Ag! 
  nnoremap <leader>aa :Ag! <cword><CR>
elseif executable('ack')
  nnoremap <leader>a :Ack! 
  nnoremap <leader>a :Ack! <cword><CR>
  let g:ackprg="ack -H --nocolor --nogroup --column"
endif

" Ack settings: https://github.com/krisleech/vimfiles/wiki/Make-ack-ignore-files

" Auto format
map === gg=G`.zz

" TERMINAL
tnoremap <Esc> <C-\><C-n>

" Move between splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

" Switch between buffers with tab
noremap <tab> :bn<CR>
noremap <S-tab> :bp<CR>

" close buffer
nmap <leader>d :bd<CR>

" close all buffers
nmap <leader>D :bufdo bd<CR>

" Switch between last two buffers
nnoremap <leader><leader> <c-^>

" Edit/View files relative to current directory
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>v :view %%

" File to ignore for autocomplete, also used by Ctrlp
set wildignore+=*.swp,*.jpg,*.png,*.gif,*.pdf,*.bak,*.tar,*.zip,*.tgz
set wildignore+=*/.hg/*,*/.svn/*,*/.git/*
set wildignore+=*/vendor/cache/*,*/public/system/*,*/tmp/*,*/log/*,*/solr/data/*,*/.DS_Store

" Saving and exit
nmap <leader>q :wq!<CR>
nmap <leader>w :w!<CR>
nmap <leader><Esc> :q!<CR>

" CTAGS aka autocomplete
" Includes all gems in RVM gemset, excludes Javascript and HTML
"map <leader>rt :!ctags --sort=yes --extra=+f --languages=-javascript --exclude=.git --exclude=log --exclude=db --exclude=public --exclude=alfresco -R * `rvm gemdir`/gems/* `rvm gemdir`/bundler/gems/*<CR><C-M>

map <leader>rt :call VimuxRunCommand("clear;ctags --sort=yes --extra=+f --languages=-javascript --exclude=.git --exclude=log --exclude=db --exclude=public --exclude=alfresco -R * `rvm gemdir`/gems/* `rvm gemdir`/bundler/gems/* &")<CR>


"  ---------------------------------------------------------------------------
"  Function Keys
"  ---------------------------------------------------------------------------

"  ---------------------------------------------------------------------------
"  Plugins
"  ---------------------------------------------------------------------------

" Tabular

" align by comma
map <leader>tc :Tabularize /,\zs<CR>

" FZF (Fuzzy search)
" https://github.com/junegunn/fzf.vim
nmap <leader>f :GitFiles<CR>
nmap <leader>b :Buffers<CR>

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" ZoomWin (toggle split to full screen)
map <leader>z :ZoomWin<CR>

" NERDTree
map <leader>p :NERDTreeToggle<cr>
let NERDTreeShowBookmarks = 0
let NERDChristmasTree = 1
let NERDTreeWinPos = "left"
let NERDTreeHijackNetrw = 1
let NERDTreeQuitOnOpen = 1
let NERDTreeWinSize = 50 
let NERDTreeChDirMode = 2
let NERDTreeDirArrows = 1

" Use only current file to autocomplete from tags
set complete=.,w,b,u,t,i

" AutoClose
let g:AutoClosePairs = {'(': ')', '{': '}', '[': ']', '"': '"', "'": "'", '#{': '}'} 
let g:AutoCloseProtectedRegions = ["Character"] 

let my_home = expand("$HOME/")

if filereadable(my_home . '.vim/bundle/vim-autocorrect/autocorrect.vim')
  source ~/.vim/bundle/vim-autocorrect/autocorrect.vim
endif

" Easy commenting
nnoremap <C-/> :TComment<CR>
vnoremap <C-/> :TComment<CR>

" Supertab
let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"

" YankRing
let g:yankring_history_dir = '/tmp'
" Prevent "clipboard: error: Error: target STRING not available" on startup
" https://github.com/neovim/neovim/issues/2642
let g:yankring_clipboard_monitor=0

" Fugitive

nmap <leader>gs :Gstatus<CR>
nmap <leader>gc :Gcommit<CR>i

" GitGutter

let g:gitgutter_map_keys = 0

" Clojure

" surround form `()` in another form `()` and enter insert mode at the opening
" of the form.
" (:foo params) => ((:foo params))
nmap s( ysa))a

" as above but insert at the end of the form
nmap s) ysa))%i

"  ---------------------------------------------------------------------------
"  GUI
"  ---------------------------------------------------------------------------

if has("gui_running")
  set guioptions-=T " no toolbar
  set guioptions-=m " no menus
  set guioptions-=r " no scrollbar on the right
  set guioptions-=R " no scrollbar on the right
  set guioptions-=l " no scrollbar on the left
  set guioptions-=b " no scrollbar on the bottom
  set guioptions=aiA
  set mouse=a
  set guifont=Monaco:h12
endif

" Mouse in terminal!!! (good for resizing splits)
if has('mouse')
  set mouse=a
  "set ttymouse=xterm2
endif

"  ---------------------------------------------------------------------------
"  Directories
"  ---------------------------------------------------------------------------

set directory=./.vim-swap,~/tmp/vim,~/.tmp,~/tmp,/tmp
set backupdir=./.vim-backup,~/tmp/vim,~/.tmp,~/tmp,/tmp
set undodir=./.vim-undo,~/tmp/vim,~/.tmp,~/tmp,/tmp

" Ctags path
let Tlist_Ctags_Cmd = 'ctags'

" Make Vim use RVM correctly when using Zsh
" https://rvm.beginrescueend.com/integration/vim/
set shell=/bin/sh

" Finally, load custom configs
" if filereadable(my_home . '.vimrc.local')
"   source ~/.vimrc.local
" endif

set exrc            " enable per-directory .vimrc files
set secure          " disable unsafe commands in local .vimrc files

"  ---------------------------------------------------------------------------
"  Misc
"  ---------------------------------------------------------------------------

" When vimrc, either directly or via symlink, is edited, automatically reload it
autocmd! bufwritepost .nvimrc source %
autocmd! bufwritepost nvimrc source %
" autocmd! bufwritepost bundles.vim source %
