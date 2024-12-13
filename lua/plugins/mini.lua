local function active_statusline()
	local MiniStatusline = require("mini.statusline")

	local git = MiniStatusline.section_git({ trunc_width = 40 })
	local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
	local filename = MiniStatusline.section_filename({ trunc_width = 140 })

	return MiniStatusline.combine_groups({
		{ hl = "MiniStatuslineDevinfo", strings = { git } },
		{ hl = "MiniStatuslineDevinfo", strings = { diagnostics } },
		{ hl = "MiniStatuslineFilename", strings = { filename } },
	})
end

local function inactive_statusline()
	return "%#MiniStatuslineInactive#%F%="
end

return {
	{
		"echasnovski/mini.icons",
		version = false,
		lazy = true,
		opts = {},
	},
	{
		"echasnovski/mini.statusline",
		version = false,
		dependencies = {
			"echasnovski/mini.icons",
		},
		opts = {
			content = {
				active = active_statusline,
				inactive = inactive_statusline,
			},

			use_icons = true,
			set_vim_settings = true,
		},
	},
}
