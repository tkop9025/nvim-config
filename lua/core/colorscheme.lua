-- ~/.config/nvim/lua/core/colorscheme.lua

vim.o.background = "dark"

local function clear_bg()
	for _, g in ipairs({ "Normal", "NormalNC", "NormalFloat", "SignColumn", "EndOfBuffer", "LineNr", "FoldColumn" }) do
		local hl = vim.api.nvim_get_hl(0, { name = g, link = false })
		hl.bg = nil
		hl.ctermbg = nil
		vim.api.nvim_set_hl(0, g, hl)
	end
end

clear_bg()
vim.api.nvim_create_autocmd("ColorScheme", { callback = clear_bg })
