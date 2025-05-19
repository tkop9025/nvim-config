-- ~/.config/nvim/lua/plugins/init.lua

return {
	-- Plugin manager utilities
	{ "nvim-lua/plenary.nvim" },

	-- UI
	{ "nvim-lualine/lualine.nvim" },
	{ "yazeed1s/minimal.nvim" },
	{ "vague2k/vague.nvim", priority = 1000 },

	-- Core tools
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	{ "nvim-telescope/telescope.nvim" },
	{ "jvgrootveld/telescope-zoxide" },
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
		cond = vim.fn.executable("make") == 1,
	},

	-- LSP and language tools
	{ "neovim/nvim-lspconfig" },
	{ "williamboman/mason.nvim", config = true },
	{ "williamboman/mason-lspconfig.nvim", config = true },

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
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
					if ok and stats and stats.size > max_size then
						return
					end
					return { timeout_ms = 1000, lsp_fallback = true }
				end,
				formatters_by_ft = {
					python = { "black" },
					lua = { "stylua" },
					markdown = { "prettier" },
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
				c = { "clangtidy" },
				cpp = { "clangtidy" },
				sh = { "shellcheck" },
			}

			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function()
					lint.try_lint()
				end,
			})
		end,
	},

	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
		event = "InsertEnter",
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			cmp.setup({
				window = {
					completion = cmp.config.window.bordered({
						winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:PmenuSel",
						max_height = 10, -- limit number of visible items
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
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
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
	{ "mikavilpas/yazi.nvim" },
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

	--zk
	{
		"zk-org/zk-nvim",
		branch = "fix/client-nil-error",

		config = function()
			require("zk").setup()
		end,
	},
}
