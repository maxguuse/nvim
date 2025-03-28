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
				keys = {
					{ icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
					{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
					{
						icon = " ",
						key = "g",
						desc = "Find Text",
						action = ":lua Snacks.dashboard.pick('live_grep')",
					},
					{
						icon = " ",
						key = "c",
						desc = "Config",
						action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
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
				{ icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
				{ icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
				{ icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
				{ section = "startup" },
			},
		},
		picker = {},
		bigfile = {},
		quickfile = {},
		input = {},
	},
}
