call plug#begin()
Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'sheerun/vim-polyglot'
Plug 'ycm-core/YouCompleteMe'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tmhedberg/SimpylFold'
Plug 'dense-analysis/ale'

call plug#end()

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



inoremap fd <ESC>
nnoremap fd <ESC>
nnoremap ; :Buffers<CR>
tnoremap fd <C-\><C-n>

command PrettyJson %!python -m json.tool

set background=dark
colorscheme solarized

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
