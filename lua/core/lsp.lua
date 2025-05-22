local ggoose_lsp = vim.api.nvim_create_augroup("ggoose_lsp", { clear = true })
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  group = ggoose_lsp,
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
      "sqls",
      "luals",
      "bashls",
      "jsonls",
      "cssls",
      "yamlls",
    })

    vim.keymap.del({ "i", "s" }, "<C-S>") -- Replaced with "<M-s>" by blink.cmp (signature help)
    vim.keymap.del("n", "gO") -- Replaced with "cs" by mini.pick (document symbols)
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = ggoose_lsp,
  callback = function(event)
    local opts = { buffer = event.buf }

    vim.keymap.set("n", "gdf", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
    vim.keymap.set("n", "gdc", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
    vim.keymap.set("n", "gdt", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
  end,
})

vim.api.nvim_create_autocmd("CursorHold", {
  callback = function() vim.diagnostic.open_float({ border = "single", scope = "cursor", source = "if_many" }) end,
})
