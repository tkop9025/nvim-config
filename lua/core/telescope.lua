-- Telescope basic setup + load fzf extension
require('telescope').setup {
  defaults = {
    file_ignore_patterns = { ".git/", "node_modules/" },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    }
  }
}

-- Load the fzf-native extension
pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'zoxide')
