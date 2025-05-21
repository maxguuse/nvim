local M = {}

local saved_sessions_file = vim.fn.stdpath("data") .. "/ggoose_sessions"

function M.read_saved_sessions()
  if vim.fn.filereadable(saved_sessions_file) == 0 then vim.fn.writefile({}, saved_sessions_file) end

  return vim.fn.readfile(saved_sessions_file)
end

function M.save_session(session)
  if session == "" then return end
  if vim.tbl_contains(M.read_saved_sessions(), session) then return end

  vim.fn.writefile({ session }, saved_sessions_file, "a")
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
