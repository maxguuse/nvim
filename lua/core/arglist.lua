local M = {}

function M.info()
  return {
    count = vim.fn.argc(),
    index = vim.fn.index(vim.fn.argv(), vim.fn.expand("%")),
    file = vim.fn.expand("%"),
  }
end

local function ensure_valid_navigation(info)
  if vim.bo.buftype ~= "" then return false end

  if info.index == -1 and info.count > 0 then
    vim.cmd("first")
    return false
  end

  return info.count > 1
end

function M.next()
  local info = M.info()

  if not ensure_valid_navigation(info) then return end

  if info.index + 1 >= info.count then
    vim.cmd("first")
    return
  end

  vim.cmd("next")
end

function M.prev()
  local info = M.info()

  if not ensure_valid_navigation(info) then return end

  if info.index - 1 < 0 then
    vim.cmd("last")
    return
  end

  vim.cmd("previous")
end

function M.toggle()
  local info = M.info()

  if vim.bo.buftype ~= "" then
    vim.notify("Cannot add '" .. vim.bo.buftype .. "' buffer to the arglist", vim.log.levels.WARN)
    return
  end

  if info.index ~= -1 then
    vim.cmd("argdelete " .. info.file .. " | redrawstatus")
    return
  end

  vim.cmd("argadd | silent! next | redrawstatus")
end

return M
