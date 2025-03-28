function _G.custom_fold_text()
	local line = vim.fn.getline(vim.v.foldstart)
	local line_count = vim.v.foldend - vim.v.foldstart + 1
	local suffix = (" 󰁂 %d "):format(line_count)

	return line .. " " .. suffix
end

vim.o.foldenable = true
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldcolumn = "0"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99

vim.opt.foldtext = "v:lua.custom_fold_text()"
