-- VIM OPTIONS
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.number = true
-- vim.opt.mouse = "a"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
-- vim.opt.updatetime = 250
vim.opt.splitright = true
vim.opt.splitbelow = true
-- vim.opt.list = true
vim.opt.listchars = { tab = "> ", trail = "·", nbsp = "␣", lead = "·", eol = "¬" }
vim.opt.cursorline = true
vim.opt.scrolloff = 10
-- vim.opt.hlsearch = true
vim.o.statuscolumn = "%s%l  "

-- force the NVIM env var to be present no matter how we're creating the subshell
-- i.e. both terminal buffers as well as normal mode shell commands
vim.env.NVIM = vim.v.servername

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldenable = false

vim.o.winblend = 20
-- vim.o.cc = "80"
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

vim.g.zig_fmt_autosave = false
vim.g.tex_flavor = "latex"
vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = 30



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


local function open_lsp_docs_in_split()
    local params = vim.lsp.util.make_position_params()
    
    vim.lsp.buf_request(0, 'textDocument/hover', params, function(err, result, ctx, config)
        if err or not result or not result.contents then
            vim.notify("No documentation available", vim.log.levels.INFO)
            return
        end

        local contents = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
        if vim.tbl_isempty(contents) then return end

        -- 1. Create the buffer
        local buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, contents)
        
        -- 2. Set BUFFER-local options (using buf = buf)
        local b_opts = { buf = buf }
        vim.api.nvim_set_option_value('filetype', 'markdown', b_opts)
        vim.api.nvim_set_option_value('buftype', 'nofile', b_opts)
        vim.api.nvim_set_option_value('bufhidden', 'wipe', b_opts)
        vim.api.nvim_set_option_value('modifiable', false, b_opts)

        -- 3. Open the split and set the buffer
        local line_count = #contents
        local split_height = math.min(math.max(line_count, 5), 20)
        vim.cmd('topleft ' .. split_height .. 'split')
        vim.api.nvim_set_current_buf(buf)

        -- 4. Set WINDOW-local options (using win = 0 for current window)
        local w_opts = { win = 0 }
        vim.api.nvim_set_option_value('wrap', true, w_opts)
        vim.api.nvim_set_option_value('spell', false, w_opts) -- Bonus: disable spellcheck in docs

        -- 5. Map 'q' to close
        vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = buf, silent = true })
    end)
end

vim.keymap.set('n', '<leader>k', open_lsp_docs_in_split, { desc = 'LSP docs in dynamic split' })

vim.keymap.set('n', '<leader>k', open_lsp_docs_in_split, { desc = 'LSP docs in dynamic split' })



-- Map this to <leader>k (leaving K free for your usual hover)
vim.keymap.set('n', '<leader>k', open_lsp_docs_in_split, { desc = 'LSP docs in split' })


-- AUTO COMMANDS (NON-LSP)
--
-- Make terminals nicer
vim.api.nvim_create_autocmd("TermOpen", { command = "setlocal nonumber" })
vim.api.nvim_create_autocmd("TermOpen", { command = "setlocal signcolumn=no" })
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    -- This buffer-local variable tells mini.indentscope to disable itself
    vim.b.miniindentscope_disable = true
  end,
})

-- Set some filetype preferences including spellchecks and tabs/spaces
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

-- Make the cursorline "move" with the focused window
vim.api.nvim_create_autocmd("WinLeave", {
  pattern = { "*" },
  command = "set nocursorline",
})

vim.api.nvim_create_autocmd("WinEnter", {
  pattern = { "*" },
  command = "set cursorline",
})
-- LOCAL USER COMMANDS


-- Formatting
vim.api.nvim_create_user_command("Format", function()
-- Define your formatters here: [filetype] = "shell command"
    local formatters = {
        go = "gofmt -w %",
        python = "black %",
        lua = "stylua %",
        rust = "rustfmt %",
        terraform = "terraform fmt %",
        hcl = "terraform fmt %",
        ["terraform-vars"] = "terraform fmt %",
    }
    local ft = vim.bo.filetype
    local cmd = formatters[ft]

    if cmd then
        vim.cmd("silent write") -- write the file
        vim.cmd("silent !" .. cmd) -- auto-format
        vim.cmd("edit!") -- reload from disk
        print("Formatted with " .. ft .. " formatter")
    else
        print("No formatter configured for filetype: " .. ft)
    end
end, { desc = "Format current file based on filetype" })


-- KEYMAPS
vim.keymap.set("t", "fd", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set({ "n", "i", "v" }, "fd", "<ESC>", { desc = "Exit modes" })
vim.keymap.set("n", "<leader>f", ":Files<CR>", { silent = true, desc = "FZF Files" })
vim.keymap.set("n", "<leader>b", ":Buffers<CR>", { silent = true, desc = "FZF Buffers" })
vim.keymap.set("n", "<leader>g", ":GitFiles<CR>", { silent = true, desc = "FZF GitFiles" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic error message" })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to definition" })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP Rename" }) -- Default was 'grn'. I can't make that stick in my head

-- Neovide Settins

vim.g.neovide_scroll_animation_length = 0.08
vim.g.neovide_position_animation_length = 0.2
vim.g.neovide_cursor_animation_length = 0
vim.g.neovide_cursor_short_animation_length = 0
vim.g.neovide_floating_z_height = 20
vim.o.guifont = "TX-02:h15"


vim.pack.add({
  "https://github.com/EdenEast/nightfox.nvim",
  "https://github.com/ellisonleao/gruvbox.nvim",
  "https://github.com/sebdah/vim-delve",      -- Go debugging
  "https://github.com/tpope/vim-fugitive",    -- Git integration (mostly just for Blame)
  "https://github.com/junegunn/fzf.vim",      -- fuzzy finding file/buffer stuff
  "https://github.com/junegunn/fzf",          -- fuzzy finding file/buffer stuff
  "https://github.com/numToStr/Comment.nvim", -- 'gc' to auto comment
  "https://github.com/rcarriga/nvim-dap-ui",
  "https://github.com/mfussenegger/nvim-dap",
  "https://github.com/nvim-neotest/nvim-nio",
  "https://github.com/leoluz/nvim-dap-go",
  "https://github.com/zk-org/zk-nvim",
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/j-hui/fidget.nvim",
  "https://github.com/folke/todo-comments.nvim",
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/nvim-mini/mini.indentscope",
  "https://github.com/willothy/flatten.nvim",
  "https://github.com/krisajenkins/neojj",
  "https://github.com/nvim-lua/plenary.nvim",
})


-- PLUGIN SETUP
require("neojj").setup()
require("fidget").setup()
require("dap-go").setup()
require("mini.indentscope").setup {
  draw = { animation = require("mini.indentscope").gen_animation.none() },
  symbol = "│",
}

require("gitsigns").setup {
  signs = {
    add = { text = "+" },
    change = { text = "~" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
  }
}
require("gruvbox").setup {
  contrast = "hard",
  overrides = {
    SignColumn = { bg = "#1d2021" }
  },
}
require("flatten").setup()

vim.cmd("colorscheme gruvbox")
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

vim.lsp.enable({
  -- 'rust_analyzer',
  'gopls',
  'ty',
  'zls',
  'ruff',
  -- 'terraformls',
  'lua_ls',
  -- 'kotlin_language_server',
})


vim.cmd [[set completeopt=fuzzy,menuone,noinsert,popup]]

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})


-- lua_ls VIM support
vim.lsp.config('lua_ls', {
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if
          path ~= vim.fn.stdpath('config')
          and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
      then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using (most
        -- likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Tell the language server how to find Lua modules same way as Neovim
        -- (see `:h lua-module-load`)
        path = {
          'lua/?.lua',
          'lua/?/init.lua',
        },
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME
          -- Depending on the usage, you might want to add additional paths
          -- here.
          -- '${3rd}/luv/library'
          -- '${3rd}/busted/library'
        }
        -- Or pull in all of 'runtimepath'.
        -- NOTE: this is a lot slower and will cause issues when working on
        -- your own configuration.
        -- See https://github.com/neovim/nvim-lspconfig/issues/3189
        -- library = {
        --   vim.api.nvim_get_runtime_file('', true),
        -- }
      }
    })
  end,
  settings = {
    Lua = {}
  }
})
