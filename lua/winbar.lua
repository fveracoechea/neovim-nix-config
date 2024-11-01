local colors = require "catppuccin.palettes.mocha"

vim.cmd(string.format([[highlight WinBar1 guifg=%s]], colors.rosewater))

vim.cmd(string.format([[highlight WinBarM guifg=%s]], colors.green))

vim.cmd(string.format([[highlight WinBar2 guifg=%s]], colors.peach))

local winbar_filetype_exclude = {
  [""] = true,
  ["NvimTree"] = true,
  ["Outline"] = true,
  ["Trouble"] = true,
  ["alpha"] = true,
  ["dashboard"] = true,
  ["neo-tree"] = true,
}

--
-- local is_current = function()
--   local winid = vim.g.actual_curwin
--   if isempty(winid) then
--     return false
--   else
--     return winid == tostring(vim.api.nvim_get_current_win())
--   end
-- end

-- Function to get the full path and replace the home directory with ~
local function get_winbar_path()
  local full_path = vim.fn.expand "%:p"
  return full_path:gsub(vim.fn.expand "$HOME", "~")
end

-- Function to get the number of open buffers using the :ls command
local function get_buffer_count()
  local buffers = vim.fn.execute "ls"
  local count = 0
  -- Match only lines that represent buffers, typically starting with a number followed by a space
  for line in string.gmatch(buffers, "[^\r\n]+") do
    if string.match(line, "^%s*%d+") then
      count = count + 1
    end
  end
  return count
end

-- Function to update the winbar
local function update_winbar()
  if winbar_filetype_exclude[vim.bo.filetype] then
    return
  end

  local home_replaced = get_winbar_path()
  local buffer_count = get_buffer_count()
  vim.opt.winbar = "%#WinBar2#(" .. buffer_count .. ") " .. "%#WinBarM#%m " .. "%#WinBar1#" .. "%f" .. "%*%=%#WinBar2#"
end

-- Autocmd to update the winbar on BufEnter and WinEnter events
vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
  callback = update_winbar,
})
