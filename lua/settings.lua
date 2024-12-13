local opt = vim.opt

opt.cursorline = true
opt.cursorcolumn = true

opt.number = true
opt.relativenumber = true

opt.showmode = true
opt.termguicolors = true

opt.splitright = true
opt.splitbelow = true

opt.completeopt = "menu,menuone,preview,noselect"
opt.inccommand = "split"

opt.breakindent = true
opt.wrap = false

opt.undofile = true

opt.signcolumn = "yes"

opt.scrolloff = 5
opt.updatetime = 250
opt.timeoutlen = 2000

opt.list = true
opt.listchars = { tab = "→ ", trail = "·", nbsp = "␣" }

opt.autochdir = true

opt.ignorecase = true
opt.smartcase = true
opt.showmatch = true

opt.shiftwidth = 4
opt.tabstop = 4
opt.smartindent = true

-- For ufo.nvim purposes
vim.o.foldenable = true
vim.o.foldcolumn = "0"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99

vim.schedule(function()
	opt.clipboard = "unnamedplus"
end)
