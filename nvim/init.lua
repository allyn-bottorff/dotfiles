-- VIM OPTIONS
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.number = true
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.splitright = true
vim.opt.splitbelow = true
-- vim.opt.list = true
vim.opt.listchars = { tab = "> ", trail = "·", nbsp = "␣", lead = "·", eol = "¬" }
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.hlsearch = false

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


-- Create an Asciidoctor revline with the current date and work info
local function insert_asciidoc_rev_line()
	local date = os.date("%Y-%m-%d")
	local rev_line_1 = "Allyn L. Bottorff <allyn.bottorff@veteransunited.com>"
	local rev_line_2 = "1.0, " .. date
	vim.api.nvim_put({ rev_line_1, rev_line_2, "" }, "l", true, true)
end

-- AUTO COMMANDS
vim.api.nvim_create_autocmd("TermOpen", { command = "setlocal nonumber" })
vim.api.nvim_create_autocmd("TermOpen", { command = "setlocal signcolumn=no" })
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
vim.api.nvim_create_user_command("RevLine", function()
	insert_asciidoc_rev_line()
end, { desc = "Insert an AsciiDoc revision line with the current date" })


-- KEYMAPS
vim.keymap.set("t", "fd", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set({ "n", "i", "v" }, "fd", "<ESC>", { desc = "Exit modes" })
vim.keymap.set("n", "<leader>f", ":Files<CR>", { silent = true, desc = "FZF Files" })
vim.keymap.set("n", "<leader>b", ":Buffers<CR>", { silent = true, desc = "FZF Buffers" })
vim.keymap.set("n", "<leader>g", ":GitFiles<CR>", { silent = true, desc = "FZF GitFiles" })

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
	"sebdah/vim-delve", -- Go debugging
	"tpope/vim-fugitive", -- Git integration (mostly just for Blame)
	"junegunn/fzf.vim", -- fuzzy finding file/buffer stuff
	"junegunn/fzf", -- fuzzy finding file/buffer stuff
	{ "numToStr/Comment.nvim", opts = {} }, -- 'gc' to auto comment
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
    "cocopon/iceberg.vim",
  },
  {
    "EdenEast/nightfox.nvim",
  },
	{
		"AlexvZyl/nordic.nvim",
		-- lazy = false,
		-- priority = 1000,
		config = function()
			vim.cmd.colorscheme("nordic")
		end,
	},
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			theme = "auto",
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "j-hui/fidget.nvim", opts = {} },
		},
		config = function()
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
		end,
	},
	{ -- Autocompletion
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			{
				"L3MON4D3/LuaSnip",
				build = (function()
					-- Build Step is needed for regex support in snippets
					-- This step is not supported in many windows environments
					-- Remove the below condition to re-enable on windows
					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),
			},
			"saadparwaiz1/cmp_luasnip",

			-- Adds other completion capabilities.
			--  nvim-cmp does not ship with all sources by default. They are split
			--  into multiple repos for maintenance purposes.
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",

			-- If you want to add a bunch of pre-configured snippets,
			--    you can use this plugin to help you. It even has snippets
			--    for various frameworks/libraries/etc. but you will have to
			--    set up the ones that are useful for you.
			-- 'rafamadriz/friendly-snippets',
		},
		config = function()
			-- See `:help cmp`
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			luasnip.config.setup({})

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				completion = { completeopt = "menu,menuone,noinsert" },

				-- For an understanding of why these mappings were
				-- chosen, you will need to read `:help ins-completion`
				--
				-- No, but seriously. Please read `:help ins-completion`, it is really good!
				mapping = cmp.mapping.preset.insert({
					-- Select the [n]ext item
					["<C-n>"] = cmp.mapping.select_next_item(),
					-- Select the [p]revious item
					["<C-p>"] = cmp.mapping.select_prev_item(),

					-- Accept ([y]es) the completion.
					--  This will auto-import if your LSP supports it.
					--  This will expand snippets if the LSP sent a snippet.
					["<C-y>"] = cmp.mapping.confirm({ select = true }),

					-- Manually trigger a completion from nvim-cmp.
					--  Generally you don't need this, because nvim-cmp will display
					--  completions whenever it has completion options available.
					["<C-Space>"] = cmp.mapping.complete({}),

					-- Think of <c-l> as moving to the right of your snippet expansion.
					--  So if you have a snippet that's like:
					--  function $name($args)
					--    $body
					--  end
					--
					-- <c-l> will move you to the right of each of the expansion locations.
					-- <c-h> is similar, except moving you backwards.
					["<C-l>"] = cmp.mapping(function()
						if luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						end
					end, { "i", "s" }),
					["<C-h>"] = cmp.mapping(function()
						if luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						end
					end, { "i", "s" }),
				}),
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
				},
			})
		end,
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
    "greggh/claude-code.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim", -- Required for git operations
      },
      config = function()
        require("claude-code").setup({
          window = {
            position = "vertical"
          }
        })
      end
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
      ensure_installed = { 'lua', 'rust', 'go', 'json', 'yaml', 'markdown', 'markdown_inline', 'typst', 'zig' },
      auto_install = true,
      highlight = {
        enable = true
      }
    }
  }
})

vim.cmd.colorscheme("nightfox")

-- LSP Config

vim.lsp.enable('rust_analyzer')
vim.lsp.config('rust_analyzer', {
  settings = {
    ['rust-analyzer'] = {},
  },
})

vim.lsp.enable('gopls')
vim.lsp.enable('ty')
vim.lsp.enable('zls')
vim.lsp.enable('ruff')

vim.lsp.enable('tinymist')
vim.lsp.config['tinymist'] = {
  cmd = { "tinymist" },
  filetypes = {"typst"},
}

