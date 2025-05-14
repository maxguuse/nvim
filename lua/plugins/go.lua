return {
	{
		"ray-x/go.nvim",
		opts = {},
		ft = { "go", "gomod", "gowork" },
		build = ':lua require("go.install").update_all_sync()',
	},
}
