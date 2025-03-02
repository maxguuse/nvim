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
			"<leader>nd",
			function()
				require("snacks").toggle.dim():toggle()
			end,
		},
		{
			"<leader>nz",
			function()
				require("snacks").toggle.zen():toggle()
			end,
		},
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
			function()
				require("snacks").picker.projects()
			end,
			desc = "Projects",
		},
		{
			"<leader>pk",
			function()
				require("snacks").picker.keymaps()
			end,
			desc = "Keymaps",
		},
		{
			"<leader>pc",
			function()
				require("snacks").picker.lazy()
			end,
			desc = "Search for Plugin Spec",
		},
	},
	opts = {
		dashboard = {
			sections = {
				{ section = "header" },
				{ icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
				{ icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
				{ icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
				{ section = "startup" },
			},
		},
		scroll = {
			animate = {
				duration = { step = 10, total = 100 },
				easing = "linear",
			},
			spamming = 10, -- threshold for spamming detection
			-- what buffers to animate
			filter = function(buf)
				return vim.g.snacks_scroll ~= false
					and vim.b[buf].snacks_scroll ~= false
					and vim.bo[buf].buftype ~= "terminal"
			end,
		},
		picker = {},
		toggle = {},
		dim = {},
		zen = {},
		bigfile = {},
		quickfile = {},
		input = {},
	},
}
