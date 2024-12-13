vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		local last_dir_file = os.getenv("HOME") .. "/.config/nvim/.last_nvim_dir"
		local current_dir = vim.fn.getcwd()
		vim.fn.writefile({ current_dir }, last_dir_file)
	end,
})

vim.api.nvim_create_augroup("KittyStyles", { clear = true })
vim.api.nvim_create_autocmd("UIEnter", {
	group = "KittyStyles",
	callback = function()
		local sock = os.getenv("KITTY_LISTEN_ON")

		vim.system({ "kitty", "@", "--to", sock, "set-spacing", "padding=0" })
	end,
})
vim.api.nvim_create_autocmd("UILeave", {
	group = "KittyStyles",
	callback = function()
		local sock = os.getenv("KITTY_LISTEN_ON")

		vim.system({ "kitty", "@", "--to", sock, "set-spacing", "padding=default" })
	end,
})
vim.api.nvim_create_autocmd("ColorScheme", {
	group = "KittyStyles",
	callback = function()
		local hl_id = vim.api.nvim_get_hl_id_by_name("Normal")
		local rgb = vim.api.nvim_get_hl(0, { id = hl_id })
		local sock = os.getenv("KITTY_LISTEN_ON")
		local color = string.format("background=#%06x", rgb.bg)

		vim.system({ "kitty", "@", "--to", sock, "set-colors", color })
	end,
})
