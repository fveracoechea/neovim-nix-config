require("tailwind-tools").setup {
  server = {
    override = false, -- do not set lsp server
  },
  conceal = {
    enabled = true, -- can be toggled by commands
    min_length = 20, -- only conceal classes exceeding the provided length
  },
}
