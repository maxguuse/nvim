vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		local last_dir_file = os.getenv("HOME") .. "/.last_nvim_dir"
		local current_dir = vim.fn.getcwd()
		vim.fn.writefile({ current_dir }, last_dir_file)
	end,
})
