require("hover").setup {
  init = function()
    require "hover.providers.lsp"
    require "hover.providers.diagnostic"
  end,
  preview_opts = {
    border = "rounded",
    max_width = 80,
    max_height = 25,
    min_height = 1,
    wrap = true,
  },
  preview_window = false,
  title = true,
}

-- Global workaround for GraphQL LSP height calculation issues
local original_open_win = vim.api.nvim_open_win

vim.api.nvim_open_win = function(buffer, enter, config)
  if config and config.height then
    -- Ensure height is a valid positive integer
    if type(config.height) ~= "number" or config.height <= 0 or config.height ~= config.height then -- NaN check
      config.height = 1
    end
    -- Clamp height to reasonable bounds
    config.height = math.min(math.max(config.height, 1), 25)
  end

  if config and config.width then
    -- Ensure width is a valid positive integer
    if type(config.width) ~= "number" or config.width <= 0 or config.width ~= config.width then -- NaN check
      config.width = 80
    end
    -- Clamp width to reasonable bounds
    config.width = math.min(math.max(config.width, 10), 120)
  end

  return original_open_win(buffer, enter, config)
end

-- Disable hover.nvim for GraphQL files and use built-in LSP hover instead
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "graphql", "gql" },
  callback = function()
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = true, desc = "LSP Hover" })
  end,
})
