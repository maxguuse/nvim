--- Proudly stolen from echasnovski config
local predicate = function(notif)
  if not (notif.data.source == "lsp_progress" and notif.data.client_name == "luals") then return true end
  -- Filter out some LSP progress notifications from 'lua_ls'
  return notif.msg:find("Diagnosing") == nil and notif.msg:find("semantic tokens") == nil
end
local custom_sort = function(notif_arr) return require("mini.notify").default_sort(vim.tbl_filter(predicate, notif_arr)) end

vim.notify = require("mini.notify").make_notify()

return {
  content = {
    sort = custom_sort,
  },
}
