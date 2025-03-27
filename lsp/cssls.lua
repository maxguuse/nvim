return {
	cmd = { "vscode-css-language-server", "--stdio" },
	filetypes = { "css", "scss", "less" },
	root_markers = {
		"package.json",
		".git",
	},
	settings = {
		css = { validate = false },
		scss = { validate = false },
		less = { validate = false },
	},
	capabilities = {
		documentFormattingProvider = false,
		documentFormattingRangeProvider = false,
	},
}
