local lualine = require "lualine"

local colors = require "catppuccin.palettes.mocha"

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

  return " " .. count
end

lualine.setup {
  options = {
    theme = "catppuccin",
    globalstatus = true,
    section_separators = { left = "", right = "" },
    disabled_filetypes = { winbar = { "NvimTree", "alpha", "snacks_explorer" } },
  },

  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff" },
    lualine_c = { "lsp_status" },
    lualine_x = { "filesize", "encoding" },
    lualine_y = { "filetype" },
    lualine_z = { "location" },
  },

  winbar = {
    lualine_a = {
      get_buffer_count,
    },
    lualine_b = {
      {
        "filename",
        file_status = true,
        newfile_status = true,
        path = 1,
      },
      "diagnostics",
    },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },

  inactive_winbar = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {
      {
        "filename",
        file_status = true,
        newfile_status = true,
        path = 1,
        color = { fg = colors.subtext1 },
      },
    },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
}
