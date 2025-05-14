--- Proudly stolen from echasnovski config
local mini_files = vim.api.nvim_create_augroup('ggoose-mini-files', {})
vim.api.nvim_create_autocmd('User', {
  group = mini_files,
  pattern = 'MiniFilesExplorerOpen',
  callback = function()
    require("mini.files").set_bookmark('c', vim.fn.stdpath('config'), { desc = 'Config' })
    require("mini.files").set_bookmark('w', require("core.util").GetProjectRoot(), { desc = 'Project root' })
  end,
})

return {
  windows = {
    preview = true,
  }
}
