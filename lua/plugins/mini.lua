return {
  "echasnovski/mini.nvim",
  version = false,
  lazy = false,
  keys = {
    {
      "<leader>mf",
      "<cmd>lua =require'mini.files'.open()<CR><CR>",
      "Mini Files",
    },
    {
      "<leader>pf",
      "<cmd>Pick files cwd=require('core.util').get_project_root()<CR>",
      "Find Files",
    },
    {
      "<leader>pg",
      "<cmd>Pick grep_live cwd=require('core.util').get_project_root()<CR>",
      "Live Grep",
    },
    {
      "<leader>pk",
      "<cmd>Pick keymaps<CR>",
      "Keymaps",
    },
    {
      "<leader>po",
      "<cmd>Pick oldfiles<CR>",
      "Recent Files",
    },
    {
      "<leader>cx",
      "<cmd>Pick diagnostic<CR>",
      "Diagnostics",
    },
    {
      "<leader>cs",
      '<cmd>Pick lsp scope="document_symbol"<CR>',
      "Symbols",
    },
  },
  config = function()
    require("mini.icons").setup(require("config.mini.icons"))
    require("mini.extra").setup()
    require("mini.misc").setup_termbg_sync()
    require("mini.hipatterns").setup(require("config.mini.hipatterns"))

    require("mini.pairs").setup()
    require("mini.surround").setup()
    require("mini.jump").setup(require("config.mini.jump"))
    require("mini.splitjoin").setup()

    require("mini.git").setup()
    require("mini.statusline").setup(require("config.mini.statusline"))

    require("mini.files").setup(require("config.mini.files"))
    require("mini.pick").setup(require("config.mini.pick"))

    require("mini.notify").setup(require("config.mini.notify"))
  end,
}
