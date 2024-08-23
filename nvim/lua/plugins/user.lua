vim.opt.guicursor = ""
-- vim.api.nvim_set_keymap('i', '<C-f>', 'copilot#Accept("<CR>")', {expr=true, silent=true})
vim.g.neovide_cursor_animation_length = 0
vim.g.neovide_text_contrast = 0.0
vim.g.neovide_text_gamma = 0.0
require('lspconfig').gleam.setup({})

-- vim.cmd('highlight MatchParen guibg=#303446')
---@type LazySpec
return {
  {
    "supermaven-inc/supermaven-nvim",
    lazy = false,
    config = function()
      require("supermaven-nvim").setup({
        keymaps = {
          accept_suggestion = "<C-f>",
        }
      })
    end,
  },
  { "indent-blankline.nvim", enabled = false },
--  { "rebelot/heirline.nvim", enabled = false },
  { "lewis6991/gitsigns.nvim", enabled = false },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = { flavour = "macchiato" },
    init = function()
      vim.cmd([[
        highlight NeoTreeNormal guibg=#1e2031
        highlight NeoTreeNormalNC guibg=#1e2031
        " highlight NeoTreeNormal guibg=#282c3c
        " highlight NeoTreeNormalNC guibg=#282c3c
      ]])
    end,
  },
  { "Mofiqul/dracula.nvim" },
  -- { 
  --   "ellisonleao/gruvbox.nvim",
  --   init = function()
  --     vim.cmd([[
  --       highlight NeoTreeNormal guibg=#222222
  --       highlight NeoTreeNormalNC guibg=#222222
  --     ]])
  --   end,
  -- } ,
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function()
      return {
        filesystem = {
          filtered_items = {
            visible = true
          }
        }
      }
    end,
  },
  { "max397574/better-escape.nvim", enabled = false },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = false,
    opts = {
    }
  },
  { "smithbm2316/centerpad.nvim", enabled = true, lazy = false },
  {
    'renerocksai/telekasten.nvim',
    dependencies = {'nvim-telescope/telescope.nvim'},
    enabled = true,
    lazy = false
  },
  -- {
  --   "williamboman/mason.nvim",
  --   opts = function(_, opts)
  --     vim.list_extend(opts.ensure_installed, {
  --       "gleam",
  --     })
  --   end,
  -- },
  -- {
  --   "github/copilot.vim",
  --   lazy = false,
  -- },
}


