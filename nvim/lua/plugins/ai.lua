return {
  "supermaven-inc/supermaven-nvim",
  lazy = false,
  enabled = true,
  config = function()
    require("supermaven-nvim").setup({
      keymaps = {
        accept_suggestion = "<C-j>",
        accept_word = "<C-[>",
      },
    })
  end,
}
