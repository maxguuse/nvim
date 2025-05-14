local ggoose = vim.api.nvim_create_augroup("ggoose", { clear = true })

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  group = ggoose,
  once = true,
  callback = function()
    vim.lsp.config("*", {
      capabilities = {
        textDocument = {
          foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
          },
          semanticTokens = {
            multilineTokenSupport = true,
          },
        },
      },
    })

    vim.lsp.enable({
      "gopls",
      "sqls",
      "luals",
      "bashls",
      "jsonls",
      "cssls",
      "yamlls",
    })
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = ggoose,
  callback = function(event)
    local opts = { buffer = event.buf }

    vim.keymap.set("n", "gdf", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
    vim.keymap.set("n", "gdc", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
    vim.keymap.set("n", "gdt", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
  end,
})
