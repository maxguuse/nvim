local ggoose = vim.api.nvim_create_augroup("ggoose", { clear = true })
vim.api.nvim_create_autocmd("UILeave", {
  group = ggoose,
  callback = function()
    local last_dir_file = os.getenv("NVIM_LAST_FILENAME")
    if last_dir_file == nil then return end

    local current_dir = vim.fn.getcwd()
    vim.fn.writefile({ current_dir }, last_dir_file)
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

--- Session management -----------------------------------------------------------------
local session = require("core.session")
-- Auto-save on exit
vim.api.nvim_create_autocmd("VimLeavePre", {
  group = ggoose,
  callback = require("core.session").write_session,
})

vim.api.nvim_create_autocmd("VimEnter", {
  group = ggoose,
  callback = function()
    if vim.fn.argc() ~= 0 then return end
    vim.schedule(function()
      local read = session.read_session()

      if read then return end

      if not read then
        session.write_session()

        vim.cmd('Pick files cwd=require("core.util").GetProjectRoot()')
        return
      end
    end)
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  group = ggoose,
  callback = function() vim.wo.wrap = true end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  group = ggoose,
  callback = function()
    if vim.bo.filetype ~= "markdown" then vim.wo.wrap = false end
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
