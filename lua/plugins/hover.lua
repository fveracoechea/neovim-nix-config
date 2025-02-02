require("hover").setup {
  init = function()
    require "hover.providers.lsp"
    require "hover.providers.diagnostic"
  end,
  preview_opts = {
    border = "rounded",
  },
  preview_window = false,
  title = true,
}
