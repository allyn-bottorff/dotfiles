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
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'airblade/vim-gitgutter'
Plug 'mustache/vim-mustache-handlebars'
Plug 'tpope/vim-surround'

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

let g:ale_lint_on_insert_leave = 1

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

let g:SimpylFold_docstring_preview = 1
let g:mustache_abbreviations = 1

" Python virtualenv support
python3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    acticate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF
