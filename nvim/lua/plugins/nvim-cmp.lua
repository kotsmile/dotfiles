return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    { "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
    { "f3fora/cmp-spell" },
  },
  opts = function(_, opts)
    local format_kinds = opts.formatting.format
    opts.formatting.format = function(entry, item)
      format_kinds(entry, item)
      return require("tailwindcss-colorizer-cmp").formatter(entry, item)
    end

    opts.sources = opts.sources or {}
    table.insert(opts.sources, {
      name = "spell",
      option = {
        keep_all_entries = false,
        enable_in_context = function()
          return vim.opt_local.spell:get()
        end,
      },
    })
  end,
}
