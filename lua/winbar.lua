local colors = require "catppuccin.palettes.mocha"

vim.cmd(string.format([[highlight WinBarPath guifg=%s]], colors.rosewater))
vim.cmd(string.format([[highlight WinBarModified guifg=%s]], colors.green))
vim.cmd(string.format([[highlight WinBarBuffers guifg=%s]], colors.peach))
vim.cmd(string.format([[highlight WinBarIndicator guifg=%s]], colors.blue))

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
  local buffer_count = get_buffer_count()
  vim.opt.winbar = ""
    .. "%#WinBarBuffers#("
    .. buffer_count
    .. ") "
    .. "%#WinBarPath#"
    .. "%f "
    .. "%#WinBarModified#%m "
    .. "%*%=%#WinBar2#"
end

-- Autocmd to update the winbar on BufEnter and WinEnter events
vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
  callback = update_winbar,
})
