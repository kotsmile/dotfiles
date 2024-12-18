vim.opt.guicursor = ""
vim.api.nvim_set_keymap('i', '<C-f>', 'copilot#Accept("<CR>")', { expr = true, silent = true })
vim.g.neovide_cursor_animation_length = 0
vim.g.neovide_text_contrast = 0.0
vim.g.neovide_text_gamma = 0.0
vim.opt.colorcolumn = "80"
require('lspconfig').gleam.setup({})




-- mappings = {
--   n = {
--     ["<Leader>db"] = {
--       "<cmd> DapToggleBreakpoint <CR>",
--       "Add breakpoint at current line"
--     },
--     ["<Leader>dus"] = {
--       function()
--       end,
--       "Open debugging sidebar"
--     },
--   }

-- vim.cmd('highlight MatchParen guibg=#303446')
--
-- vim.keymap.set("n", "<Leader>dc", dap.continue, {})
---@type LazySpec
return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",  -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Only one of these is needed.
      "nvim-telescope/telescope.nvim", -- optional
      "ibhagwan/fzf-lua",              -- optional
      "echasnovski/mini.pick",         -- optional
    },
    config = true
  },
  {
    "rebelot/heirline.nvim",
    opts = function(_, opts)
      local status = require "astroui.status"
      opts.statusline[5] = status.component.builder {
        {
          provider = function()
            -- Get the full file path
            -- local filepath = vim.fn.expand('%:p')
            local filepath = vim.fn.expand('%:~:.')
            return filepath ~= '' and filepath or '[No File]'
          end,
          -- hl = { fg = 'gray' }, -- Optional highlight configuration
        }
      }
      -- local filepath = vim.fn.expand('%:p')
      -- opts.statusline[1] = status.component.mode { mode_text = { padding = { left = 1, right = 1 } } } -- add the mode text
      -- filepath ~= '' and filepath or '[No File]'
    end,
  },
  {
    "mfussenegger/nvim-dap",
    enabled = true,
    init = function()
      vim.api.nvim_set_keymap('n', '<Leader>db', '<cmd> DapToggleBreakpoint <CR>', {})
      -- vim.keymap.set('n', '<Leader>dus', function()
      --   local widgets = require("dap.ui.widgets")
      --   local sidebar = widgets.sidebar(widgets.scopes)
      --   sidebar.open()
      -- end
      -- , {})
    end,
  },
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    enabled = true,
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    config = function(_, opts)
      require("dap-go").setup(opts)
    end,
    init = function()
      vim.keymap.set('n', '<Leader>dgt', function()
        require("dap-go").debug_test()
      end
      , {})
      vim.keymap.set('n', '<Leader>dgl', function()
        require("dap-go").debug_last()
      end
      , {})
    end,
  },
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    build = function()
      if not require("lazy.core.config").spec.plugins["mason.nvim"] then
        vim.print "Installing go dependencies..."
        vim.cmd.GoInstallDeps()
      end
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      { "williamboman/mason.nvim", optional = true }, -- by default use Mason for go dependencies
    },
    opts = {},
    mappings = {

    }
  },
  {
    "supermaven-inc/supermaven-nvim",
    enabled = true,
    lazy = false,
    config = function()
      require("supermaven-nvim").setup({
        keymaps = {
          accept_suggestion = "<C-f>",
        }
      })
    end,
  },
  { "indent-blankline.nvim",   enabled = false },
  { "lewis6991/gitsigns.nvim", enabled = true },
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
    dependencies = { 'nvim-telescope/telescope.nvim' },
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
