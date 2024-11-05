local lualine = require "lualine"

lualine.setup {
  options = {
    theme = "catppuccin",
    -- component_separators = "",
    globalstatus = true,
    section_separators = { left = "", right = "" },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = { "filename" },
    lualine_x = {
      "lsp_progress",
      "fileformat",
      "filetype",
      {
        require("noice").api.statusline.mode.get,
        cond = require("noice").api.statusline.mode.has,
        color = { fg = "#ff9e64" },
      },
    },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
}
