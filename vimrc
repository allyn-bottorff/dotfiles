set nocompatible

call plug#begin()
Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'sheerun/vim-polyglot'
"Plug 'ycm-core/YouCompleteMe'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tmhedberg/SimpylFold'
Plug 'dense-analysis/ale'
Plug 'airblade/vim-gitgutter'
Plug 'mustache/vim-mustache-handlebars'
Plug 'tpope/vim-surround'
Plug 'vim-python/python-syntax'

call plug#end()

set shell=/bin/zsh

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set cc=80
set tw=79
set cursorline

set number
set ignorecase
set smartcase

set laststatus=2
set hlsearch
set backspace=indent,start



inoremap fd <ESC>
nnoremap fd <ESC>
nnoremap ; :Buffers<CR>
tnoremap fd <C-\><C-n>

command PrettyJson %!python -m json.tool

set background=dark
colorscheme solarized

let g:ale_lint_on_insert_leave = 1

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

let g:SimpylFold_docstring_preview = 1
let g:mustache_abbreviations = 1

