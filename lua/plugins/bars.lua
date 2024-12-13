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
