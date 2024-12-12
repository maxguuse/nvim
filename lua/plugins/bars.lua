local function get_relative_path()
	local workspace = vim.lsp.buf.list_workspace_folders()[1]
	if workspace and workspace ~= "" then
		return workspace
	end

	local buffer_path = vim.fn.getcwd()
	return buffer_path
end

return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			{
				"echasnovski/mini.icons",
				version = false,
			},
		},
		opts = {
			options = {
				icons_enabled = true,
				theme = "auto",
				component_separators = { left = "|", right = "|" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {},
				ignore_focus = {},
				always_divide_middle = true,
				globalstatus = false,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { "filename" },
				lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
		},
	},

	{
		"Bekaboo/dropbar.nvim",
		lazy = true,
		event = {
			"BufEnter",
		},
		opts = {
			sources = {
				path = {
					relative_to = get_relative_path,
				},
			},
		},
	},
}
