local session = require("core.session")
vim.api.nvim_create_user_command("MakeSession", session.write_session, {
  desc = "Create new Session.vim file at project root or overwrite existing one",
})

vim.api.nvim_create_user_command("RestoreSession", function(args)
  local read = session.read_session()

  if read then return end

  if not read and args.bang then
    session.write_session()
    return
  end

  vim.notify("No Session.vim file found", vim.log.levels.INFO)
end, {
  bang = true,
  desc = "Try to find Session.vim at project root and restore it, call with bang to force create new Session.vim",
})
