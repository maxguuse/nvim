return {
	{
		"ray-x/go.nvim",
		dependencies = { -- optional packages
			"ray-x/guihua.lua",
		},
		opts = {},
		ft = { "go", "gomod", "gowork" },
		build = ':lua require("go.install").update_all_sync()',
	},
}
