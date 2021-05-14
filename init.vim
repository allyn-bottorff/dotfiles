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
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'PProvost/vim-ps1'
Plug 'rust-lang/rust.vim'
Plug 'habamax/vim-asciidoctor'
"Plug 'lifepillar/vim-solarized8'
Plug 'jparise/vim-graphql'
"Plug 'neovim/nvim-lspconfig'
call plug#end()

"LUA stuff

"lua << EOF
"require'lspconfig'.pyright.setup{}
"EOF


set shell=/bin/zsh

set tabstop=4
set softtabstop=4
set shiftwidth=4
autocmd FileType yaml setlocal tabstop=2
autocmd FileType yaml setlocal softtabstop=2
autocmd FileType yaml setlocal shiftwidth=2

autocmd FileType asciidoc setlocal spell
autocmd FileType asciidoc setlocal textwidth=79

set expandtab
set cc=80
"set tw=79
set cursorline

set mouse=a
set clipboard=unnamed
set number
set ignorecase
set smartcase

set laststatus=2

set updatetime=100

inoremap fd <ESC>
nnoremap fd <ESC>
nnoremap ; :Buffers<CR>
tnoremap fd <C-\><C-n>

command PrettyJson %!python -m json.tool

set background=dark
if has('gui_running')
    colorscheme solarized8_high
else
    let g:solarized_contrast='high'
    colorscheme solarized
endif
"let g:solarized_termcolors=256
let g:solarized_extra_hi_groups=1
"colorscheme solarized

let g:neovide_cursor_animation_length=0.07
let g:ale_lint_on_insert_leave = 1

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

"let g:mkdp_browser='firefox'
let g:SimpylFold_docstring_preview = 1
let g:gitgutter_set_sign_backgrounds = 1
" let g:mustache_abbreviations = 1
" let g:lightline = {
"       \ 'colorscheme': 'solarized',
"       \ 'active': {
"       \   'left': [ [ 'mode', 'paste' ],
"       \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
"       \ },
"       \ 'component_function': {
"       \   'gitbranch': 'fugitive#head'
"       \ },
"       \ }
augroup custom_term
    autocmd!
    autocmd TermOpen * setlocal bufhidden=hide
augroup END
set guifont=Fira\ Code:h16
" Python virtualenv support
python3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF
