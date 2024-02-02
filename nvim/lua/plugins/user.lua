return {
  -- {
  --    "folke/todo-comments.nvim",
  --    dependecies = { "nvim-lua/plenary.nvim" },
  --    opts = {},
  --    events = "User AstroFile",
  --    cmd = { "TodoQuickFix" },
  -- },
  -- { "rose-pine/neovim", name = "rose-pine", opts = {}  },
  -- { 
  --     "AlexvZyl/nordic.nvim",
  --     name = "nordic",
  --     config = function() require("nordic").load() end,
  -- },
  -- TODO: kotsmile
  -- {
  --   "folke/todo-comments.nvim",
  --   dependencies = { "nvim-lua/plenary.nvim" },
  --   opts = {
  --     -- your configuration comes here
  --     -- or leave it empty to use the default settings
  --     -- refer to the configuration section below
  --   }
  -- },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      integrations = {
        alpha = true,
        aerial = true,
        dap = { enabled = true, enable_ui = true },
        mason = true,
        neotree = true,
        notify = true,
        nvimtree = false,
        semantic_tokens = true,
        symbols_outline = true,
        telescope = true,
        ts_rainbow = false,
        which_key = true,
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    opts = {
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
    },
  },
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.lsp.lsp-inlayhints-nvim"},
  -- { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.colorscheme.catppuccin" },
  {
      "loctvl842/monokai-pro.nvim",
    name = "monokai-pro",
    config = function()
      require("monokai-pro").setup {
          filter = "spectrum", -- classic | octagon | pro | machine | ristretto | spectrum
      }
      end
  },
  {
    'stevearc/oil.nvim',
    event = "UIEnter",
    config = function()
      require("oil").setup {}

      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    end,
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    'edluffy/hologram.nvim',
    event = "UIEnter",
    config = function()
      require('hologram').setup{
          auto_display = true -- WIP automatic markdown image display, may be prone to breaking
      }
    end,
    opts = {},
  },
  {
    "ellisonleao/gruvbox.nvim",
    name = "gruvbox",
    opts = {
      italic = {
        strings = true,
        comments = true,
        folds = true,
        operations = false,
      }
    }
  },
}
