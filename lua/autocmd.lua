local ggoose = vim.api.nvim_create_augroup("ggoose", { clear = true })
vim.api.nvim_create_autocmd("UILeave", {
	group = ggoose,
	callback = function()
		local last_dir_file = os.getenv("NVIM_LAST_FILENAME")
		if last_dir_file == nil then
			return
		end

		local current_dir = vim.fn.getcwd()
		vim.fn.writefile({ current_dir }, last_dir_file)
	end,
})
