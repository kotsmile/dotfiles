return {
  {
    enabled = false,
    -- local module from your config
    "md_ticket_link",
    dev = true,
    dir = vim.fn.stdpath("config") .. "/lua",
    opts = {
      { [[\v([A-Z]+-\d+)]], "https://st.yandex-team.ru/$t" },
    },
    config = function(_, opts)
      require("md_ticket_link").setup(opts)
    end,
  },
}
