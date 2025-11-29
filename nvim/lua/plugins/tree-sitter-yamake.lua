return {
  dir = "~/arcadia/devtools/ide/tree-sitter-yamake",
  build = ":TSInstall yamake",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  enabled = function()
    return vim.fn.isdirectory("~/arcadia/devtools/ide/tree-sitter-yamake") ~= 0
  end,
}
