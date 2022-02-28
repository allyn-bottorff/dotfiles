call plug#begin()
Plug 'junegunn/fzf', { 'do' : { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
"Plug 'ervandew/supertab'
"
Plug 'lifepillar/vim-mucomplete'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
Plug 'ludovicchabant/vim-gutentags'
"Plug 'zhaozg/vim-diagram'
"Plug 'vim-test/vim-test'

"Plug 'davidhalter/jedi-vim'
"Plug 'HallerPatrick/py_lsp.nvim'
Plug 'tweekmonster/gofmt.vim'
Plug 'ziglang/zig.vim'

Plug 'habamax/vim-asciidoctor'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'lifepillar/vim-solarized8'
Plug 'morhetz/gruvbox'
Plug 'altercation/vim-colors-solarized'
call plug#end()


let g:python3_host_prog='/usr/local/bin/python3'

set shell=/bin/zsh

set tabstop=4
set shiftwidth=4

autocmd FileType python,go,zig setlocal tabstop=4
autocmd FileType python,go,zig setlocal softtabstop=4
autocmd FileType python,go,zig setlocal shiftwidth=4
autocmd FileType python,yaml,zig setlocal expandtab
autocmd FileType yaml setlocal tabstop=2
autocmd FileType yaml setlocal softtabstop=2
autocmd FileType yaml setlocal shiftwidth=2
autocmd FileType asciidoc setlocal spell
autocmd FileType asciidoc setlocal textwidth=79
autocmd TermOpen * setlocal nonumber

"set expandtab
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

"augroup ON_ASCIIDOCTOR_SAVE | au!
"	au BufWritePost *.adoc :Asciidoctor2HTML
"augroup end

"command PrettyJson %!python -m json.tool
command PrettyJson set syntax=json | %!jq "."
command Gfiles GFiles
command Gf GFiles

set termguicolors
colorscheme gruvbox
set winblend=20

let g:airline_powerline_fonts = 1
let g:airline_extensions#tabline = 1

"GUI Config
let g:neovide_cursor_animation_length=0.03
"set guifont=Source\ Code\ Pro\ Medium:h16
set guifont=Hack:h15

"Fugitive options
set diffopt+=vertical

"LUA config stuff
lua <<EOF
--Treesitter Config
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    custom_captures = {
      -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
      ["foo.bar"] = "Identifier",
    },
  },
}

--LSP Config
--require'py_lsp'.setup {}
local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
        local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
        local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end 
        buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

        local opts = { noremap=true, silent=true }

	buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
	buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
	buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
	buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
	buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
	buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
	buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
	buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
	buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
	buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
	buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end


--local servers = { 'jedi_language_server', 'gopls', 'tsserver', 'zls', 'ccls' }
local servers = { 'pyright', 'gopls', 'tsserver', 'zls', 'ccls' }
--local servers = { 'pyright', 'gopls', 'tsserver', 'zls' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

EOF

"MuComplete settings

set completeopt+=menuone
set completeopt+=noselect

" Supertab use omnicomplete
"let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
"
"autocmd FileType *
"  \ if &omnifunc != '' |
"  \   call SuperTabChain(&omnifunc, "<c-p>") |
"  \ endif


" Local project settings support
silent! so .vimlocal



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
