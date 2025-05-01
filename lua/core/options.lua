-- ~/.config/nvim/lua/core/options.lua

local opt = vim.opt
local g = vim.g

-- Interface
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.scrolloff = 8
opt.updatetime = 250
opt.termguicolors = true

-- Editing
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.smartindent = true

-- Searching
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true

-- Split behavior
opt.splitbelow = true
opt.splitright = true

-- Leader key
g.mapleader = " "
