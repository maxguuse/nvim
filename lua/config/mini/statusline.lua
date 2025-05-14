local modes = {
  ["n"] = "NO",
  ["i"] = "IN",
  ["v"] = "VI",
  ["V"] = "VL",
  ["\x16"] = "VB",
  ["c"] = "CO",
  ["t"] = "TE",
}

local function statusline_mode()
  local mode = vim.fn.mode()
  local mode_str = (mode == "n" and (vim.bo.ro or not vim.bo.ma)) and "RO" or modes[mode]

  return string.format(" %s ", mode_str)
end

local function statusline_filename()
  if vim.bo.buftype == "terminal" then
    return "%t"
  end

  return "%f%m"
end

local function statusline_arglist()
  local info = require("core.arglist").info()

  if info.index ~= -1 then
    return string.format("󱡁%s", info.index)
  end
end

local function active_statusline()
  local MiniStatusline = require("mini.statusline")

  local mode = statusline_mode()
  local git = MiniStatusline.section_git({ trunc_width = 40 })
  local filename = statusline_filename()
  local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
  local arglist = statusline_arglist()

  return MiniStatusline.combine_groups({
    { strings = { mode } },
    { strings = { git } },
    { strings = { filename, arglist } },
    { strings = { diagnostics } },
  })
end

local function inactive_statusline()
  return "%#MiniStatuslineInactive#%F%="
end

return {
  content = {
    active = active_statusline,
    inactive = inactive_statusline,
  },

  use_icons = true,
  set_vim_settings = true,
}
