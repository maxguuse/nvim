local ggoose_system = vim.api.nvim_create_augroup("ggoose_system", { clear = true })

vim.api.nvim_create_autocmd("UILeave", {
  group = ggoose_system,
  callback = function()
    local last_dir_file = os.getenv("NVIM_LAST_FILENAME")
    if last_dir_file == nil then return end

    local current_dir = vim.fn.getcwd()
    if not require("core.util").is_protected_dir(current_dir) then vim.fn.writefile({ current_dir }, last_dir_file) end
  end,
})

vim.api.nvim_create_autocmd("UIEnter", {
  group = ggoose_system,
  callback = function()
    local sock = vim.env.KITTY_LISTEN_ON
    if sock == nil then
      error("KITTY_LISTEN_ON not specified")
      return
    end

    vim.system({ "kitty", "@", "--to", sock, "set-spacing", "padding=0" })
  end,
})

vim.api.nvim_create_autocmd("UILeave", {
  group = ggoose_system,
  callback = function()
    local sock = vim.env.KITTY_LISTEN_ON
    if sock == nil then
      error("KITTY_LISTEN_ON not specified")
      return
    end

    vim.system({ "kitty", "@", "--to", sock, "set-spacing", "padding=default" })
  end,
})
