" Common Vim defaults for terminal-heavy development.

set nocompatible

filetype plugin indent on
syntax enable

set encoding=utf-8
set hidden
set history=1000
set autoread
set backspace=indent,eol,start
set wildmenu
set wildmode=longest:full,full
set completeopt=menuone,noinsert,noselect
set shortmess+=c

set number
set relativenumber
set ruler
set showcmd
set cursorline
set signcolumn=yes
set splitbelow
set splitright
set scrolloff=5
set sidescrolloff=8
set nowrap
set linebreak
set updatetime=300
set timeoutlen=500
set ttimeoutlen=10

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab
set autoindent
set smartindent
set shiftround

set incsearch
set hlsearch
set ignorecase
set smartcase
set showmatch
set matchtime=2
set laststatus=2

if has('mouse')
  set mouse=a
endif

if has('termguicolors')
  set termguicolors
endif

if executable('rg')
  set grepprg=rg\ --vimgrep\ --smart-case
  set grepformat=%f:%l:%c:%m
endif

if has('persistent_undo')
  let s:undo_dir = expand('~/.vim/undo')
  if !isdirectory(s:undo_dir)
    call mkdir(s:undo_dir, 'p', 0700)
  endif
  let &undodir = s:undo_dir
  set undofile
endif

let s:tmp_dir = expand('~/.vim/tmp')
if !isdirectory(s:tmp_dir)
  call mkdir(s:tmp_dir, 'p', 0700)
endif
let &directory = s:tmp_dir . '//'
let &backupdir = s:tmp_dir . '//'

let mapleader = ' '

nnoremap <leader>w :update<CR>
nnoremap <leader>q :quit<CR>
nnoremap <leader><space> :nohlsearch<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

let g:netrw_banner = 0
let g:netrw_liststyle = 3

augroup user_common_settings
  autocmd!
  autocmd FileType make setlocal noexpandtab
augroup END

if filereadable(expand('~/.vimrc.local'))
  execute 'source' fnameescape(expand('~/.vimrc.local'))
endif

