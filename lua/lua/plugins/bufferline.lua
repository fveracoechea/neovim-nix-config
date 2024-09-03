local bufferline = require "bufferline"
local catppucin_bufferline = require "catppuccin.groups.integrations.bufferline"

bufferline.setup {
  options = {
    mode = "buffers",
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        highlight = "Directory",
        separator = true,
      },
    },
    highlights = catppucin_bufferline.get(),
  },
}
