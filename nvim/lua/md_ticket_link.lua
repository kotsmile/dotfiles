local M = {}

-- opts: array of { pattern, link_template }
-- link_template supports:
--   $t  -> matched tag text
M.opts = {}

local function find_md_link_spans(line)
  local spans = {}
  local i = 1
  while true do
    local s, e = line:find("%b[]%b()", i)
    if not s then
      break
    end
    table.insert(spans, { s, e })
    i = e + 1
  end
  return spans
end

local function in_spans(spans, pos1)
  for _, sp in ipairs(spans) do
    if pos1 >= sp[1] and pos1 <= sp[2] then
      return true
    end
  end
  return false
end

local function apply_template(tpl, tag)
  return (tpl:gsub("%$t", tag))
end

local function linkify_line(line, pat, link_tpl)
  local spans = find_md_link_spans(line)

  local out = {}
  local pos = 0 -- 0-based for matchstrpos

  while true do
    local m = vim.fn.matchstrpos(line, pat, pos)
    local matched, s0, e0 = m[1], m[2], m[3]

    if s0 == -1 then
      table.insert(out, line:sub(pos + 1))
      break
    end

    table.insert(out, line:sub(pos + 1, s0))

    if e0 <= s0 or matched == "" then
      table.insert(out, line:sub(s0 + 1, s0 + 1))
      pos = s0 + 1
    else
      local s1 = s0 + 1
      if in_spans(spans, s1) then
        table.insert(out, matched)
      else
        local url = apply_template(link_tpl, matched)
        table.insert(out, ("[%s](%s)"):format(matched, url))
      end
      pos = e0
    end
  end

  return table.concat(out)
end

function M.run()
  if vim.bo.filetype ~= "markdown" then
    return
  end
  if type(M.opts) ~= "table" or #M.opts == 0 then
    return
  end

  local view = vim.fn.winsaveview()
  local buf = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)

  local changed = false
  for i, line in ipairs(lines) do
    local new_line = line
    for _, rule in ipairs(M.opts) do
      local pat, link_tpl = rule[1], rule[2]
      if pat and link_tpl then
        new_line = linkify_line(new_line, pat, link_tpl)
      end
    end
    if new_line ~= line then
      lines[i] = new_line
      changed = true
    end
  end

  if changed then
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  end

  vim.fn.winrestview(view)
end

function M.setup(opts)
  if type(opts) == "table" then
    M.opts = opts
  end

  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.md",
    callback = function()
      M.run()
    end,
  })
end

return M
