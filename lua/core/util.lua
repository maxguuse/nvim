local M = {}

function M.get_project_root()
  local git_root = vim.fs.root(0, { ".git", "Session.vim" })

  if git_root and git_root ~= "" then return git_root end

  local workspace = vim.lsp.buf.list_workspace_folders()[1]
  if workspace and workspace ~= "" then return workspace end

  return vim.loop.cwd()
end

local function is_protected_home_subdir(dir)
  if dir == nil or dir == "" then error("Should pass dir in is_protected_home_subdir") end

  local home = vim.env.HOME

  -- Normalize paths for comparison (remove trailing slashes)
  dir = dir:gsub("/+$", "")
  home = home:gsub("/+$", "")

  -- Check if we're in a direct subdirectory of HOME
  local parent_dir = dir:match("^(.*)/[^/]+$")
  if parent_dir == home then return true end

  return false
end

function M.is_protected_dir(dir)
  if dir == nil or dir == "" then error("Should pass dir to M.is_protected_dir") end

  local home = vim.env.HOME

  -- Normalize paths for comparison (remove trailing slashes)
  dir = dir:gsub("/+$", "")
  home = home:gsub("/+$", "")

  if dir == home then return true end
  if not dir:match("^" .. home) then return true end
  if is_protected_home_subdir(dir) then return true end

  local protected_dirs = {}

  for _, path in ipairs(protected_dirs) do
    local excluded_path = home .. "/" .. path
    if path == excluded_path then return true end
  end

  return false
end

return M
