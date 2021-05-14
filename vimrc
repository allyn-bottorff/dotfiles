set nocompatible

call plug#begin()

Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'do' : { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
"Plug 'dense-analysis/ale'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug'] }
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-surround'
Plug 'davidhalter/jedi-vim'
Plug 'ervandew/supertab'
Plug 'preservim/nerdcommenter'
"Plug 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
"Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'PProvost/vim-ps1'
Plug 'rust-lang/rust.vim'
Plug 'habamax/vim-asciidoctor'
Plug 'lifepillar/vim-solarized8'
Plug 'jparise/vim-graphql'
call plug#end()

set shell=/bin/zsh

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

autocmd FileType yaml setlocal tabstop=2
autocmd FileType yaml setlocal softtabstop=2
autocmd FileType yaml setlocal shiftwidth=2

autocmd FileType asciidoc setlocal spell
autocmd FileType asciidoc setlocal textwidth=79

set cc=80
"set tw=79
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

