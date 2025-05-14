-- ~/.config/nvim/lua/core/keymaps.lua

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)

-- Telescope
keymap("n", "<leader>ff", require("telescope.builtin").find_files, opts)
keymap("n", "<leader>fg", require("telescope.builtin").live_grep, opts)
keymap('n', '<leader>fr', require('telescope.builtin').oldfiles, { desc = "Recent Files" })
keymap('n', '<leader>fz', function()
  require('telescope').extensions.zoxide.list({
    attach_mappings = function(prompt_bufnr, map)
      local actions = require('telescope.actions')
      local action_state = require('telescope.actions.state')
      map('i', '<CR>', function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        vim.cmd('cd ' .. selection.path)
        require('telescope.builtin').find_files()
      end)
      return true
    end
  })
end, { desc = "Zoxide + Find Files" })

-- Yazi
keymap("n", "<leader>fy", ":lua require('yazi').yazi()<CR>", opts)

-- Save & quit
keymap("n", "<leader>w", ":w<CR>", opts)
keymap("n", "<leader>q", ":q<CR>", opts)

-- Clear highlight
keymap("n", "<leader>nh", ":nohl<CR>", opts)

-- LSP
keymap('n', '<leader>e', vim.diagnostic.open_float, { desc = "Show diagnostic message" })
keymap('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
keymap('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
keymap('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Diagnostics to loclist" })


--zk

keymap("n", "<leader>zn",
  "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", opts)

-- Browse all notes, newest first
keymap("n", "<leader>zo",
  "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", opts)

-- Grep across notes (prompts for query)
keymap("n", "<leader>zf",
  "<Cmd>ZkNotes { match = { vim.fn.input('Search: ') } }<CR>", opts)

-- Backlinks and forward links
keymap("n", "<leader>zb", "<Cmd>ZkBacklinks<CR>", opts)
keymap("n", "<leader>zl", "<Cmd>ZkLinks<CR>", opts)

-- Create daily note
keymap("n", "<leader>zd", "<Cmd>silent !zk daily<CR><Cmd>e!<CR>", opts)
