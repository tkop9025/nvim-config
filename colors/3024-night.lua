-- ~/.config/nvim/colors/3024-night.lua

vim.cmd.highlight("clear")
vim.o.background = "dark"
vim.g.colors_name = "3024-night"

local set = vim.api.nvim_set_hl

-- Muted 3024 colors
local bg       = "#100d0c"
local fg       = "#b0ada9"
local red      = "#b6483f"
local green    = "#2b875f"
local yellow   = "#c8b740"
local blue     = "#508ab3"
local magenta  = "#a37a9a"
local cyan     = "#81b3b2"
local gray     = "#5e5956"
local white    = "#f0ece8"
local sel_bg   = "#3a3634"

-- UI
set(0, "Normal",         { fg = fg, bg = bg })
set(0, "CursorLine",     { bg = "#1c1815" })
set(0, "Visual",         { bg = sel_bg })
set(0, "ColorColumn",    { bg = gray })
set(0, "StatusLine",     { fg = fg, bg = "#1c1815" })
set(0, "StatusLineNC",   { fg = gray, bg = "#1c1815" })
set(0, "VertSplit",      { fg = gray })

-- Syntax
set(0, "Comment",        { fg = gray, italic = true })
set(0, "Constant",       { fg = cyan })
set(0, "String",         { fg = green })
set(0, "Function",       { fg = blue })
set(0, "Identifier",     { fg = magenta })
set(0, "Statement",      { fg = red })
set(0, "PreProc",        { fg = yellow })
set(0, "Type",           { fg = blue })
set(0, "Special",        { fg = yellow })

-- Diagnostics
set(0, "DiagnosticError", { fg = red })
set(0, "DiagnosticWarn",  { fg = yellow })
set(0, "DiagnosticInfo",  { fg = blue })
set(0, "DiagnosticHint",  { fg = cyan })

-- Git
set(0, "DiffAdd",    { bg = "#103010" })
set(0, "DiffChange", { bg = "#303010" })
set(0, "DiffDelete", { bg = "#301010" })

-- Line numbers
set(0, "LineNr",      { fg = gray })
set(0, "CursorLineNr",{ fg = yellow })

-- Cursor
set(0, "Cursor", { fg = bg, bg = fg })
