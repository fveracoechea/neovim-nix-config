local otter = require "otter"

otter.setup()

vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
  callback = function()
    otter.activate()
  end,
})
