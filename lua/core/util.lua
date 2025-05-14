local M = {}

function M.GetProjectRoot()
  local git_root = vim.fs.root(0, '.git')

  if git_root and git_root ~= "" then
    return git_root
  end

  local workspace = vim.lsp.buf.list_workspace_folders()[1]
  if workspace and workspace ~= "" then
    return workspace
  end

  return vim.loop.cwd()
end

return M
