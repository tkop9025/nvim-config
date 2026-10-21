-- ~/.config/nvim/lua/core/keymaps.lua

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)

-- Clipboard
keymap({ "n", "v" }, "<leader>y", '"+y')
keymap("n", "<leader>Y", '"+yy')

keymap({ "n", "v" }, "<leader>p", '"+p')
keymap({ "n", "v" }, "<leader>P", '"+P')

-- Telescope
keymap("n", "<leader>ff", require("telescope.builtin").find_files, opts)
keymap("n", "<leader>fg", require("telescope.builtin").live_grep, opts)
keymap("n", "<leader>fr", require("telescope.builtin").oldfiles, { desc = "Recent Files" })

-- Save & quit
keymap("n", "<leader>w", ":w<CR>", opts)
keymap("n", "<leader>q", ":q<CR>", opts)

-- Clear highlight
keymap("n", "<leader>nh", ":nohl<CR>", opts)

-- LSP
keymap("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic message" })
keymap("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
keymap("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
keymap("n", "<leader>r", vim.diagnostic.setloclist, { desc = "Diagnostics to loclist" })
keymap("n", "<leader>gf", vim.lsp.buf.definition, { desc = "Follow link with LSP" })
