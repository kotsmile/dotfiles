local M = {}

local run_cmd = nil
local run_buf = -1
local run_win = nil
local run_job = nil
local run_id = 0
local ns = vim.api.nvim_create_namespace("erun")

-- file:line or file:line:col patterns
-- matches paths like ./src/foo.lua:42:5, src/foo.lua:42, /abs/path.ts:10:3
local file_link_pattern = "([%.%/]?[%w_.%-%/]+[%w_.%-]):(%d+):?(%d*)"

local function parse_file_link(line)
  -- try all matches in the line, return first with a readable file
  local search_start = 1
  while true do
    local s, _, file, lnum, col = line:find(file_link_pattern, search_start)
    if not s then
      return nil
    end
    if vim.fn.filereadable(file) == 1 then
      return {
        file = file,
        lnum = tonumber(lnum) or 1,
        col = (col and col ~= "") and tonumber(col) or 1,
      }
    end
    search_start = s + 1
  end
end

local function highlight_file_links(buf, lnum, line)
  local start = 1
  while true do
    local s, e = line:find("[%.%/]?[%w_.%-%/]+[%w_.%-]:%d+:?%d*", start)
    if not s then
      break
    end
    vim.api.nvim_buf_add_highlight(buf, ns, "ERunLink", lnum, s - 1, e)
    start = e + 1
  end
end

local function open_file_link()
  if not run_buf or not vim.api.nvim_buf_is_valid(run_buf) then
    return
  end
  local cursor = vim.api.nvim_win_get_cursor(0)
  local line = vim.api.nvim_buf_get_lines(run_buf, cursor[1] - 1, cursor[1], false)[1]
  if not line then
    return
  end
  local link = parse_file_link(line)
  if not link then
    vim.notify("No file link found on this line", vim.log.levels.WARN)
    return
  end
  -- jump to previous window and open file
  vim.cmd("wincmd p")
  vim.cmd("edit " .. vim.fn.fnameescape(link.file))
  vim.api.nvim_win_set_cursor(0, { link.lnum, link.col - 1 })
end

local function ensure_panel()
  if run_win and vim.api.nvim_win_is_valid(run_win) then
    return
  end

  vim.cmd("botright 45split")
  run_win = vim.api.nvim_get_current_win()

  if not run_buf or not vim.api.nvim_buf_is_valid(run_buf) then
    run_buf = vim.api.nvim_create_buf(false, true)
    vim.bo[run_buf].buftype = "nofile"
    vim.bo[run_buf].bufhidden = "hide"
    vim.keymap.set("n", "gf", open_file_link, { buffer = run_buf, nowait = true, desc = "Open file link" })
    vim.keymap.set("n", "<CR>", open_file_link, { buffer = run_buf, nowait = true, desc = "Open file link" })
  end

  vim.api.nvim_win_set_buf(run_win, run_buf)
end

function M.run()
  if not run_cmd then
    print("No command set. Use :ERun <cmd>")
    return
  end

  if run_job then
    vim.fn.jobstop(run_job)
    run_job = nil
  end

  run_id = run_id + 1
  local current_id = run_id

  ensure_panel()
  vim.api.nvim_buf_set_lines(run_buf, 0, -1, false, { "$ " .. run_cmd })
  vim.api.nvim_buf_clear_namespace(run_buf, ns, 0, -1)
  vim.api.nvim_buf_add_highlight(run_buf, ns, "ERunCmd", 0, 0, -1)

  local start_time = vim.loop.hrtime()

  run_job = vim.fn.jobstart(run_cmd, {
    stdout_buffered = false,
    stderr_buffered = false,

    on_stdout = function(_, data)
      if not data then
        return
      end
      vim.schedule(function()
        if current_id ~= run_id then
          return
        end
        for _, line in ipairs(data) do
          if line ~= "" then
            vim.api.nvim_buf_set_lines(run_buf, -1, -1, false, { line })
            local lnum = vim.api.nvim_buf_line_count(run_buf) - 1
            vim.api.nvim_buf_add_highlight(run_buf, ns, "ERunStdout", lnum, 0, -1)
            highlight_file_links(run_buf, lnum, line)
          end
        end
      end)
    end,

    on_stderr = function(_, data)
      if not data then
        return
      end
      vim.schedule(function()
        if current_id ~= run_id then
          return
        end
        for _, line in ipairs(data) do
          if line ~= "" then
            vim.api.nvim_buf_set_lines(run_buf, -1, -1, false, { line })
            local lnum = vim.api.nvim_buf_line_count(run_buf) - 1
            vim.api.nvim_buf_add_highlight(run_buf, ns, "ERunStderr", lnum, 0, -1)
            highlight_file_links(run_buf, lnum, line)
          end
        end
      end)
    end,

    on_exit = function(_, code)
      run_job = nil
      vim.schedule(function()
        if current_id ~= run_id then
          return
        end
        local elapsed = (vim.loop.hrtime() - start_time) / 1e9
        local hl = code == 0 and "ERunInfoOk" or "ERunInfoFail"
        vim.api.nvim_buf_set_lines(run_buf, -1, -1, false, {
          "",
          string.format("exit code: %d | took %.2fs", code, elapsed),
        })
        local lnum = vim.api.nvim_buf_line_count(run_buf) - 1
        vim.api.nvim_buf_add_highlight(run_buf, ns, hl, lnum, 0, -1)
      end)
    end,
  })
end

--- Executable cache: built once at setup(), never shells out during completion.
local _exe_cache = nil

local function build_exe_cache()
  _exe_cache = {}
  local seen = {}
  local path_dirs = vim.split(vim.env.PATH or "", ":", { trimempty = true })
  for _, dir in ipairs(path_dirs) do
    local ok, entries = pcall(vim.fn.readdir, dir)
    if ok then
      for _, name in ipairs(entries) do
        if not seen[name] then
          seen[name] = true
          _exe_cache[#_exe_cache + 1] = name
        end
      end
    end
  end
  table.sort(_exe_cache)
end

local function complete_executables(prefix)
  if not _exe_cache then
    build_exe_cache()
  end
  if prefix == "" then
    return _exe_cache
  end
  local matches = {}
  for _, name in ipairs(_exe_cache) do
    if vim.startswith(name, prefix) then
      matches[#matches + 1] = name
    end
  end
  return matches
end

local function complete_files(prefix)
  local pat = (prefix == "") and "*" or (prefix .. "*")
  local files = vim.fn.glob(pat, false, true)
  for i, f in ipairs(files) do
    if vim.fn.isdirectory(f) == 1 then
      files[i] = f .. "/"
    end
  end
  return files
end

--- Completion callback for :ERun / :erun.
--- Handles shell operators (&&, ||, |, ;) by detecting segment boundaries.
--- Executables for the first word, file paths for arguments. No shell spawned.
function M._complete(arglead, cmdline, _cursorpos)
  -- strip the nvim command name to get the shell command line so far
  local args_str = cmdline:match("^%S+%s+(.*)$") or ""

  -- find the last "sub-command" boundary: after &&, ||, |, ;
  local last_segment = args_str:match("[;&|]+%s*([^;&|]*)$") or args_str

  -- figure out if arglead is the first word in this segment
  local prefix_before_lead = last_segment
  if arglead ~= "" then
    local pos = prefix_before_lead:find(vim.pesc(arglead) .. "$")
    if pos then
      prefix_before_lead = prefix_before_lead:sub(1, pos - 1)
    end
  end

  local is_first_word = not prefix_before_lead:match("%S")

  if is_first_word then
    -- first word of a segment: executables + files (like a real shell)
    local exes = complete_executables(arglead)
    local files = complete_files(arglead)
    -- merge, exes first
    local seen = {}
    local results = {}
    for _, v in ipairs(exes) do
      if not seen[v] then
        seen[v] = true
        results[#results + 1] = v
      end
    end
    for _, v in ipairs(files) do
      if not seen[v] then
        seen[v] = true
        results[#results + 1] = v
      end
    end
    return results
  end

  return complete_files(arglead)
end

function M.setup()
  -- pre-warm executable cache in background so first <Tab> is instant
  vim.schedule(build_exe_cache)

  vim.api.nvim_set_hl(0, "ERunCmd", { fg = "#DEEBFF", bold = true })
  vim.api.nvim_set_hl(0, "ERunStdout", { fg = "#abb2bf" })
  vim.api.nvim_set_hl(0, "ERunStderr", { fg = "#e06c75" })
  vim.api.nvim_set_hl(0, "ERunInfoOk", { fg = "#98c379", bold = true })
  vim.api.nvim_set_hl(0, "ERunInfoFail", { fg = "#e06c75", bold = true })
  vim.api.nvim_set_hl(0, "ERunLink", { fg = "#61afef", underline = true })

  vim.api.nvim_create_user_command("Erun", function(opts)
    run_cmd = opts.args
    print("Run command set to: " .. run_cmd)
    M.run()
  end, { nargs = "+", complete = M._complete })

  vim.keymap.set("n", "<leader>r", M.run)
end

return M
