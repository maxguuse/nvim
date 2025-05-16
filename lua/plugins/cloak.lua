return {
  "laytan/cloak.nvim",
  lazy = true,
  event = { "BufReadPre" },
  config = function()
    require("cloak").setup({
      enabled = true,
      cloak_character = "*",
      highlight_group = "Comment",
      cloak_length = 5,
      try_all_patterns = true,
      cloak_on_leave = false,
      patterns = {
        {
          file_pattern = { "dev.env", ".env*" },
          cloak_pattern = "=.+",
        },
      },
    })
  end,
}
