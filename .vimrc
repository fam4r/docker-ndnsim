" general ---------------------------------------------------------------------
syntax on
syntax enable
colorscheme desert
set t_Co=256
set background=dark
set shell=zsh
set ttimeoutlen=50

" appearance ------------------------------------------------------------------
set laststatus=2
set showtabline=2
set number
" set textwidth=80
set colorcolumn=80
set modeline
set modelines=5
set scrolloff=6
set cursorline
set ruler

" clipboard -------------------------------------------------------------------
set clipboard=unnamedplus
set pastetoggle=<F12>

" encoding --------------------------------------------------------------------
set encoding=utf-8
set fileencoding=utf-8

" indentation -----------------------------------------------------------------
set expandtab
set autoindent
set smartindent
set smarttab
set linebreak
set nojoinspaces
set backspace=indent,eol,start
set shiftwidth=4
set softtabstop=4
set tabstop=4
set list
set listchars=tab:›\ ,trail:•

" mouse -----------------------------------------------------------------------
set mouse=a
set mousehide
set gcr=a:blinkon0

" persistence -----------------------------------------------------------------
set hidden
set autoread
set showcmd

" search ----------------------------------------------------------------------
set ignorecase
set smartcase
set incsearch
set hlsearch
set showmatch
set matchtime=1
set matchpairs+=<:>

" wildmenu --------------------------------------------------------------------
set wildmenu
set noshowmode

" tabline ---------------------------------------------------------------------
:hi TabLineFill ctermfg=Black       ctermbg=Grey
:hi TabLineSel  ctermfg=DarkGreen   ctermbg=Black
:hi TabLine     ctermfg=Blue        ctermbg=Black
