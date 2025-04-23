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

vim.o.termguicolors = true
vim.o.winblend = 20
vim.o.cc = "80"
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

vim.g.zig_fmt_autosave = false

vim.g.tex_flavor = "latex"

vim.g.codeium_enabled = false

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
	pattern = { "asciidoc", "norg" },
	command = "setlocal spell",
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "asciidoc", "tex" },
	command = "setlocal tw=79",
})

-- LOCAL USER COMMANDS
vim.api.nvim_create_user_command("RevLine", function()
	insert_asciidoc_rev_line()
end, { desc = "Insert an AsciiDoc revision line with the current date" })

vim.api.nvim_create_user_command(
	"AsciiArchPDF",
	"!asciidoctor-pdf -a pdf-theme=arch -a pdf-themesdir=asciidoctor-themes -a pdf-fontsdir=fonts %",
	{
		desc = "Generate a pdf from the currently open asciidoc file. Assumes the architecture theme and fonts dir is available",
	}
)
-- vim.api.nvim_buf_create_user_command(0, 'Format', vim.lsp.buf.format, {})

-- KEYMAPS
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set("t", "fd", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set({ "n", "i", "v" }, "fd", "<ESC>", { desc = "Exit modes" })
-- vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
-- vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
-- vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
-- vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic error messages" })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[R]e[n]ame" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.rename, { desc = "[C]ode [A]ction" })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "[G]oto [D]efinition" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "[G]oto [R]eferences" })
vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, { desc = "Type [D]efinition" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Definition" })
vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature Documentation" })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Goto Declaration" })
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
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
			"3rd/image.nvim",
		},
	},
	{ "numToStr/Comment.nvim", opts = {} }, -- 'gc' to auto comment
	"sebdah/vim-delve",
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
		"junegunn/fzf.vim",
		dependencies = { "junegunn/fzf" },
	},
	"tpope/vim-fugitive",
	{
		"AlexvZyl/nordic.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("nordic")
		end,
	},
	-- {
	-- 	"ellisonleao/gruvbox.nvim",
	-- 	priority = 1000,
	-- 	config = true,
	-- 	opts = ...,
	-- },
	-- {
	-- 	"scebai/glacier.vim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.cmd.colorscheme("glacier")
	-- 	end,
	-- },
	-- {
	-- 	"rebelot/kanagawa.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.cmd.colorscheme("kanagawa-lotus")
	-- 	end,
	-- },
	-- {
	-- 	"sainnhe/sonokai",
	-- 	-- lazy = false,
	-- 	-- priority = 1000,
	-- 	-- config = function()
	-- 	-- 	vim.cmd.colorscheme("sonokai")
	-- 	-- end,
	-- },
	-- {
	-- 	"navarasu/onedark.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.cmd.colorscheme("onedark")
	-- 	end,
	-- },
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
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{ "j-hui/fidget.nvim", opts = {} },
		},
		config = function()
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
			local servers = {
				gopls = {},
				pyright = {},
				rust_analyzer = {},
				lua_ls = {
					settings = {
						Lua = {
							runtime = { version = "LuaJIT" },
							workspace = {
								checkThirdParty = false,
								library = {
									"${3rd}/luv/library",
									unpack(vim.api.nvim_get_runtime_file("", true)),
								},
								-- If lua_ls is really slow on your computer, you can try this instead:
								-- library = { vim.env.VIMRUNTIME },
							},
							completion = {
								callSnippet = "Replace",
							},
						},
					},
				},
			}
			require("mason").setup()
			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua",
				"zls",
			})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},
	{
		"Exafunction/codeium.vim",
		event = "BufEnter",
	},
	{
		"joshuavial/aider.nvim",
		opts = {
			-- your configuration comes here
			-- if you don't want to use the default settings
			auto_manage_context = true, -- automatically manage buffer context
			default_bindings = true, -- use default <leader>A keybindings
			debug = false, -- enable debug logging
		},
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
			"kirasok/cmp-hledger",

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
	{ -- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			-- [[ Configure Treesitter ]] See `:help nvim-treesitter`

			---@diagnostic disable-next-line: missing-fields
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"bash",
					"c",
					"html",
					"lua",
					"markdown",
					"vim",
					"vimdoc",
					"go",
					"python",
					"rust",
					"dockerfile",
					"gitignore",
					"hcl",
					"json",
					"latex",
					"make",
					"markdown",
					"sql",
					"toml",
					"yaml",
					"terraform",
					"proto",
					"kdl",
					"javascript",
					"typescript",
					"zig",
				},
				-- Autoinstall languages that are not installed
				-- auto_install = true,
				highlight = { enable = true },
				indent = { enable = true },
			})

			-- There are additional nvim-treesitter modules that you can use to interact
			-- with nvim-treesitter. You should go explore a few and see what interests you:
			--
			--    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
			--    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
			--    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
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
})
