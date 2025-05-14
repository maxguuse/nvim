return {
  "stevearc/conform.nvim",
  lazy = true,
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },
        go = {
          "gofmt",
          "goimports",
          "gci",
          "golines",
        },
        sql = { "sqlfmt" },
        yaml = { "yamlfmt" },
        fish = { "fish" },
      },
      formatters = {
        fish = {
          command = "fish_indent",
          args = { "-w", "$FILENAME" },
          stdin = false,
        },
      },
      format_on_save = false,
      format_after_save = {
        lsp_format = "fallback",
        async = true,
      },
    })

    require("conform").formatters.golines = {
      args = { "--no-chain-split-dots" },
    }

    require("conform").formatters.yamlfmt = {}
  end,
}
