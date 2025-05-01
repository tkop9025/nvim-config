-- ~/.config/nvim/lua/core/lualine.lua

require("lualine").setup({
  options = {
    theme = "auto",
    section_separators = "",        -- clean edges
    component_separators = "|",     -- subtle dividers
    icons_enabled = true,
    globalstatus = true,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff" },
    lualine_c = { { "filename", path = 1 } }, -- show relative path
    lualine_x = { "diagnostics", "encoding", "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
})
