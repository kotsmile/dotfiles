-- return {
--   "zbirenbaum/copilot.lua",
--   enabled = true,
--   lazy = false,
--   config = function()
--     require("copilot").setup({
--       suggestion = {
--         enabled = true,
--         auto_trigger = true, -- Automatically trigger suggestions
--         debounce = 75, -- Debounce time in milliseconds
--       },
--       panel = {
--         enabled = true,
--       },
--     })
--   end,
-- }
return {
  "github/copilot.vim",
  lazy = false,
  enabled = false,
}
