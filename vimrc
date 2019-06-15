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

" Git, Fugitive
Plugin 'tpope/vim-fugitive'

" Fugitive git bindings
nnoremap <space>gs :Gstatus<CR>
nnoremap <space>gc :Gcommit<CR>
nnoremap <space>gd :Gdiff<CR>
nnoremap <space>gr :Gread<CR>
nnoremap <space>gm :Gmove<Space>

" Extradite, Gutter
Plugin 'int3/vim-extradite'
Plugin 'airblade/vim-gitgutter'

" TypeScript
Plugin 'leafgarland/typescript-vim'
Plugin 'Shougo/vimproc.vim'

""""""""""""""""""""""""""""""""""""""
" Syntastic!!
" npm i -g jshint eslint babel-eslint eslint-plugin-react eslint_d tslint
Plugin 'scrooloose/syntastic'
Plugin 'ruanyl/vim-fixmyjs'

let g:syntastic_error_symbol = "✗"
let g:syntastic_warning_symbol = "⚠"

let g:syntastic_json_checkers = ["jshint"]

let g:syntastic_javascript_checkers = ["eslint"]
let g:syntastic_javascript_eslint_exec = 'eslint_d'

nnoremap <Leader>f :Fixmyjs<CR>

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1

let g:syntastic_typescript_checkers = ["eslint"]
let g:syntastic_typescript_tsc_fname = ''

autocmd BufRead,BufEnter,BufNew *.jsx             let b:syntastic_checkers = ["eslint"]
autocmd BufRead,BufEnter,BufNew *.ts              let b:syntastic_checkers = ["tslint"]
autocmd BufRead,BufEnter .babelrc                 let b:syntastic_checkers = ["jshint"]
autocmd BufRead,BufEnter *.json                   let b:syntastic_checkers = ["jshint"]
autocmd BufRead,BufEnter,BufNew */kendo-*/*.js    let b:syntastic_checkers = ["eslint"]

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

"ctrlp
Plugin 'kien/ctrlp.vim'

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

call vundle#end()            " required
filetype plugin indent on    " required

""""""""""""""""""""""""""""""""""""""

nnoremap <F8> :setlocal spell! spell? <CR>

colorscheme molokai
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
autocmd BufRead,BufNewFile *.md          set filetype=markdown

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

" cyrillic langmap
set langmap =Ч~,ЯQ,ВW,ЕE,РR,ТT,ЪY,УU,ИI,ОO,ПP,Ш{,Щ},АA,СS,ДD,ФF,ГG,ХH,ЙJ,КK,ЛL,ЗZ,ЬZ,ЦC,ЖV,БB,НN,МM,ч`,яq,вw,еe,рr,тt,ъy,уu,иi,оo,пp,ш[,щ],аa,сs,дd,фf,гg,хh,йj,кk,лl,зz,ьz,цc,жv,бb,нn,мm
