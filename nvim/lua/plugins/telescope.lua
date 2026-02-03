return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = function(_, opts)
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")

    local function open_multiselect_or_current(prompt_bufnr)
      local picker = action_state.get_current_picker(prompt_bufnr)
      local multi = picker:get_multi_selection()

      if #multi > 0 then
        actions.send_selected_to_qflist(prompt_bufnr)
        actions.open_qflist(prompt_bufnr)
      else
        actions.select_default(prompt_bufnr)
      end
    end

    -- Ensure tables exist
    opts.pickers = opts.pickers or {}
    opts.pickers.live_grep = opts.pickers.live_grep or {}
    opts.pickers.live_grep.mappings = opts.pickers.live_grep.mappings or {}
    opts.pickers.live_grep.mappings.i = opts.pickers.live_grep.mappings.i or {}
    opts.pickers.live_grep.mappings.n = opts.pickers.live_grep.mappings.n or {}

    -- Only affect Telescope live_grep
    opts.pickers.live_grep.mappings.i["<CR>"] = open_multiselect_or_current
    opts.pickers.live_grep.mappings.n["<CR>"] = open_multiselect_or_current
  end,
}
