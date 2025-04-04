---@diagnostic disable-next-line: unused-local, unused-function
local function get_cwd()
	local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]

	if git_root and git_root ~= "" and vim.v.shell_error == 0 then
		return git_root
	end

	local workspace = vim.lsp.buf.list_workspace_folders()[1]
	if workspace and workspace ~= "" then
		return workspace
	end

	return vim.loop.cwd()
end

local ROOT = ""

return {
	"folke/snacks.nvim",
	lazy = false,
	keys = {
		{
			"<leader>pf",
			function()
				require("snacks").picker.files({
					cwd = get_cwd(),
				})
			end,
			desc = "Find Files",
		},
		{
			"<leader>pg",
			function()
				require("snacks").picker.grep({
					cwd = get_cwd(),
				})
			end,
			desc = "Grep",
		},
		{
			"<leader>pp",
			":lua Snacks.picker.projects()<CR>",
			desc = "Projects",
		},
		{
			"<leader>pk",
			":lua Snacks.picker.keymaps()<CR>",
			desc = "Keymaps",
		},
		{
			"<leader>cs",
			":lua Snacks.picker.lsp_symbols()<CR>",
			desc = "Symbols",
		},
		{
			"<leader>cx",
			":lua Snacks.picker.diagnostics()<CR>",
			desc = "Diagnostics",
		},
	},
	opts = {
		dashboard = {
			preset = {
				header = [[
  █████▒██▀███  ▓█████ ▄▄▄       ██ ▄█▀▓██   ██▓
▓██   ▒▓██ ▒ ██▒▓█   ▀▒████▄     ██▄█▒  ▒██  ██▒
▒████ ░▓██ ░▄█ ▒▒███  ▒██  ▀█▄  ▓███▄░   ▒██ ██░
░▓█▒  ░▒██▀▀█▄  ▒▓█  ▄░██▄▄▄▄██ ▓██ █▄   ░ ▐██▓░
░▒█░   ░██▓ ▒██▒░▒████▒▓█   ▓██▒▒██▒ █▄  ░ ██▒▓░
 ▒ ░   ░ ▒▓ ░▒▓░░░ ▒░ ░▒▒   ▓▒█░▒ ▒▒ ▓▒   ██▒▒▒ 
 ░       ░▒ ░ ▒░ ░ ░  ░ ▒   ▒▒ ░░ ░▒ ▒░ ▓██ ░▒░ 
 ░ ░     ░░   ░    ░    ░   ▒   ░ ░░ ░  ▒ ▒ ░░  
          ░        ░  ░     ░  ░░  ░    ░ ░     
                                        ░ ░     ]],
				keys = {
					{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
					{
						icon = " ",
						key = "s",
						desc = "Restore Session",
						enabled = function()
							ROOT = require("core.sessions").find_session_root()
							return ROOT ~= ""
						end,
						action = function()
							require("core.sessions").source(ROOT .. "/Session.vim")
						end,
					},
					{
						icon = " ",
						key = "f",
						desc = "Find File",
						action = function()
							require("snacks").picker.files({
								cwd = get_cwd(),
							})
						end,
					},
					{
						icon = " ",
						key = "g",
						desc = "Find Text",
						action = function()
							require("snacks").picker.grep({
								cwd = get_cwd(),
							})
						end,
					},
					{
						icon = " ",
						key = "c",
						desc = "Config",
						action = function()
							require("snacks").picker.files({
								cwd = vim.fn.stdpath("config"),
							})
						end,
					},
					{
						icon = "󰒲 ",
						key = "L",
						desc = "Lazy",
						action = ":Lazy",
						enabled = package.loaded.lazy ~= nil,
					},
					{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
				},
			},
			sections = {
				{ section = "header" },
				{ section = "keys", gap = 1, padding = 1 },
				{
					pane = 2,
					section = "terminal",
					cmd = "chafa ~/Pictures/Wallpapers/smoking.jpg --format symbols --symbols vhalf --size 60x50; sleep .1",
					height = 13,
					padding = 1,
				},
				{ pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
				{ pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
				{ section = "startup" },
			},
		},
		picker = {},
		bigfile = {},
		quickfile = {},
		input = {},
	},
}
