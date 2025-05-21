local M = {}

local util = require("core.util")

local session_filename = "Session.vim"
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

function M.read_session(session_file)
  local session_dir = vim.fs.root(0, session_filename)
  local session = session_file or (session_dir and vim.fs.joinpath(session_dir, session_filename))

  if not session then return false end

  if vim.fn.filereadable(session) == 0 then
    vim.notify(("Session file does not exist or is not readable: %s"):format(session), vim.log.levels.ERROR)
    return false
  end

  local ok, err = pcall(vim.cmd.source, session)
  if not ok then
    vim.notify(("Failed to load session %s: %s"):format(session, err), vim.log.levels.ERROR)
    return false
  end

  vim.notify(("Sourced session: %s"):format(session), vim.log.levels.INFO)
  return true
end

function M.write_session(session_file)
  local project_root = util.get_project_root()
  local session = session_file or (project_root and vim.fs.joinpath(project_root, session_filename))

  if project_root and project_root ~= "" and util.is_protected_dir(project_root) then
    vim.notify(("Session cannot be saved to protected directory: %s"):format(project_root), vim.log.levels.WARN)
    return false
  end

  local ok, err = pcall(vim.cmd.mksession, { args = { session }, bang = true })
  if not ok then
    vim.notify(("Failed to save session %s: %s"):format(session, err), vim.log.levels.ERROR)
    return false
  end

  -- TODO: one day frecency will be handled here
  M.save_session(session)

  vim.notify(("Session written: %s"):format(session), vim.log.levels.INFO)
  return true
end

--- Commands --------------------------------------------------------------------------------------------------------
vim.api.nvim_create_user_command("MakeSession", M.write_session, {
  desc = "Create new Session.vim file at project root or overwrite existing one",
})

vim.api.nvim_create_user_command("RestoreSession", function(args)
  local read = M.read_session()

  if read then return end

  if not read and args.bang then
    M.write_session()
    return
  end

  vim.notify("No Session.vim file found", vim.log.levels.INFO)
end, {
  bang = true,
  desc = "Try to find and restore Session.vim at project root, call with bang to force create new Session.vim",
})

--- Autocommands ----------------------------------------------------------------------------------------------------
local ggoose_sessions = vim.api.nvim_create_augroup("ggoose_sessions", { clear = true })
vim.api.nvim_create_autocmd("VimEnter", {
  group = ggoose_sessions,
  desc = "Autoreads session from project root",
  callback = function()
    if vim.fn.argc() ~= 0 or #vim.v.argv > 2 then return end

    vim.schedule(M.read_session)
  end,
})

vim.api.nvim_create_autocmd("VimLeavePre", {
  group = ggoose_sessions,
  desc = "Autowrites session to project root",
  callback = function()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.bo[buf].buftype == "" and vim.api.nvim_buf_get_name(buf) ~= "" then
        vim.schedule(M.write_session)
        return
      end
    end
  end,
})

--- Keymaps ---------------------------------------------------------------------------------------------------------
vim.keymap.set("n", "<leader>pp", function()
  local sessions = M.read_saved_sessions()

  vim.ui.select(sessions, {
    prompt = "Select session",
  }, function(item, _)
    if not item or item == vim.v.this_session then return end
    M.write_session()
    M.read_session(item)
  end)
end)

--- Options ---------------------------------------------------------------------------------------------------------
vim.o.sessionoptions = "buffers,curdir,folds,terminal,winsize"

return M
