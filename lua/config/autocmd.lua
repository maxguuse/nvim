local ggoose = vim.api.nvim_create_augroup("ggoose", { clear = true })
vim.api.nvim_create_autocmd("UILeave", {
  group = ggoose,
  callback = function()
    local last_dir_file = os.getenv("NVIM_LAST_FILENAME")
    if last_dir_file == nil then return end

    local current_dir = vim.fn.getcwd()
    if not require("core.util").IsProtectedDir(current_dir) then vim.fn.writefile({ current_dir }, last_dir_file) end
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

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function(args)
    local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })
    if buftype ~= "help" then return end

    vim.keymap.set("n", "q", "<cmd>exit<CR>", { buffer = args.buf, desc = "Quick exit for help windows" })
  end,
})

--- Session management -----------------------------------------------------------------
local session = require("core.session")
-- Auto-save on exit
vim.api.nvim_create_autocmd("VimLeavePre", {
  group = ggoose,
  callback = function()
    local has_normal_buffers = false
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_loaded(buf) then
        local buftype = vim.api.nvim_get_option_value("buftype", { buf = buf })
        local bufname = vim.api.nvim_buf_get_name(buf)
        if buftype == "" and bufname ~= "" then
          has_normal_buffers = true
          break
        end
      end
    end

    if not has_normal_buffers then return end

    session.write_session()
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  group = ggoose,
  callback = function()
    if vim.fn.argc() ~= 0 or #vim.v.argv > 2 then return end
    vim.schedule(function()
      local read = session.read_session()

      if read then return end

      if not read then
        local written = session.write_session()
        if not written then
          vim.cmd("Pick oldfiles")
          return
        end

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

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function(args)
    local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })
    if buftype ~= "" then return end

    require("core.arglist").set_keymaps(args.buf)
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
