local lualine = require "lualine"
local lualine_mode = require("lualine.utils.mode").get_mode
local noice_mode = require("noice").api.statusline.mode.get

local mode = function()
  local mode = noice_mode()

  if mode then
    return mode
  else
    return lualine_mode()
  end
end

lualine.setup {
  options = {
    theme = "catppuccin",
    globalstatus = true,
    section_separators = { left = "", right = "" },
  },

  sections = {
    lualine_a = { mode },
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

  winbar = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },

  inactive_winbar = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
}
