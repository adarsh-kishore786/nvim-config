local function diagnostic_counts()
  local buf = vim.api.nvim_get_current_buf()
  local e = #vim.diagnostic.get(buf, { severity = vim.diagnostic.severity.ERROR })
  local w = #vim.diagnostic.get(buf, { severity = vim.diagnostic.severity.WARN })
  local h = #vim.diagnostic.get(buf, { severity = vim.diagnostic.severity.HINT })
  local result = ""

  if e > 0 then result = result .. "%#DiagnosticError# E:" .. e .. " " end
  if w > 0 then result = result .. "%#DiagnosticWarn# W:" .. w .. " " end
  if h > 0 then result = result .. "%#DiagnosticHint# H:" .. h .. " " end

  return result
end

local function git_branch()
  local head = vim.fn.findfile(".git/HEAD", ":;")

  if type(head) ~= "string" or head == "" then return "" end

  local f = io.open(head, "r")
  if not f then return "" end

  local content = f:read("*l")
  f:close()

  return content:match("ref: refs/heads/(.+)") or ""
end

local function smart_path()
  local full = vim.fn.expand("%:p")
  if full == "" then return "[No name]" end

  local parts = {}
  for part in full:gmatch("[^/]+") do
    table.insert(parts, part)
  end

  local last4 = table.concat(parts, "/", math.max(1, #parts-3))
  return #last4 < #full and last4 or full
end

local mode_labels = {
  n = "NORMAL",
  i = "INSERT",
  v = "VISUAL",
  V = "V-LINE",
  c = "COMMAND",
  R = "REPLACE",
  ["\22"] = "V-BLOCK"
}

local mode_hl = {
  n = "StatusLineNormal",
  i = "StatusLineInsert",
  v = "StatusLineVisual",
  V = "StatusLineVisual"
}

vim.api.nvim_set_hl(0, "StatusLineNormal",  { fg = "#1D9E75", bold = true })
vim.api.nvim_set_hl(0, "StatusLineInsert",  { fg = "#378ADD", bold = true })
vim.api.nvim_set_hl(0, "StatusLineVisual",  { fg = "#BA7517", bold = true })

_G.statusline = function ()
  local m = vim.fn.mode()

  local mode = mode_labels[m]
  local hl = mode_hl[m] or "StatusLine";

  if mode == nil then
    mode = "Unknown"
  end

  return "%#" .. hl .. "# [" .. mode .. "] %#StatusLine#"
      .. smart_path() .. " "
      .. git_branch() .. " %m "
      .. diagnostic_counts() .. "%=%l,%c"
end

vim.o.statusline = "%!v:lua.statusline()"
