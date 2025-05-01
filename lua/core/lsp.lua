-- ~/.config/nvim/lua/core/lsp.lua

-- Ensure Mason is installed and running
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",   -- Lua
    "pyright",  -- Python
    "bashls",   -- Shell
    "clangd",   -- C/C++
  },
})

-- LSP config
local lspconfig = require("lspconfig")

-- Lua (neovim config)
lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
})

-- Python
lspconfig.pyright.setup({})

-- Bash
lspconfig.bashls.setup({})

-- C/C++
lspconfig.clangd.setup({})

vim.diagnostic.config({
  float = {
    border = "rounded",
    source = "always",
    prefix = "- ",
  },
})
