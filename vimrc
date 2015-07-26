set nocompatible
set encoding=utf8
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Bundle 'tpope/vim-fugitive'
Bundle 'int3/vim-extradite'

" colorscheme
Bundle 'flazz/vim-colorschemes'

call vundle#end()            " required
filetype plugin indent on    " required

nnoremap <F8> :setlocal spell! spell? <CR>

:colorscheme slate
:syntax on

" Directories for swp/undo files
set undofile
set nobackup
set nowritebackup
set undodir=~/.vim/undo
set backupdir=~/.vim/backup
set directory=~/.vim/swp

" 4 spaces indent, as JS wants it
set nowrap
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab smartindent

set number
