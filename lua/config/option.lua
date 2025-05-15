--- GLOBALS ---------------------------------------------------------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.omni_sql_no_default_maps = 1

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

--- GENERAL ---------------------------------------------------------------------------
vim.o.autoread = true
vim.o.autochdir = true

vim.o.swapfile = false
vim.o.undofile = true

vim.o.backup = false
vim.o.writebackup = false

vim.o.sessionoptions = "buffers,curdir,folds,help,terminal,winsize"
vim.o.clipboard = "unnamedplus"

vim.o.updatetime = 300
vim.o.timeoutlen = 2000

--- UI --------------------------------------------------------------------------------
vim.o.cursorline = true
vim.o.cursorlineopt = "screenline,number"

vim.o.scrolloff = 5
vim.o.cmdheight = 0

vim.o.number = true
vim.o.relativenumber = true

vim.o.wrap = false
vim.o.breakindent = true
vim.o.linebreak = true

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.list = true
vim.opt.listchars = { tab = "→ ", trail = "·", nbsp = "␣" }
vim.opt.fillchars = { eob = " ", fold = " " }

--- FOLDS -----------------------------------------------------------------------------
vim.o.foldenable = true
vim.o.foldcolumn = "0"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldmethod = "expr"
vim.o.foldtext = ""

--- EDITING ---------------------------------------------------------------------------
vim.o.autoindent = true
vim.o.smartindent = true

vim.o.shiftwidth = 2
vim.o.tabstop = 2

vim.o.expandtab = true
vim.o.formatoptions = "rqnl1j"
vim.o.virtualedit = "block"
vim.o.showmatch = true
vim.o.iskeyword = "@,48-57,_,192-255,-"

--- SEARCHING -------------------------------------------------------------------------
vim.o.inccommand = "split"
vim.o.incsearch = true

vim.o.ignorecase = true
vim.o.smartcase = true
