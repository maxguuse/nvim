local M = {}

function M.find_session_root()
	local file_path = ""
	local session_file = vim.fs.find({ "Session.vim" }, {
		path = vim.fn.getcwd(),
		upward = true,
	})[1]
	if session_file ~= nil then
		file_path = vim.fs.dirname(session_file)
	end

	return file_path
end

function M.source(session_file_path)
	if session_file_path == "" then
		return
	end

	vim.cmd("source " .. session_file_path)
end

function M.make_new_session()
	local file_path = ""
	local session_file_path = vim.fs.find({
		".git",
		"package.json",
		"go.work",
		"go.mod",
		".luarc.json",
		".luarc.jsonc",
		".luacheckrc",
		".stylua.toml",
		"stylua.toml",
		"selene.toml",
		"selene.yml",
	}, {
		path = vim.fn.getcwd(),
		upward = true,
		stop = vim.env.HOME,
	})[1]
	if session_file_path ~= nil then
		file_path = vim.fs.dirname(session_file_path)
	end

	if file_path == "" then
		vim.notify("Current file isn't placed in any project", vim.log.levels.INFO)
		return
	end

	local command = string.format("mksession %s", vim.fn.fnameescape(file_path .. "/Session.vim"))
	vim.cmd(command)
end

return M
