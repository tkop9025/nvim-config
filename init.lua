-- ~/.config/nvim/init.lua

vim.g.mapleader = " "

-- Bootstrap lazy.nvim if not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugin setup
require("lazy").setup("plugins")

-- Core config
require("core.options")
require("core.keymaps")
require("core.telescope")
require("core.colorscheme")
require("core.lualine")
require("core.lsp")
require("core.formatting")
require("core.treesitter")

