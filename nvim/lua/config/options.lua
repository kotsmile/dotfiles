-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.mapleader = " "

vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.timeoutlen = 250
vim.opt.showmatch = true
vim.opt.synmaxcol = 300 -- stop syntax highlighting for performance
vim.opt.laststatus = 2 -- always show statusline

-- Sidebar
vim.opt.numberwidth = 1
vim.opt.showcmd = true
vim.opt.cmdheight = 0

-- Search
vim.o.incsearch = true -- starts searching as soon as typing, without enter needed
vim.o.ignorecase = true -- ignore letter case when searching
vim.o.smartcase = true -- case insentive unless capitals used in searcher

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 50
vim.opt.colorcolumn = "100"

local float = { focusable = true, style = "minimal", border = "rounded" }

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, float)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, float)

vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#d8bd92" })

vim.filetype.add({
  extension = {
    mdx = "mdx",
    agx = "agx",
    svx = "svx",
    analog = "analog",
    ag = "ag",
  },
})

vim.filetype.add({
  extension = {
    [".all-contributorsrc"] = ".all-contributorsrc",
  },
})

vim.treesitter.language.register("angular", "angular.html")
vim.treesitter.language.register("markdown", "mdx")
vim.treesitter.language.register("markdown", "agx")
vim.treesitter.language.register("markdown", "svx")
vim.treesitter.language.register("vue", "analog")
vim.treesitter.language.register("vue", "ag")
vim.treesitter.language.register("vue", "agx")
vim.treesitter.language.register("json", ".all-contributorsrc")

-- folds
vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- change root dir for grep
vim.g.root_spec = { "cwd" }
vim.opt.guicursor = ""

-- set exrc " разрешаем подгружать дополнительные .vimrc из папок по месту
-- set secure " запрещаем подгружать .vimrc не от нашего пользователя/группы (Unix)
--
-- " включаем форматирование кода и импортов при сохранении
-- let g:go_fmt_autosave = 1
-- let g:go_imports_autosave = 1

-- vim.g.go_fmt_autosave = 1
-- vim.g.go_imports_autosave = 1
-- vim.o.exrc = true
-- vim.o.secure = true
--

vim.opt.fillchars = {
  vert = "█",
  horiz = "▁",
}

-- vim.opt.fillchars = {
--   eob = " ", -- Character for end-of-buffer blank lines (hides the '~')
--   msgsep = "-", -- Separator character for messages
--   fold = " ", -- Character used for folded lines
--   foldopen = "v", -- Character for open folds
--   foldclose = ">", -- Character for closed folds
--   foldsep = ":", -- Separator character within folds
--   diff = " ", -- Character for diff filler lines
-- }
