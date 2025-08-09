-- Mini.nvim configuration - consolidate multiple plugins into mini modules
-- Each module is independent and can be configured separately

require("mini.sessions").setup {
  file = "",
  autowrite = true,
  directory = "~/.config/nvim",
}

require("mini.pairs").setup {}
require("mini.surround").setup {}
require("mini.comment").setup {}
require("mini.diff").setup {}

local MiniStatusline = require "mini.statusline"

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

local get_mode = function()
  local noice_mode = noice_mode()
  local mode, mode_hl = MiniStatusline.section_mode { trunc_width = 40 }

  if noice_mode then
    return noice_mode, mode_hl
  else
    return mode, mode_hl
  end
end

MiniStatusline.setup {
  active = function()
    local mode, mode_hl = get_mode()
    local git = MiniStatusline.section_git { trunc_width = 40 }
    local diff = MiniStatusline.section_diff { trunc_width = 75 }
    local diagnostics = MiniStatusline.section_diagnostics { trunc_width = 75 }
    local lsp = MiniStatusline.section_lsp { trunc_width = 75 }
    local filename = "%f%m%r"
    local fileinfo = MiniStatusline.section_fileinfo { trunc_width = 120 }
    local location = MiniStatusline.section_location { trunc_width = 75 }
    local search = MiniStatusline.section_searchcount { trunc_width = 75 }

    return MiniStatusline.combine_groups {
      { hl = mode_hl, strings = { mode } },
      { hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics, lsp } },
      "%<", -- Mark general truncate point
      { hl = "MiniStatuslineFilename", strings = { filename } },
      "%=", -- End left alignment
      { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
      { hl = mode_hl, strings = { search, location } },
    }
  end,
}

local gen_loader = require("mini.snippets").gen_loader

require("mini.snippets").setup {
  mappings = {
    expand = "", -- disable default <C-j> to avoid conflict with cmp navigation
  },
  snippets = {
    --   Load custom file with global snippets first (adjust for Windows)
    gen_loader.from_file "~/.config/nvim/snippets/global.json",
    -- Load snippets based on current language by reading files from
    -- "snippets/" subdirectories from 'runtimepath' directories.
    gen_loader.from_lang(),
  },
}

require("mini.icons").setup {
  style = "glyph",
}

MiniIcons.tweak_lsp_kind()
