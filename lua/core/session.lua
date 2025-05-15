local M = {}

M.write_session = function()
  local util = require("core.util")

  local project_root, session_file

  if vim.v.this_session ~= "" then
    session_file = vim.v.this_session
  else
    project_root = util.GetProjectRoot()
    session_file = project_root .. "/Session.vim"
  end

  if util.IsProtectedDir(project_root) then
    vim.notify("Session cannot be saved to protected directory: " .. project_root, vim.log.levels.WARN)
    return
  end

  vim.cmd("mksession! " .. vim.fn.fnameescape(session_file))
  vim.notify("Session saved to: " .. session_file, vim.log.levels.INFO)
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
