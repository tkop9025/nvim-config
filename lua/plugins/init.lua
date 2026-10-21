-- ~/.config/nvim/lua/plugins/init.lua
return {
	-- Plugin manager utilities
	{ "nvim-lua/plenary.nvim" },

	-- UI
	{ "nvim-lualine/lualine.nvim" },
	{ "yazeed1s/minimal.nvim" },

	-- Core tools
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	{ "nvim-telescope/telescope.nvim" },
	{ "jvgrootveld/telescope-zoxide" },
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
		cond = vim.fn.executable("make") == 1,
	},

	{
		"rcarriga/nvim-notify",
		lazy = false,
		priority = 10000,
		config = function()
			local notify = require("notify")
			notify.setup({
				render = "minimal",
				stages = "static",
				timeout = 4000,
				top_down = false,
			})
			vim.notify = notify
		end,
	},

	-- Markdown Rendering
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {
			completions = { lsp = { enabled = true } },
		},
	},
	-- mini icons for markdown rendering
	{ "echasnovski/mini.icons", version = false },

	-- LSP and language tools
	{ "neovim/nvim-lspconfig" },
	{ "mason-org/mason.nvim", config = true },
	{ "mason-org/mason-lspconfig.nvim", config = true },

	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		event = "VeryLazy",
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					-- LSP servers
					"pyright",
					"clangd",
					"lua-language-server",
					"marksman",
					"html-lsp",
					"css-lsp",
					"json-lsp",
					"typescript-language-server",
					"bash-language-server",

					-- Formatters
					"black",
					"stylua",
					"prettier",
					"clang-format",
					"shfmt",

					-- Linters
					"flake8",
					"luacheck",
					"markdownlint",
					"shellcheck",
					"cpplint",
				},
				auto_update = false,
				run_on_start = true,
				start_delay = 3000, -- in ms
			})
		end,
	},

	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		config = function()
			require("conform").setup({
				format_on_save = function(bufnr)
					local max_size = 100 * 1024
					local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(bufnr))
					if ok and stats and stats.size > max_size then
						return
					end
					return { timeout_ms = 1000, lsp_format = "fallback" }
				end,
				formatters_by_ft = {
					python = { "black" },
					lua = { "stylua" },
					markdown = { "prettier" },

					html = { "prettier" },
					css = { "prettier" },
					javascript = { "prettier" },
					javascriptreact = { "prettier" },
					typescript = { "prettier" },
					typescriptreact = { "prettier" },
					json = { "prettier" },

					c = { "clang_format" },
					cpp = { "clang_format" },
					sh = { "shfmt" },
				},
			})
		end,
	},
	{
		"mfussenegger/nvim-lint",
		event = { "BufWritePost" },
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				python = { "flake8" },
				lua = { "luacheck" },
				markdown = { "markdownlint" },
				c = { "cpplint" },
				cpp = { "cpplint" },
				sh = { "shellcheck" },
			}

			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function()
					lint.try_lint()
				end,
			})
		end,
	},

	{ "rafamadriz/friendly-snippets" },

	{
		"L3MON4D3/LuaSnip",
		dependencies = { "rafamadriz/friendly-snippets" },
		version = "v2.*",
		build = "make install_jsregexp",
	},

	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"saadparwaiz1/cmp_luasnip",
			"L3MON4D3/LuaSnip",
		},
		event = "InsertEnter",
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			cmp.setup({
				preselect = cmp.PreselectMode.None,
				completion = {
					completeopt = "menu,menuone,noselect",
				},
				confirmation = {
					get_commit_characters = function()
						return {}
					end,
				},
				window = {
					completion = cmp.config.window.bordered({
						winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:PmenuSel",
						max_height = 10, -- limit number of visible items
						completeopt = "menu,menuone,noselect",
					}),
					documentation = cmp.config.window.bordered(),
				},
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({ select = false }),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
				}, {
					{ name = "buffer" },
				}),
			})
			-- Optional: use completion in command-line mode (e.g. `:`)
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "path" },
					{ name = "cmdline" },
				},
			})
		end,
	},

	-- Utilities
	{ "numToStr/Comment.nvim", config = true },
	{
		"kylechui/nvim-surround",
		version = "^3.0.0",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Default
			})
		end,
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {
			disable_filetype = { "TelescopePrompt" },
		},
		config = function(_, opts)
			local npairs = require("nvim-autopairs")
			npairs.setup(opts)

			local present, cmp = pcall(require, "cmp")
			if present then
				local cmp_autopairs = require("nvim-autopairs.completion.cmp")
				cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
			end
		end,
	},
	-- Using lazy.nvim
	{
		"metalelf0/black-metal-theme-neovim",
		lazy = false,
		priority = 1000,
		config = function()
			require("black-metal").setup({
				-- optional configuration here
			})
			require("black-metal").load()
		end,
	},
	{
		"Julian/lean.nvim",
		event = { "BufReadPre *.lean", "BufNewFile *.lean" },

		dependencies = {
			-- optional dependencies:

			"nvim-telescope/telescope.nvim", -- for Lean-specific pickers
			-- 'andymass/vim-matchup',          -- for enhanced % motion behavior
			-- 'andrewradev/switch.vim',        -- for switch support
			-- 'tomtom/tcomment_vim',           -- for commenting
		},

		---@type lean.Config
		opts = { -- see the manual for full configuration options
			mappings = true,
		},
	},
}
