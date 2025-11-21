-- VIM OPTIONS
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.number = true
vim.opt.mouse = "a"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = "> ", trail = "·", nbsp = "␣", lead = "·", eol = "¬" }
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.hlsearch = true

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldenable = false

vim.o.winblend = 20
vim.o.cc = "80"
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

vim.g.zig_fmt_autosave = false
vim.g.tex_flavor = "latex"
vim.g.netrw_liststyle = 3



-- LOCAL FUNCTIONS
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


-- AUTO COMMANDS (NON-LSP)
vim.api.nvim_create_autocmd("TermOpen", { command = "setlocal nonumber" })
vim.api.nvim_create_autocmd("TermOpen", { command = "setlocal signcolumn=no" })
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    -- This buffer-local variable tells mini.indentscope to disable itself
    vim.b.miniindentscope_disable = true
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "python", "go", "zig" },
  callback = settabspace4,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "python", "yaml", "zig", "terraform" },
  command = "setlocal expandtab",
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "yaml", "terraform", "lua", "json" },
  callback = settabspace2,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "asciidoc", "norg", "typst", "markdown" },
  command = "setlocal spell",
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "asciidoc", "tex", "typst", "markdown" },
  command = "setlocal tw=79",
})

-- LOCAL USER COMMANDS


-- KEYMAPS
vim.keymap.set("t", "fd", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set({ "n", "i", "v" }, "fd", "<ESC>", { desc = "Exit modes" })
vim.keymap.set("n", "<leader>f", ":Files<CR>", { silent = true, desc = "FZF Files" })
vim.keymap.set("n", "<leader>b", ":Buffers<CR>", { silent = true, desc = "FZF Buffers" })
vim.keymap.set("n", "<leader>g", ":GitFiles<CR>", { silent = true, desc = "FZF GitFiles" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic error message" })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to definition" })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP Rename" })



-- Old themes
-- "vague-theme/vague.nvim",
-- "tahayvr/matteblack.nvim",
-- "jacoborus/tender.vim",
-- "rebelot/kanagawa.nvim",
-- "AlexvZyl/nordic.nvim",
-- "navarasu/onedark.nvim",
-- "cocopon/iceberg.vim",

-- PLUGINS
-- INSTALL LAZY
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- PLUGIN LIST
require("lazy").setup({
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("colorscheme carbonfox")
    end
  },
  "sebdah/vim-delve",      -- Go debugging
  "tpope/vim-fugitive",    -- Git integration (mostly just for Blame)
  "junegunn/fzf.vim",      -- fuzzy finding file/buffer stuff
  "junegunn/fzf",          -- fuzzy finding file/buffer stuff
  "numToStr/Comment.nvim", -- 'gc' to auto comment
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
    },
  },
  {
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = false },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "j-hui/fidget.nvim" },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      notify_on_error = false,
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
      formatters_by_ft = {
        lua = { "stylua" },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "main",
    build = ":TSUpdate",
    opts = {
      indent = {
        enable = true
      },
      ensure_installed = { 'lua', 'rust', 'go', 'json', 'yaml', 'markdown', 'markdown_inline', 'typst', 'zig', "hcl" },
      auto_install = true,
      highlight = {
        enable = true
      }
    }
  },
  {
    "zk-org/zk-nvim",
    config = function()
      require("zk").setup({
        picker = "select",
        lsp = {
          config = {
            name = "zk",
            cmd = { "zk", "lsp" },
            filetypes = { "markdown" },
          },
          auto_attach = {
            enabled = true,
          },
        },
      })
    end
  },
  {
    "nvim-mini/mini.indentscope",
    version = "*",
    config = function()
      require("mini.indentscope").setup {
        draw = {
          animation = require("mini.indentscope").gen_animation.none()
        },
        symbol = "│",
      }
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" }
  },
  {
    "leoluz/nvim-dap-go",
    config = function()
      require("dap-go").setup()
    end,

  }
})


-- DAP Config
local dap, dapui = require("dap"), require("dapui")
dap.listeners.before.attach.dapui_config = function()
  dapui.setup()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.setup()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

-- LSP Config

vim.lsp.enable({ 'rust_analyzer' })
vim.lsp.enable({ 'gopls' })
vim.lsp.enable({ 'ty' })
vim.lsp.enable({ 'zls' })
vim.lsp.enable({ 'ruff' })
vim.lsp.enable({ 'terraformls' })
vim.lsp.enable({ 'lua_ls' })


vim.cmd [[set completeopt=fuzzy,menuone,noinsert,popup]]

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})
