-- ~/.config/nvim/lua/core/lsp.lua

-- Capabilities for all LSP clients (integrated with nvim-cmp)
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Optional: shared on_attach for keymaps / tweaks
local on_attach = function(client, bufnr)
	-- Example mappings (uncomment if you want them):
	-- local opts = { noremap = true, silent = true, buffer = bufnr }
	-- vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	-- vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

	-- Let conform.nvim / prettier handle formatting for TS/JS instead of ts_ls
	if client.name == "ts_ls" then
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
	end
end

-- MARKSMAN (Markdown)
vim.lsp.config("marksman", {
	capabilities = capabilities,
	on_attach = on_attach,
})

-- ZK (Markdown for zk-nvim)
-- You *can* omit this and let zk-nvim manage its own LSP,
-- but if you like having it here:
vim.lsp.config("zk", {
	capabilities = capabilities,
	on_attach = on_attach,
})

-- PYRIGHT (Python)
vim.lsp.config("pyright", {
	capabilities = capabilities,
	on_attach = on_attach,
})

-- CLANGD (C/C++)
vim.lsp.config("clangd", {
	capabilities = capabilities,
	on_attach = on_attach,
})

-- LUA_LS (Lua)
vim.lsp.config("lua_ls", {
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" }, -- avoid "vim" undefined
			},
			workspace = {
				checkThirdParty = false,
			},
			telemetry = {
				enable = false,
			},
		},
	},
})

-- HTML
vim.lsp.config("html", {
	capabilities = capabilities,
	on_attach = on_attach,
})

-- CSS
vim.lsp.config("cssls", {
	capabilities = capabilities,
	on_attach = on_attach,
})

-- TypeScript / JavaScript (NEW NAME)
vim.lsp.config("ts_ls", {
	capabilities = capabilities,
	on_attach = on_attach,
})

-- JSON
vim.lsp.config("jsonls", {
	capabilities = capabilities,
	on_attach = on_attach,
})

-- Enable all configured servers
vim.lsp.enable({
	"marksman",
	"zk",
	"pyright",
	"clangd",
	"lua_ls",
	"html",
	"cssls",
	"ts_ls",
	"jsonls",
})
