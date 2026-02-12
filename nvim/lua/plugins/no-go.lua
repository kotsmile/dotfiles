return {
  "TheNoeTrevino/no-go.nvim",
  enabled = true,
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  ft = "go",
  opts = {
    identifiers = { "err", "error" },
  },
}
