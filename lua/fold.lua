local ggoose_fold = vim.api.nvim_create_augroup("ggoose_fold", { clear = true })
vim.api.nvim_create_autocmd("LspAttach", {
	group = ggoose_fold,
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client and client:supports_method("textDocument/foldingRange") then
			local win = vim.api.nvim_get_current_win()
			vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
		end

		vim.cmd("normal! zx") -- Refresh folds
	end,
})

function _G.custom_fold_text()
	local line = vim.fn.getline(vim.v.foldstart):gsub("\t", string.rep(" ", vim.o.tabstop))
	local line_count = vim.v.foldend - vim.v.foldstart + 1
	local suffix = (" 󰁂 %d "):format(line_count)

	return {
		{ line, "Comment" },
		{ suffix, "MoreMsg" },
	}
end

vim.o.foldenable = true
vim.o.foldcolumn = "0"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99

vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.wo.foldmethod = "expr"

vim.opt.foldtext = "v:lua.custom_fold_text()"
