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
  },
  preview_window = false,
  title = true,
}
