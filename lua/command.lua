vim.api.nvim_create_user_command("MakeSession", require("core.sessions").make_new_session, {})
