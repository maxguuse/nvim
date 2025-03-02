local modes = {
	["n"] = "NO",
	["i"] = "IN",
	["v"] = "VI",
	["V"] = "VL",
	["\x16"] = "VB",
	["c"] = "CO",
	["t"] = "TE",
}

local function statusline_mode()
	local mode = vim.fn.mode()
	local mode_str = (mode == "n" and (vim.bo.ro or not vim.bo.ma)) and "RO" or modes[mode]

	return string.format(" %s ", mode_str)
end

local function statusline_filename()
	if vim.bo.buftype == "terminal" then
		return "%t"
	end

	return "%f%m"
end

local function statusline_arrow()
	local arrow = require("arrow.statusline")
	local is_saved = arrow.is_on_arrow_file()

	if is_saved then
		return string.format("󱡁%s", is_saved)
	end
end

local function active_statusline()
	local MiniStatusline = require("mini.statusline")

	local mode = statusline_mode()
	local git = MiniStatusline.section_git({ trunc_width = 40 })
	local filename = statusline_filename()
	local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
	local arrow = statusline_arrow()

	return MiniStatusline.combine_groups({
		{ strings = { mode } },
		{ strings = { git } },
		{ strings = { filename, arrow } },
		{ strings = { diagnostics } },
	})
end

local function inactive_statusline()
	return "%#MiniStatuslineInactive#%F%="
end

return {
	{
		"echasnovski/mini.nvim",
		version = false,
		lazy = false,
		keys = {
			{
				"<leader>mf",
				"<cmd>lua =require'mini.files'.open()<CR>",
				"Mini Files",
			},
		},
		config = function()
			require("mini.icons").setup()

			require("mini.splitjoin").setup()
			require("mini.cursorword").setup()

			require("mini.pairs").setup()
			require("mini.surround").setup()

			require("mini.files").setup()

			require("mini.git").setup()
			require("mini.statusline").setup({
				content = {
					active = active_statusline,
					inactive = inactive_statusline,
				},

				use_icons = true,
				set_vim_settings = true,
			})

			require("mini.hipatterns").setup({
				highlighters = {
					fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
					hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
					todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
					note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

					hex_color = require("mini.hipatterns").gen_highlighter.hex_color(),
				},
			})
		end,
	},
}
