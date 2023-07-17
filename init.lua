---------------------------------------------------
-- Install Packer (bootstrap)
---------------------------------------------------
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
  vim.cmd [[packadd packer.nvim]]
end

---------------------------------------------------
-- Manage Plugins
---------------------------------------------------
require('packer').startup(function(use)
  -- Package manager
  use 'wbthomason/packer.nvim'

  -- Theme Plugins
  use 'morhetz/gruvbox'

  -- Status Line
  -- use 'nvim-lualine/lualine.nvim'

  -- Undo Tree
  -- use 'mbbill/undotree'

  -- LSP Configuration
  use {
    'neovim/nvim-lspconfig',
    requires = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      'j-hui/fidget.nvim',
    },
  }

  -- Autocompletion
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      },
    }
  -- use {
  --   'github/copilot.vim'
  -- }
  use {
    'zbirenbaum/copilot.lua',
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end,
  }
  use {
    'zbirenbaum/copilot-cmp',
    after = { 'copilot.lua' },
    config = function ()
      require('copilot_cmp').setup()
    end
  }

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
    config = function()
      require('nvim-treesitter.configs').setup {
        -- ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'typescript', 'bash', 'vim', 'dockerfile', 'css', 'gitignore', 'graphql', 'hcl', 'html', 'json', 'latex', 'make', 'markdown', 'sql', 'toml', 'yaml', 'zig', 'terraform', 'proto' },
        ensure_installed = { 'go', 'lua', 'python', 'rust', 'typescript', 'bash', 'vim', 'dockerfile', 'css', 'gitignore', 'graphql', 'hcl', 'html', 'json', 'latex', 'make', 'markdown', 'sql', 'toml', 'yaml', 'zig', 'terraform', 'proto' },
      highlight = { enable = true },
      incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<c-space>',
            node_incremental = '<c-space>',
            scope_incremental = '<c-s>',
            node_decremental = '<c-backspace>',
            },
          },
        }
      end
  }

  -- Git
  use 'tpope/vim-fugitive'
  use 'airblade/vim-gitgutter'
  -- use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }

  -- Comment 
  use {
      'numToStr/Comment.nvim', -- "gc" to comment visual regions/lines
      config = function()
          require('Comment').setup()
      end
  }

  -- FZF
  use {
    'junegunn/fzf',
    run = ":call fzf#install()",
    requires = {"junegunn/fzf.vim"}
  }

  -- Go tools
  use 'sebdah/vim-delve'

end)

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end


---------------------------------------------------
-- Vim Options
---------------------------------------------------

-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

-- Set colorscheme and visuals
vim.o.termguicolors = true
vim.cmd [[colorscheme gruvbox]]
vim.o.winblend = 20
vim.o.cc = "80"
vim.o.cursorline = true
vim.api.nvim_create_autocmd("TermOpen", { command = "setlocal nonumber" })
vim.api.nvim_create_autocmd("TermOpen", { command = "setlocal signcolumn=no" })
-- vim.o.listchars = "eol:¬,trail:·,tab:\>,lead:·"
-- vim.opt.listchars = { eol = '¬', trail = '·', tab = '>', lead = '·'}
vim.opt.listchars = { eol = '¬', trail = '·', tab = '> ', lead = '·'}
vim.o.list = true

-- Neovide settings
-- vim.o.guifont = "Berkeley Mono Variable:h12:#e-subpixelantialias:#h-slight"
vim.o.guifont = "Berkeley Mono Variable:h13"
vim.g.neovide_scroll_animation_length = 0.25
vim.g.neovide_cursor_animation_length = 0.01


-- tabstop stuff

vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
local function settabspace4()
  vim.o.tabstop = 4
  vim.o.softtabstop = 4
  vim.o.shiftwidth = 4
end

local function settabspace2()
  vim.o.tabstop = 2
  vim.o.softtabstop = 2
  vim.o.shiftwidth = 2
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = {"python", "go", "zig", "terraform"},
  callback = settabspace4,
  })
vim.api.nvim_create_autocmd("FileType", {
  pattern = {"python", "yaml", "zig", "terraform"},
  command = "setlocal expandtab",
  })
vim.api.nvim_create_autocmd("FileType", {
  pattern = {"yaml", "terraform", "lua"},
  callback = settabspace2,
 })
vim.api.nvim_create_autocmd("FileType", {
  pattern = {"asciidoc"},
  command = "setlocal spell",
 })
vim.api.nvim_create_autocmd("FileType", {
  pattern = {"asciidoc"},
  command = "setlocal tw=79",
 })

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Custom keymaps
vim.keymap.set({'n','i','v'}, 'fd', '<ESC>')
vim.keymap.set('t','fd', '<C-\\><C-n>')
-- vim.keymap.set('n', '<C-u>', '<C-u>zz')
-- vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<leader>f', ":Files<CR>")
vim.keymap.set('n', '<leader>g', ":GitFiles<CR>")
vim.keymap.set('n', '<leader>b', ":Buffers<CR>")


---------------------------------------------------
-- LSP Settings
---------------------------------------------------

local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  -- nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gr', vim.lsp.buf.references, '[G]oto [R]efereneces')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

local servers = {}


-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require('mason').setup()

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}

-- Turn on lsp status information
require('fidget').setup{
  text = {
    spinner = "dots",
  },
}

-- nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'
luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'copilot' },
  },
}


-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
