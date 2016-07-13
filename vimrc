set nocompatible
set encoding=utf8
set spell

filetype off

"""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

" markdown
Plugin 'tpope/vim-markdown'

" colorscheme
Plugin 'flazz/vim-colorschemes'

" JavaScript
Plugin 'pangloss/vim-javascript'
Plugin 'jason0x43/vim-js-indent'
Plugin 'othree/yajs.vim'
Plugin 'mxw/vim-jsx'

" Git, Fugitive, Extradite, Gutter
Plugin 'tpope/vim-fugitive'
Plugin 'int3/vim-extradite'
Plugin 'airblade/vim-gitgutter'

""""""""""""""""""""""""""""""""""""""
" Syntastic!!
" npm i -g jshint eslint babel-eslint eslint-plugin-react eslint_d
Plugin 'scrooloose/syntastic'
Plugin 'ruanyl/vim-fixmyjs'

let g:syntastic_error_symbol = "✗"
let g:syntastic_warning_symbol = "⚠"

let g:syntastic_json_checkers = ["jshint"]

let g:syntastic_javascript_checkers = ["eslint"]
let g:syntastic_javascript_eslint_exec = 'eslint_d'

nnoremap <Leader>f :Fixmyjs<CR>

let g:syntastic_typescript_checkers = ["eslint"]

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1

autocmd BufRead,BufEnter,BufNew *.jsx    let b:syntastic_checkers = ["eslint"]
autocmd BufRead,BufEnter .babelrc        let b:syntastic_checkers = ["jshint"]
autocmd BufRead,BufEnter *.json          let b:syntastic_checkers = ["jshint"]

""""""""""""""""""""""""""""""""""""""
" NERDTree

Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
noremap <Leader>n :NERDTreeToggle<CR>
let NERDTreeWinPos='right'

" Ack.Vim serach
Plugin 'mileszs/ack.vim'

" use ag if available
if executable('ag')
   let g:ackprg = 'ag --nogroup --nocolor --column --smart-case'
   set grepprg=ag\ --nogroup\ --nocolor
endif


call vundle#end()            " required
filetype plugin indent on    " required

""""""""""""""""""""""""""""""""""""""

nnoremap <F8> :setlocal spell! spell? <CR>

colorscheme slate
syntax on

set statusline=%{fugitive#statusline()}

" Directories for swp/undo files
set undofile
set nobackup
set nowritebackup
set undodir=~/.vim/undo
set backupdir=~/.vim/backup
set directory=~/.vim/swp

" 4 spaces indent, as JS wants it
set nowrap tabstop=4 shiftwidth=4 softtabstop=4 expandtab smartindent

set number

" Remember last location in file
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

" Auto-clean whitespace
autocmd BufWritePre * :%s/\s\+$//e

" File types
autocmd BufReadPost *cshtml              set filetype=html
autocmd BufRead,BufEnter .babelrc        set filetype=javascript

" indent helpers
nnoremap <Tab> >>
nnoremap <S-Tab> <<
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" command line options
set t_Co=256
set mouse=a
set ttymouse=xterm2
inoremap <C-s> <C-o>:wa<CR>
nnoremap <C-s> :wa<CR>
