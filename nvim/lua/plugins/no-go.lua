return {
  "TheNoeTrevino/no-go.nvim",
  enabled = false,
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  ft = "go",
  opts = {
    identifiers = { "err", "error" },
  },
  config = function(_, opts)
    -- Patch queries to work with latest tree-sitter-go (no more statement_list node)
    local queries = require("no-go.queries")
    queries.error_query = [[
(
  (if_statement
    condition: (binary_expression
      left: (identifier) @err_identifier)
    consequence: (block
        (return_statement
          (expression_list
            (identifier) @return_identifier)?))) @collapse_block) @if_statement
]]
    require("no-go").setup(opts)
  end,
}
