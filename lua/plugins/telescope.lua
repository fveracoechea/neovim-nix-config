local telescope = require "telescope"
local actions = require "telescope.actions"
-- local transform_mod = require("telescope.actions.mt").transform_mod

-- local trouble = require "trouble"
-- local trouble_telescope = require "trouble.sources.telescope"

-- or create your custom action
-- local custom_actions = transform_mod {
--   open_trouble_qflist = function()
--     trouble.toggle "quickfix"
--   end,
-- }

telescope.setup {
  defaults = {
    path_display = { "smart" },
    prompt_prefix = "   ",
    sorting_strategy = "ascending",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.60,
      },
      width = 0.90,
      height = 0.90,
    },
    mappings = {
      i = {
        -- move to prev result
        ["<C-k>"] = actions.move_selection_previous,
        -- move to next result
        ["<C-j>"] = actions.move_selection_next,
        -- ["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
        -- ["<C-t>"] = trouble_telescope.open,
        ["<C-h>"] = "which_key",
      },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
    },
  },
  pickers = {
    diagnostics = {
      previewer = false,
      theme = "ivy",
      layout_config = {
        height = 0.50,
      },
    },
    buffers = {
      theme = "ivy",
      layout_config = {
        height = 0.50,
      },
      mappings = {
        i = {
          ["<C-x>"] = actions.delete_buffer + actions.move_to_top,
          -- If you'd prefer Telescope not to enter a normal mode when hitting escape and instead exiting.
          ["<ESC>"] = actions.close,
        },
      },
    },
  },
}

telescope.load_extension "fzf"
