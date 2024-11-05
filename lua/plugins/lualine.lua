local lualine = require "lualine"

lualine.setup {
  options = {
    theme = "catppuccin",
    globalstatus = true,
    section_separators = { left = "", right = "" },
  },
  sections = {
    lualine_a = {
      -- "mode",
      require("noice").api.statusline.mode.get,
    },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = { "filename" },
    lualine_x = {
      "lsp_progress",
      "fileformat",
      "filetype",
    },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
}
