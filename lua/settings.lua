local opt = vim.opt

opt.autoread = true
opt.swapfile = false

opt.cursorline = true

opt.number = true
opt.relativenumber = true

opt.showmode = false
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
opt.fillchars = { eob = " ", fold = " " }

opt.autochdir = true

opt.ignorecase = true
opt.smartcase = true
opt.showmatch = true

opt.shiftwidth = 4
opt.tabstop = 4
opt.smartindent = true

opt.cmdheight = 0

opt.sessionoptions = "buffers,curdir,help,terminal,winsize"

require("fold")

vim.schedule(function()
	opt.clipboard = "unnamedplus"
end)
