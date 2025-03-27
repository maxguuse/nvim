return {
	cmd = { "yaml-language-server", "--stdio" },
	filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
	root_markers = {
		".git",
	},
	settings = {
		redhat = { telemetry = { enabled = false } },
	},
	capabilities = {
		documentFormattingProvider = false,
		documentFormattingRangeProvider = false,
	},
}
