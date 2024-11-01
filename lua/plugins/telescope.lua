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
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-telescope/telescope-fzf-native.nvim",
			"nvim-telescope/telescope-project.nvim",
			"debugloop/telescope-undo.nvim",

			"nvim-lua/plenary.nvim",
		},
		cmd = { "Telescope" },
		keys = {
			{
				"<leader>pf",
				function()
					require("telescope.builtin").find_files({
						cwd = get_cwd(),
					})
				end,
				"Project files",
			},
			{
				"<leader>pg",
				function()
					require("telescope.builtin").live_grep({
						cwd = get_cwd(),
					})
				end,
				"Live grep from project files",
			},
			{
				"<leader>pp",
				"<cmd>lua =require'telescope'.extensions.project.project({ display_type='full' })<CR>",
				"Projects",
			},
			{ "<leader>pu", "<cmd>Telescope undo<CR>", "Undo tree" },
			{ "<leader>ps", "<cmd>Telescope git_status<CR>", "Git status" },
		},
		config = function()
			local telescope = require("telescope")

			telescope.setup({
				defaults = {
					initial_mode = "normal",
				},
				extensions = {
					-- ["ui-select"] = {
					-- 	require("telescope.themes").get_dropdown({}),
					-- },
					["lazy_plugins"] = {
						lazy_config = vim.fn.stdpath("config") .. "/init.lua",
					},
					["project"] = {
						sync_with_nvim_tree = true,
					},
				},
			})

			telescope.load_extension("fzf")
			telescope.load_extension("project")
			telescope.load_extension("refactoring")
		end,
	},
}
