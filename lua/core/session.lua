local M = {}

local saved_sessions_file = vim.env.HOME .. "/.local/state/nvim/ggoose_sessions"

function M.read_saved_sessions()
  local lines = {}

  local file = io.open(saved_sessions_file, "r")
  if file then
    for line in file:lines() do
      table.insert(lines, line)
    end
  else
    file = io.open(saved_sessions_file, "w")
    if file then
      file:close()
      print("Created new file: " .. saved_sessions_file)
    else
      error("Failed to create file: " .. saved_sessions_file)
    end
  end

  return lines
end

function M.save_session(session)
  if session == "" then return end

  local existing_sessions = M.read_saved_sessions()
  if not vim.tbl_contains(existing_sessions, session) then table.insert(existing_sessions, session) end

  local file = io.open(saved_sessions_file, "w+")

  if file then
    for _, line in ipairs(existing_sessions) do
      file:write(line .. "\n")
    end
    file:close()
    return true
  else
    return false, "Could not open file for writing"
  end
end

M.write_session = function()
  local util = require("core.util")

  local project_root, session_file

  project_root = util.GetProjectRoot()
  session_file = project_root .. "/Session.vim"

  if project_root and project_root ~= "" and util.IsProtectedDir(project_root) then
    vim.notify("Session cannot be saved to protected directory: " .. project_root, vim.log.levels.WARN)
    return false
  end

  vim.cmd("mksession! " .. vim.fn.fnameescape(session_file))
  M.save_session(session_file)
  vim.notify("Session written: " .. session_file, vim.log.levels.INFO)
end

M.read_session = function()
  local session_dir = vim.fs.root(0, "Session.vim")
  if session_dir == nil then return false end

  ---@diagnostic disable-next-line: param-type-mismatch
  local ok, err = pcall(function() vim.cmd("source " .. session_dir .. "/Session.vim") end)
  if not ok then
    vim.notify("Failed to load session: " .. err, vim.log.levels.ERROR)
    return false
  end
  vim.notify("Session sourced: " .. session_dir .. "/Session.vim", vim.log.levels.INFO)
  return true
end

return M
