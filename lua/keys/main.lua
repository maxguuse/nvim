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
