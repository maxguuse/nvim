----- Disable arrow keys -----
vim.keymap.set({ "n", "i", "v" }, "<up>", "")
vim.keymap.set({ "n", "i", "v" }, "<down>", "")
vim.keymap.set({ "n", "i", "v" }, "<left>", "")
vim.keymap.set({ "n", "i", "v" }, "<right>", "")
------------------------------

--- Always center Ctrl+U/D ---
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
------------------------------

-- Escape terminal view
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

-- Escape search highlight
vim.keymap.set("n", "<leader>s", "<cmd>set hlsearch!<CR>")

---- Arglist manipulation ----
vim.keymap.set("n", "<C-l>", function()
	local arg_count = vim.fn.argc()
	if arg_count == 0 or arg_count == 1 then
		return
	end
	local current = vim.fn.argidx()
	if current + 1 >= arg_count then
		vim.cmd("argument 1") -- Go to first file
	else
		vim.cmd("next")
	end
end, { desc = "Next argument (wrap)" })

vim.keymap.set("n", "<C-h>", function()
	local arg_count = vim.fn.argc()
	if arg_count == 0 or arg_count == 1 then
		return
	end
	local current = vim.fn.argidx()
	if current - 1 < 0 then
		vim.cmd("argument " .. arg_count) -- Go to last file
	else
		vim.cmd("previous")
	end
end, { desc = "Previous argument (wrap)" })

vim.keymap.set("n", "<C-s>", function()
	local arglist = vim.fn.argv()
	local file = vim.fn.expand("%")

	local is_present = vim.fn.index(arglist, file)

	if is_present ~= -1 then
		vim.cmd("argdelete")
		return
	end

	vim.cmd("argadd")
	vim.cmd("last")
end, { desc = "Toggle file in arglist" })
------------------------------
