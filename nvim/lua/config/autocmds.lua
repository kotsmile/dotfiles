-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = { "*.md", "*.json", "*.mdx", "*.agx", "*.svx" },
  callback = function()
    vim.cmd("set conceallevel=0")
  end,
})

vim.api.nvim_create_autocmd({ "BufLeave", "BufWinLeave" }, {
  pattern = { "*.md", "*.json", "*.mdx", "*.agx", "*.svx" },
  callback = function()
    vim.cmd("set conceallevel=3")
  end,
})

-- vim.api.nvim_create_autocmd("BufWritePost", {
--   pattern = { "*.go" },
--   callback = function()
--     local fname = vim.api.nvim_buf_get_name(0)
--     vim.system({ "ya", "tool", "go", "fmt", fname }):wait()
--     vim.cmd("edit")
--   end,
-- })
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = "*.go",
--   callback = function()
--     local view = vim.fn.winsaveview()
--     vim.cmd([[silent keepjumps %!ya tool gofmt]])
--     vim.fn.winrestview(view)
--   end,
-- })
--
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function(args)
    vim.lsp.buf.format({
      bufnr = args.buf,
      filter = function(client)
        return client.name == "gopls"
      end,
      async = false,
      timeout_ms = 500,
    })
  end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "*.yaml" },
  callback = function()
    local fname = vim.api.nvim_buf_get_name(0)
    vim.system({ "ya", "tool", "tt", "format", fname }):wait()
    vim.cmd("edit")
  end,
})

-- vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
--   pattern = {
--     "ya.make",
--     "ya.make.inc",
--     "ya.inc",
--   },
--   callback = function()
--     vim.o.filetype = "yamake"
--   end,
-- })
--
-- vim.api.nvim_create_autocmd({ "FileType" }, {
--   pattern = { "yamake" },
--   callback = function(args)
--     if vim.fn.executable("node") == 1 then
--       local script_path = "~/arcadia/devtools/ide/vscode-yandex-arc/ya-make-lsp/out/ya-make-lsp.js"
--       if vim.fn.filereadable(script_path) then
--         vim.lsp.start({
--           name = "yamake-lsp",
--           cmd = {
--             "node",
--             script_path,
--             "--stdio",
--           },
--         })
--       end
--     end
--   end,
-- })

-- vim.o.background = "dark" -- or "light" for light mode
-- vim.cmd([[colorscheme gruvbox]])

-- vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
--   pattern = { "*.analog" },
--   callback = function()
--     vim.cmd("set ft=vue")
--   end,
-- })

-- Disable nvim-cmp for Markdown files
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "markdown",
--   callback = function()
--     local cmp = require("cmp")
--     -- completely disable
--     -- require("cmp").setup.buffer({ enabled = false })
--
--     -- manual complete
--     cmp.setup({
--       completion = {
--         autocomplete = false,
--         completeopt = "menu,menuone,noinsert",
--       },
--       mapping = cmp.mapping.preset.insert({
--         ["<Tab>"] = cmp.mapping.complete(),
--       }),
--     })
--   end,
-- })
