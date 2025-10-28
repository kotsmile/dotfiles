return {
  "supermaven-inc/supermaven-nvim",
  enabled = true,
  lazy = false,
  config = function()
    require("supermaven-nvim").setup({
      keymaps = {
        accept_suggestion = "<C-J>",
        accept_word = "<C-c>",
      },
    })
  end,
}
