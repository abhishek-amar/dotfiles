set nocompatible " required
filetype off " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'vim-syntastic/syntastic'
Plugin 'joshdick/onedark.vim'
Plugin 'vim-python/python-syntax'
Plugin 'itchyny/lightline.vim'
Plugin 'ycm-core/YouCompleteMe'

call vundle#end()

" Set encoding
set encoding=utf-8

" Add line numbers
set nu

" Enable auto-indents
filetype plugin indent on
set smartindent

" Allow system clipboard acces
set clipboard=unnamed

" Remove system bells
set noerrorbells

" Prevent creation of swap files
set noswapfile

" Case sensitive searching
set smartcase

" Tab spaces and shift spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Convert tab spaces into spaces
set expandtab

" Incremental searching
set incsearch

" Use this to enable true colours for vim
if (empty($TMUX))
	if(has("nvim"))
		let $NVUM_TUI_ENABLE_TRUE_COLOR=1
	endif

	if (has("termguicolors"))
		set termguicolors
	endif
endif

" Set colourscheme and general background colour
colorscheme onedark
set background=dark

" Set to 16 colour palette if using st or non-true colour terminal
"let g:onedark_termcolors=16

" Syntax highlighting
syntax on

" Enable all python syntax highlighting
let g:python_highlight_all=1

" To enable statusbar
set laststatus=2

" Prevent modes from showing below the status bar
set noshowmode

" Highlight current line
set cursorline

" Set statusbar colour scheme
let g:lightline = {
	\ 'colorscheme': 'one',
	\ }

" Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Set fileformat, helps compatibility for files created in Windows
set fileformat=unix
