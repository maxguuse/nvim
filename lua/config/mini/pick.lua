require("mini.pick").registry.files = function(local_opts)
  local opts = { source = { cwd = local_opts.cwd } }
  local_opts.cwd = nil
  return require("mini.pick").builtin.files(local_opts, opts)
end

require("mini.pick").registry.grep_live = function(local_opts)
  local opts = { source = { cwd = local_opts.cwd } }
  local_opts.cwd = nil
  return require("mini.pick").builtin.grep_live(local_opts, opts)
end

require("mini.pick").registry.projects = function()
  local items = require("core.session").read_saved_sessions()

  local source = {
    items = items,
    name = "Projects",
    choose = function(item)
      vim.schedule(function()
        vim.cmd("source " .. item)
      end)
    end,
  }

  require("mini.pick").start({ source = source })
end

vim.ui.select = require("mini.pick").ui_select

return {}
