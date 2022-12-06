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
"Plug 'ludovicchabant/vim-gutentags'
Plug 'tpope/vim-commentary'
"Plug 'zhaozg/vim-diagram'
"Plug 'vim-test/vim-test'

"Plug 'davidhalter/jedi-vim'
"Plug 'HallerPatrick/py_lsp.nvim'
Plug 'tweekmonster/gofmt.vim'
Plug 'ziglang/zig.vim'
Plug 'mfussenegger/nvim-dap'
Plug 'leoluz/nvim-dap-go'
Plug 'sebdah/vim-delve'
Plug 'simrat39/rust-tools.nvim'
Plug 'rust-lang/rust.vim'

Plug 'habamax/vim-asciidoctor'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'lifepillar/vim-solarized8'
Plug 'morhetz/gruvbox'
Plug 'altercation/vim-colors-solarized'
Plug 'marko-cerovac/material.nvim'
call plug#end()


let g:python3_host_prog='/usr/local/bin/python3'

let g:rustfmt_autosave = 1

set shell=/bin/zsh

set tabstop=4
set shiftwidth=4

set nohidden
set list
set listchars=eol:¬,trail:·,tab:>\ ,lead:·

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
command Bd bp\|bd \#
command InspectCert %!step certificate inspect

set termguicolors
colorscheme gruvbox
set winblend=20

"colorscheme material
"let g:material_style = "darker"



let g:airline_powerline_fonts = 1
let g:airline_extensions#tabline = 1
"let g:airline_theme='base16_material'

"GUI Config
let g:neovide_cursor_animation_length=0
"let g:neovide_cursor_trail_size=0.8
"set guifont=Source\ Code\ Pro\ Medium:h16
"set guifont=Hack:h15
"set guifont=Noto\ Mono\ for\ Powerline:h14
set guifont=Berkeley\ Mono\ Variable:h13

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
  incremental_selection = {
	  enable = true,
  },
  --indent = {
  --    enable = true,
  --},
}

--LSP Config
--require'py_lsp'.setup {}
--local nvim_lsp = require('lspconfig')
--local on_attach = function(client, bufnr)
--        local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
--        local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end 
--        buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
--
--        local opts = { noremap=true, silent=true }
--
--	buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
--	buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
--	buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
--	buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
--	buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
--	buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
--	buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
--	buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
--	buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
--	buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
--	buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
--	buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
--	buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
--	buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
--	buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
--	buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
--	buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
--end
--
--
--local servers = { 'pyright', 'gopls', 'tsserver', 'zls', 'ccls' }
----local servers = { 'pyright', 'gopls', 'tsserver', 'zls' }
--require('rust-tools').setup({})
--for _, lsp in ipairs(servers) do
--  nvim_lsp[lsp].setup {
--    on_attach = on_attach,
--    flags = {
--      debounce_text_changes = 150,
--    }
--  }
--end
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}
require('lspconfig')['pyright'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}
require('lspconfig')['tsserver'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}
require('lspconfig')['gopls'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}
require('lspconfig')['rust_analyzer'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    -- Server-specific settings...
    settings = {
      ["rust-analyzer"] = {}
    }
}
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
" silent! so .vimlocal

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable



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
