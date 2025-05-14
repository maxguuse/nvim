return {
  "slugbyte/lackluster.nvim",
  lazy = false,
  priority = 1000,
  init = function()
    vim.cmd.colorscheme("lackluster")

    --- Some basic styling customization, that way mini.nvim popups should look beautiful
    vim.api.nvim_set_hl(0, "FloatBorder", { link = "Comment" })
    vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
  end,
}
