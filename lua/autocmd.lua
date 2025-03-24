local ggoose = vim.api.nvim_create_augroup("ggoose", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
	group = ggoose,
	callback = function()
		local filename = os.getenv("NVIM_LAST_FILENAME")
		if filename == nil then
			return
		end
		local last_dir_file = os.getenv("HOME") .. "/.cache/nvim/last_dir/" .. filename
		local current_dir = vim.fn.getcwd()
		vim.fn.writefile({ current_dir }, last_dir_file)
	end,
})

local kittyStyles = vim.api.nvim_create_augroup("KittyStyles", { clear = true })
vim.api.nvim_create_autocmd("UIEnter", {
	group = kittyStyles,
	callback = function()
		local sock = os.getenv("KITTY_LISTEN_ON")
		if sock == nil then
			error("KITTY_LISTEN_ON not specified")
			return
		end

		vim.system({ "kitty", "@", "--to", sock, "set-spacing", "padding=0" })
	end,
})
vim.api.nvim_create_autocmd("UILeave", {
	group = kittyStyles,
	callback = function()
		local sock = os.getenv("KITTY_LISTEN_ON")
		if sock == nil then
			error("KITTY_LISTEN_ON not specified")
			return
		end

		local obj = vim.system({ "awk", "/^background/ {print $2}", "/home/ggoose/.config/kitty/theme.conf" }):wait()
		local color = string.format("background=%s", obj.stdout)

		vim.system({ "kitty", "@", "--to", sock, "set-colors", color })
		vim.system({ "kitty", "@", "--to", sock, "set-spacing", "padding=default" })
	end,
})
