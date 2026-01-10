" ══════════════════════════════════════════════════════════════════════════════
"  VIM Configuration - Slick Developer Setup
" ══════════════════════════════════════════════════════════════════════════════

" ─────────────────────────────────────────────────────────────────────────────
"  Plugins (vim-plug)
" ─────────────────────────────────────────────────────────────────────────────
call plug#begin('~/.vim/plugged')

" Color scheme - Nord theme to match terminal
Plug 'nordtheme/vim'

" Status line - lightweight and beautiful
Plug 'itchyny/lightline.vim'

" File explorer
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'

" Fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Git integration
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Syntax and language support
Plug 'sheerun/vim-polyglot'

" Quality of life
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/tagbar'

" Indent guides
Plug 'Yggdroot/indentLine'

" Better start screen
Plug 'mhinz/vim-startify'

call plug#end()

" ─────────────────────────────────────────────────────────────────────────────
"  General Settings
" ─────────────────────────────────────────────────────────────────────────────
set nocompatible              " Disable vi compatibility
filetype plugin indent on     " Enable filetype detection
syntax enable                 " Enable syntax highlighting

set encoding=utf-8            " UTF-8 encoding
set fileencoding=utf-8        " File encoding
set termencoding=utf-8        " Terminal encoding

set hidden                    " Allow hidden buffers
set autoread                  " Auto reload changed files
set nobackup                  " No backup files
set nowritebackup             " No backup while editing
set noswapfile                " No swap files
set undofile                  " Persistent undo
set undodir=~/.vim/undodir    " Undo directory

set mouse=a                   " Enable mouse support
set clipboard=unnamedplus     " Use system clipboard
set updatetime=250            " Faster updates
set timeoutlen=500            " Mapping timeout
set ttimeoutlen=10            " Key code timeout

" ─────────────────────────────────────────────────────────────────────────────
"  UI Settings
" ─────────────────────────────────────────────────────────────────────────────
set number                    " Line numbers
set relativenumber            " Relative line numbers
set cursorline                " Highlight current line
set signcolumn=yes            " Always show sign column
set colorcolumn=80,120        " Column guides
set showmatch                 " Show matching brackets
set showcmd                   " Show command in status
set showmode                  " Show current mode
set laststatus=2              " Always show status line
set cmdheight=1               " Command line height
set pumheight=10              " Popup menu height

set scrolloff=8               " Lines above/below cursor
set sidescrolloff=8           " Columns left/right of cursor

set splitbelow                " Horizontal splits below
set splitright                " Vertical splits right

set nowrap                    " Don't wrap lines
set linebreak                 " Break at word boundaries

" Enable true colors
if has('termguicolors')
  set termguicolors
endif

set background=dark
silent! colorscheme nord

" ─────────────────────────────────────────────────────────────────────────────
"  Search Settings
" ─────────────────────────────────────────────────────────────────────────────
set hlsearch                  " Highlight search results
set incsearch                 " Incremental search
set ignorecase                " Case insensitive search
set smartcase                 " Unless uppercase used

" ─────────────────────────────────────────────────────────────────────────────
"  Indentation
" ─────────────────────────────────────────────────────────────────────────────
set autoindent                " Auto indent
set smartindent               " Smart indent
set expandtab                 " Spaces instead of tabs
set tabstop=4                 " Tab width
set shiftwidth=4              " Indent width
set softtabstop=4             " Soft tab width
set shiftround                " Round indent to shiftwidth

" ─────────────────────────────────────────────────────────────────────────────
"  Completion
" ─────────────────────────────────────────────────────────────────────────────
set completeopt=menuone,noselect,preview
set wildmenu                  " Command line completion
set wildmode=longest:full,full
set wildignore+=*.o,*.obj,*.pyc,*.class
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*
set wildignore+=*/node_modules/*,*/vendor/*
set wildignore+=*.jpg,*.png,*.gif,*.ico

" ─────────────────────────────────────────────────────────────────────────────
"  Leader Key
" ─────────────────────────────────────────────────────────────────────────────
let mapleader = " "
let maplocalleader = ","

" ─────────────────────────────────────────────────────────────────────────────
"  Key Mappings
" ─────────────────────────────────────────────────────────────────────────────

" Quick save and quit
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>x :x<CR>

" Clear search highlight
nnoremap <leader><space> :nohlsearch<CR>

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Resize windows with arrows
nnoremap <C-Up> :resize +2<CR>
nnoremap <C-Down> :resize -2<CR>
nnoremap <C-Left> :vertical resize -2<CR>
nnoremap <C-Right> :vertical resize +2<CR>

" Buffer navigation
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprevious<CR>
nnoremap <leader>bd :bdelete<CR>
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

" Move lines up/down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" Stay in visual mode when indenting
vnoremap < <gv
vnoremap > >gv

" Quick escape
inoremap jk <Esc>
inoremap kj <Esc>

" Center screen after movements
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" Yank to end of line
nnoremap Y y$

" Select all
nnoremap <leader>a ggVG

" Quick edit vimrc
nnoremap <leader>ve :e $MYVIMRC<CR>
nnoremap <leader>vs :source $MYVIMRC<CR>

" ─────────────────────────────────────────────────────────────────────────────
"  Plugin Settings
" ─────────────────────────────────────────────────────────────────────────────

" --- Lightline ---
let g:lightline = {
      \ 'colorscheme': 'nord',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }

" --- NERDTree ---
let NERDTreeShowHidden = 1
let NERDTreeMinimalUI = 1
let NERDTreeIgnore = ['\.pyc$', '__pycache__', '\.git$', 'node_modules']
let NERDTreeStatusline = ''

nnoremap <leader>e :NERDTreeToggle<CR>
nnoremap <leader>nf :NERDTreeFind<CR>

" Close vim if NERDTree is the only window
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" --- FZF ---
let g:fzf_layout = { 'down': '40%' }
let g:fzf_preview_window = ['right:50%', 'ctrl-/']

nnoremap <leader>ff :Files<CR>
nnoremap <leader>fg :GFiles<CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>fh :History<CR>
nnoremap <leader>fr :Rg<CR>
nnoremap <leader>fl :Lines<CR>
nnoremap <leader>fc :Commands<CR>
nnoremap <C-p> :Files<CR>

" --- GitGutter ---
let g:gitgutter_sign_added = '│'
let g:gitgutter_sign_modified = '│'
let g:gitgutter_sign_removed = '_'
let g:gitgutter_sign_removed_first_line = '‾'
let g:gitgutter_sign_modified_removed = '~'

nmap <leader>gj <Plug>(GitGutterNextHunk)
nmap <leader>gk <Plug>(GitGutterPrevHunk)
nmap <leader>gp <Plug>(GitGutterPreviewHunk)
nmap <leader>gs <Plug>(GitGutterStageHunk)
nmap <leader>gu <Plug>(GitGutterUndoHunk)

" --- Fugitive ---
nnoremap <leader>gg :Git<CR>
nnoremap <leader>gc :Git commit<CR>
nnoremap <leader>gd :Gdiffsplit<CR>
nnoremap <leader>gb :Git blame<CR>
nnoremap <leader>gl :Git log --oneline<CR>

" --- Tagbar ---
nnoremap <leader>t :TagbarToggle<CR>

" --- IndentLine ---
let g:indentLine_char = '│'
let g:indentLine_first_char = '│'
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_setColors = 0

" --- Startify ---
let g:startify_session_persistence = 1
let g:startify_change_to_vcs_root = 1
let g:startify_fortune_use_unicode = 1

let g:startify_lists = [
      \ { 'type': 'files',     'header': ['   Recent Files']            },
      \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
      \ { 'type': 'sessions',  'header': ['   Sessions']       },
      \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
      \ ]

let g:startify_bookmarks = [
      \ { 'v': '~/.vimrc' },
      \ { 'b': '~/.bashrc' },
      \ { 't': '~/.tmux.conf' },
      \ ]

let g:startify_custom_header = [
      \ '   ╻ ╻   ╻   ┏┳┓',
      \ '   ┃┏┛   ┃   ┃┃┃',
      \ '   ┗┛    ╹   ╹ ╹',
      \ '',
      \ ]

" ─────────────────────────────────────────────────────────────────────────────
"  Autocommands
" ─────────────────────────────────────────────────────────────────────────────
augroup vimrc
  autocmd!

  " Return to last edit position
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

  " Remove trailing whitespace on save
  autocmd BufWritePre * :%s/\s\+$//e

  " Auto-resize splits when window is resized
  autocmd VimResized * wincmd =

  " Highlight yanked text
  autocmd TextYankPost * silent! lua vim.highlight.on_yank({timeout=200})

augroup END

" File type specific settings
augroup filetypes
  autocmd!
  autocmd FileType python setlocal tabstop=4 shiftwidth=4
  autocmd FileType javascript,typescript,json,yaml,html,css setlocal tabstop=2 shiftwidth=2
  autocmd FileType go setlocal noexpandtab tabstop=4 shiftwidth=4
  autocmd FileType make setlocal noexpandtab
augroup END

" ─────────────────────────────────────────────────────────────────────────────
"  Create directories if they don't exist
" ─────────────────────────────────────────────────────────────────────────────
if !isdirectory(expand("~/.vim/undodir"))
  call mkdir(expand("~/.vim/undodir"), "p")
endif
