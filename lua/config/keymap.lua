--- Lazy -----------------------------------------------------------------------------------------------------
vim.keymap.set("n", "<leader>ll", ":Lazy<CR>", { desc = "Lazy" })

--- Some convenient stuff ------------------------------------------------------------------------------------
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Insert mode in terminal" })
vim.keymap.set("n", "<leader>s", "<cmd>set hlsearch!<CR>", { desc = "Toggle search highlight" })
vim.keymap.set({ "n", "x" }, "s", "<Nop>", { desc = "Disabled for the sake of mini.surround" })

--- Arglist manipulation -------------------------------------------------------------------------------------
vim.keymap.set("n", "<C-l>", require("core.arglist").next, { desc = "Next argument (wrap)" })
vim.keymap.set("n", "<C-h>", require("core.arglist").prev, { desc = "Previous argument (wrap)" })
vim.keymap.set("n", "<C-s>", require("core.arglist").toggle, { desc = "Toggle file in arglist" })

--- Cool stuff (stolen from ThePrimeagen) --------------------------------------------------------------------
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection up with auto indent" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection down with auto indent" })

vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Jump up by half screen and keep cursor in the middle" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Jump down by half screen and keep cursor in the middle" })

vim.keymap.set("n", "n", "nzzzv", { desc = "Search next and keep cursor in the middle" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Search previous and keep cursor in the middle" })

vim.keymap.set("n", "<leader>d", '"_d', { desc = "Delete to void register" })
vim.keymap.set("v", "<leader>d", '"_d', { desc = "Delete to void register" })

vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Paste without replacing clipboard content" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "Append line below to current line and keep cursor in place" })

vim.keymap.set("i", "<C-c>", "<Esc>", { desc = "For the sake of visual block mode editing" })
