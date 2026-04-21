-- ~/.config/nvim/lua/core/treesitter.lua

require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"lua",
		"bash",
		"python",
		"c",
		"json",
		"yaml",
		"markdown",
		"html",
		"css",
		"javascript",
	},
	highlight = {
		enable = true,
	},
	indent = {
		enable = true,
	},
})
