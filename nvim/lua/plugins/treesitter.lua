return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  build = ":TSUpdate",
  opts = function(_, opts)
    -- opts.highlight = opts.highlight or {}
    -- local disable = opts.highlight.disable or {}
    -- table.insert(disable, "go")
    -- opts.highlight.disable = disable
  end,
}
