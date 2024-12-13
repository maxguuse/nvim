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
		"echasnovski/mini.files",
		version = false,
		keys = {
			{
				"<leader>mf",
				"<cmd>lua =require'mini.files'.open()<CR>",
				"Mini Files",
			},
		},
		opts = {},
	},
	{
		"echasnovski/mini.pairs",
		version = false,
		event = "InsertEnter",
		opts = {},
	},
	{
		"echasnovski/mini.surround",
		version = false,
		opts = {},
	},
	{
		"echasnovski/mini-git",
		version = false,
		config = function()
			require("mini.git").setup()
		end,
	},
	{
		"echasnovski/mini.hipatterns",
		version = false,
		config = function()
			local hipatterns = require("mini.hipatterns")
			hipatterns.setup({
				highlighters = {
					fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
					hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
					todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
					note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

					hex_color = hipatterns.gen_highlighter.hex_color(),
				},
			})
		end,
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
