return {
	"echasnovski/mini.files",
	version = "*",
	keys = {
		{
			"<leader>mf",
			"<cmd>lua =require'mini.files'.open()<CR>",
			"Mini Files",
		},
	},
	opts = {},
	-- config = function()
	-- 	require("mini.files").setup()
	-- end,
}
