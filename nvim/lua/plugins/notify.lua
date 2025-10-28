-- return {
--   "rcarriga/nvim-notify",
--   enabled = true,
--   config = function()
--     require("notify").setup({
--       top_down = false,
--     })
--   end,
-- }

return {
  "folke/snacks.nvim",
  lazy = false,
  enabled = true,
  opts = {
    notifier = {
      top_down = false,
      -- your notifier configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
  -- config = function()
  --   require("snacks").setup({
  --     -- your config comes here
  --     -- or leave it empty to use the default settings
  --     -- refer to the configuration section below
  --   })
}
