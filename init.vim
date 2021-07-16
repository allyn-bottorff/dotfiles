call plug#begin()
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'do' : { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'ervandew/supertab'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
"Plug 'neovim/nvim-lspconfig'

Plug 'davidhalter/jedi-vim'

Plug 'habamax/vim-asciidoctor'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'lifepillar/vim-solarized8'
Plug 'morhetz/gruvbox'
Plug 'altercation/vim-colors-solarized'
call plug#end()


let g:python3_host_prog='/usr/local/bin/python3'

set shell=/bin/zsh


autocmd FileType python set tabstop=4
autocmd FileType python set softtabstop=4
autocmd FileType python set shiftwidth=4
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

nnoremap <leader>d <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <leader>n <cmd>lua vim.lsp.buf.references()<CR>

command PrettyJson %!python -m json.tool

colorscheme gruvbox

let g:airline_powerline_fonts = 1
let g:airline_extensions#tabline = 1

"GUI Config
let g:neovide_cursor_animation_length=0.03
set guifont=Source\ Code\ Pro\ Medium:h16


" Treesitter Config
lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    custom_captures = {
      -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
      ["foo.bar"] = "Identifier",
    },
  },
}
EOF

"LSP config
"lua <<EOF
"require'lspconfig'.pyright.setup{}
"require'lspconfig'.rust_analyzer.setup{}
"EOF

" Python virtualenv support
"python3 << EOF
"import os
"import sys
"if 'VIRTUAL_ENV' in os.environ:
"    project_base_dir = os.environ['VIRTUAL_ENV']
"    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
"    execfile(activate_this, dict(__file__=activate_this))
"EOF
