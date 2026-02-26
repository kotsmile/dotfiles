-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "U", "<c-u>zz")
vim.keymap.set("n", "D", "<c-d>zz")

vim.keymap.set("n", "<leader>fp", "0<c-g>", { desc = "Show full file path" })

-- move lines
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

-- join lines
vim.keymap.set("n", "J", "mzJ`z")

-- chatgpt
-- vim.keymap.set("n", "<leader>gp", "<cmd>ChatGPT<cr>", { desc = "Launch ChatGPT" })
-- vim.keymap.set("n", "<leader>gpa", "<cmd>ChatGPTActAs<cr>", { desc = "ChatGPT Act As" })
-- vim.keymap.set("n", "<leader>gpe", "<cmd>ChatGPTEditWithInstructions<cr>", { desc = "ChatGPT Edit With Instructions" })
-- vim.keymap.set("n", "<leader>gpc", "<cmd>ChatGPTCompleteCode<cr>", { desc = "ChatGPT Complete Code" })
-- vim.keymap.set("n", "<leader>gpf", "<cmd>ChatGPTRun fix_bugs<cr>", { desc = "ChatGPT Fix Bugs" })
-- vim.keymap.set("n", "<leader>gpx", "<cmd>ChatGPTRun explain_code<cr>", { desc = "ChatGPT Fix Bugs" })

-- markdown
vim.keymap.set(
  "n",
  "<leader>da",
  '<cmd>setlocal formatoptions-=a<cr><cmd>setlocal textwidth=0<cr><cmd>echo "Auto-wrapping disabled"<cr>',
  { desc = "Disable auto wrap" }
)
vim.keymap.set(
  "n",
  "<leader>ea",
  '<cmd>setlocal formatoptions+=a<cr><cmd>setlocal textwidth=80<cr><cmd>echo "Auto-wrapping enabled"<cr>',
  { desc = "Enable auto wrap" }
)

vim.keymap.set("v", "<leader>mb", "di****<esc>hhp", { desc = "Auto bold" })
vim.keymap.set("v", "<leader>mi", "di**<esc>hp", { desc = "Auto italic" })
vim.keymap.set("v", "<leader>ml", "di[]()<esc>hhhpllli", { desc = "Auto link" })
vim.keymap.set("v", "<leader>mc", "di``<esc>hp", { desc = "Auto backtick" })

vim.keymap.set("n", "<leader>bw", "<cmd>bufdo bwipeout<cr>", { desc = "Close all buffers" })

-- jumps
vim.keymap.set("n", "<leader>jt", "<cmd>/template:<cr><cmd>nohl<cr>", { desc = "Jump to template" })
vim.keymap.set("n", "<leader>js", "<cmd>/style.:<cr><cmd>nohl<cr>", { desc = "Jump to styles" })
vim.keymap.set("n", "<leader>jc", "<cmd>/Component {<cr><cmd>nohl<cr>", { desc = "Jump to component" })

-- harpoon
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>ha", mark.add_file)
vim.keymap.set("n", "<leader>h", ui.toggle_quick_menu)
vim.keymap.set("n", "<leader>hl", function()
  ui.nav_next()
end)
vim.keymap.set("n", "<leader>hh", function()
  ui.nav_next()
end)

-- undotree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

--
-- telescope
vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>jl", require("telescope.builtin").jumplist, { desc = "[J]ump [L]ist" })
vim.keymap.set("n", "<leader>km", require("telescope.builtin").keymaps, { desc = "[K]ey[M]aps" })
vim.keymap.set("n", "<leader>rg", require("telescope.builtin").registers, { desc = "[R]egisters" })
vim.keymap.set("n", "<leader>ht", require("telescope.builtin").help_tags, { desc = "[H]elp [T]ags" })
vim.keymap.set("n", "<leader>fw", require("telescope.builtin").live_grep, { desc = "[F]ind [W]ord" })

-- ufo
vim.keymap.set("n", "zR", require("ufo").openAllFolds)
vim.keymap.set("n", "zM", require("ufo").closeAllFolds)

-- vim.api.nvim_set_keymap("i", "<C-j>", 'copilot#Accept("<CR>")', { expr = true, silent = true })
--
-- golang
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to Implementation" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to References" })
vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature Help" })
vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature Help" })

--- bufferline
vim.keymap.set("n", "<leader>bc", function()
  Snacks.bufdelete()
end, { desc = "Delete Buffer" })

local diagnostic_goto = function(next, severity)
  return function()
    if severity then
      vim.diagnostic.goto_next({
        severity = vim.diagnostic.severity[severity],
      })
    else
      if next then
        vim.diagnostic.goto_next()
      else
        vim.diagnostic.goto_prev()
      end
    end
  end
end

vim.keymap.set("n", "<leader>dc", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
vim.keymap.set("n", "<leader>dl", function()
  vim.diagnostic.setloclist({ scope = "workspace" })
  vim.cmd("lopen")
end, { desc = "Diagnostics (workspace)" })
vim.keymap.set("n", "<leader>de", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
vim.keymap.set("n", "<leader>dE", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
vim.keymap.set("n", "<leader>dw", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
vim.keymap.set("n", "<leader>dW", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

vim.keymap.set("n", "<leader>rm", "<cmd>RenderMarkdown toggle<cr>", { desc = "Toogle markdown" })
