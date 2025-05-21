local ggoose = vim.api.nvim_create_augroup("ggoose", { clear = true })
vim.api.nvim_create_autocmd("UILeave", {
  group = ggoose,
  callback = function()
    local last_dir_file = os.getenv("NVIM_LAST_FILENAME")
    if last_dir_file == nil then return end

    local current_dir = vim.fn.getcwd()
    if not require("core.util").is_protected_dir(current_dir) then vim.fn.writefile({ current_dir }, last_dir_file) end
  end,
})

vim.api.nvim_create_autocmd("UIEnter", {
  group = ggoose,
  once = true,
  callback = function()
    vim.schedule(
      function() vim.notify("UIEnter: " .. require("lazy.stats").stats().times.UIEnter, vim.log.levels.INFO) end
    )
  end,
})

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
  group = ggoose,
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

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function(args)
    if vim.bo[args.buf].buftype ~= "help" then return end

    vim.keymap.set("n", "q", "<cmd>exit<CR>", { buffer = args.buf, desc = "Quick exit for help windows" })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  group = ggoose,
  desc = "Markdown-specific settings",
  callback = function(args)
    -- Enable wrap only for Markdown
    vim.wo.wrap = true

    -- Buffer-local keymaps for visual line movement
    local opts = { buffer = args.buf, desc = "Move by display line" }
    vim.keymap.set("n", "k", "gk", opts)
    vim.keymap.set("n", "j", "gj", opts)
    vim.keymap.set("n", "0", "g0", opts)
    vim.keymap.set("n", "$", "g$", opts)

    -- Cleanup when leaving Markdown (better than BufEnter check)
    vim.api.nvim_create_autocmd("BufWinLeave", {
      buffer = args.buf,
      once = true,
      callback = function()
        if vim.bo.filetype == "markdown" then -- Double-check
          vim.wo.wrap = false
        end
      end,
    })
  end,
})

--- Kitty styling ----------------------------------------------------------------------
vim.api.nvim_create_autocmd("UIEnter", {
  group = ggoose,
  callback = function()
    local sock = vim.env.KITTY_LISTEN_ON
    if sock == nil then
      error("KITTY_LISTEN_ON not specified")
      return
    end

    vim.system({ "kitty", "@", "--to", sock, "set-spacing", "padding=0" })
  end,
})

vim.api.nvim_create_autocmd("UILeave", {
  group = ggoose,
  callback = function()
    local sock = vim.env.KITTY_LISTEN_ON
    if sock == nil then
      error("KITTY_LISTEN_ON not specified")
      return
    end

    vim.system({ "kitty", "@", "--to", sock, "set-spacing", "padding=default" })
  end,
})
