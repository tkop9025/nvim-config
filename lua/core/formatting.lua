local null_ls = require("null-ls")
local mason_null_ls = require("mason-null-ls")

-- set up mason-null-ls to install black
mason_null_ls.setup({
  ensure_installed = { "black", "stylua" },
  automatic_installation = true,
})

-- formatting on save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.black.with({ extra_args = { "--fast" } }),
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({
            bufnr = bufnr,
            filter = function(c)
              return c.name == "null-ls"
            end,
          })
        end,
      })
    end
  end,
})
