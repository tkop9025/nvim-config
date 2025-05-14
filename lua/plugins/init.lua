-- ~/.config/nvim/lua/plugins/init.lua

return {
  -- Plugin manager utilities
  { "nvim-lua/plenary.nvim" },

  -- UI
  { "nvim-lualine/lualine.nvim" },
  { "yazeed1s/minimal.nvim" },
  { "vague2k/vague.nvim", priority=1000},

  -- Core tools
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { "nvim-telescope/telescope.nvim" },
  { "jvgrootveld/telescope-zoxide" },
  {
  'nvim-telescope/telescope-fzf-native.nvim',
  build = 'make',
  cond = vim.fn.executable('make') == 1
  },

  -- LSP and language tools
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason.nvim", config = true },
  { "williamboman/mason-lspconfig.nvim", config = true },

  -- Formatting
  { "nvimtools/none-ls.nvim",
    name = "null-ls",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  { "williamboman/mason-null-ls.nvim",
    dependencies = { "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim", },
  },

  -- Autocompletion
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "L3MON4D3/LuaSnip" },

  -- Utilities
  { "mikavilpas/yazi.nvim" },
  { "numToStr/Comment.nvim", config = true },
  {
    "kylechui/nvim-surround",
    version = "^3.0.0",
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({
            -- Default
        })
    end
  },

  --zk
  { "zk-org/zk-nvim",
    event = "BufReadPre",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    config = function()
      require("zk").setup({
        picker = "telescope",
        lsp = {
          config = {
            cmd  = { "zk", "lsp" },
            name = "zk",
            root_dir = vim.env.ZK_NOTEBOOK_DIR,
          },
          auto_attach = { enabled = true, filetypes = { "markdown" } },
        },
      })
    end,
  }

}
