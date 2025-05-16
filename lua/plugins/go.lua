return {
  {
    "ray-x/go.nvim",
    opts = {
      lsp_cfg = true,
      lsp_inlay_hints = {
        enable = false,
      },
    },
    ft = { "go", "gomod", "gowork" },
    build = ':lua require("go.install").update_all_sync()',
  },
}
