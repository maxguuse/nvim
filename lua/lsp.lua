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
	group = ggoose_lsp,
	callback = function(event)
		local opts = { buffer = event.buf }

		vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
		vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
		vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
		vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
		vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
		vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
		vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
		vim.keymap.set("n", "<leader>gr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
		vim.keymap.set({ "n", "x" }, "<F3>", '<cmd>lua require("conform").format()<cr>', opts)
		vim.keymap.set("n", "<C-CR>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
	end,
})
