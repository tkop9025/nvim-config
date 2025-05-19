-- ~/.config/nvim/lua/core/lsp.lua

-- Global capabilities for LSP clients
local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Define all server configurations
vim.lsp.config("marksman", {
  cmd = { "marksman", "server" },
  filetypes = { "markdown" },
  capabilities = cmp_capabilities,
  root_markers = { ".marksman.toml", ".git" },
})

vim.lsp.config("zk", {
  cmd = { "zk", "lsp" },
  filetypes = { "markdown" },
  capabilities = cmp_capabilities,
})

vim.lsp.config("pyright", {
  capabilities = cmp_capabilities,
})

vim.lsp.config("clangd", {
  capabilities = cmp_capabilities,
})

vim.lsp.config("lua_ls", {
  capabilities = cmp_capabilities,
})

-- Enable the LSP clients
vim.lsp.enable({
  "marksman",
  "zk",
  "clangd",
  "lua_ls",
  "pyright",
})
