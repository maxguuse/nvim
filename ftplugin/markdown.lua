-- Enable wrap only for Markdown
vim.wo.wrap = true

-- Buffer-local keymaps for visual line movement
local opts = { buffer = true, desc = "Move by display line" }
vim.keymap.set("n", "k", "gk", opts)
vim.keymap.set("n", "j", "gj", opts)
vim.keymap.set("n", "0", "g0", opts)
vim.keymap.set("n", "$", "g$", opts)
