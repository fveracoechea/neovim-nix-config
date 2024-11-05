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
    lualine_a = {
      -- "mode",
      mode,
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
