-- Mini.nvim configuration - consolidate multiple plugins into mini modules
-- Each module is independent and can be configured separately

-- Icons (replaces nvim-web-devicons)
require("mini.icons").setup {
  -- Use default icons from mini.icons
  style = "glyph", -- can be 'glyph' (default), 'ascii', or custom table
}

-- Autopairs (replaces nvim-autopairs)
require("mini.pairs").setup {
  -- In which modes mappings from this module will be created
  modes = { insert = true, command = false, terminal = false },

  -- Global mappings. Each right hand side should be a pair information, a
  -- table with at least these fields (see more in ':h MiniPairs.map'):
  -- - <action> - one of 'open', 'close', 'closeopen'.
  -- - <pair> - two character string for pair to be used.
  -- By default pair is not inserted after `\`, quotes are not recognized by
  -- `<CR>`, `'` does not insert pair after a letter.
  mappings = {
    ["("] = { action = "open", pair = "()", neigh_pattern = "[^\\]." },
    ["["] = { action = "open", pair = "[]", neigh_pattern = "[^\\]." },
    ["{"] = { action = "open", pair = "{}", neigh_pattern = "[^\\]." },

    [")"] = { action = "close", pair = "()", neigh_pattern = "[^\\]." },
    ["]"] = { action = "close", pair = "[]", neigh_pattern = "[^\\]." },
    ["}"] = { action = "close", pair = "{}", neigh_pattern = "[^\\]." },

    ['"'] = { action = "closeopen", pair = '""', neigh_pattern = "[^\\].", register = { cr = false } },
    ["'"] = { action = "closeopen", pair = "''", neigh_pattern = "[^%a\\].", register = { cr = false } },
    ["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^\\].", register = { cr = false } },
  },
}

-- Surround (replaces nvim-surround)
require("mini.surround").setup {
  -- Add custom surroundings to be used on top of builtin ones. For more
  -- information with examples, see `:h MiniSurround.config`.
  custom_surroundings = nil,

  -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
  highlight_duration = 500,

  -- Module mappings. Use `''` (empty string) to disable one.
  mappings = {
    add = "sa", -- Add surrounding in Normal and Visual modes
    delete = "sd", -- Delete surrounding
    find = "sf", -- Find surrounding (to the right)
    find_left = "sF", -- Find surrounding (to the left)
    highlight = "sh", -- Highlight surrounding
    replace = "sr", -- Replace surrounding
    update_n_lines = "sn", -- Update `MiniSurround.config.n_lines`

    suffix_last = "l", -- Suffix to search with "prev" method
    suffix_next = "n", -- Suffix to search with "next" method
  },

  -- Number of lines within which surrounding is searched
  n_lines = 20,

  -- Whether to respect selection type:
  -- - Place surroundings on separate lines in linewise mode.
  -- - Place surroundings on each line in blockwise mode.
  respect_selection_type = false,

  -- How to search for surrounding (first inside current line, then inside
  -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
  -- 'cover_or_nearest', 'next', 'prev', 'nearest'. For more details,
  -- see `:h MiniSurround.config`.
  search_method = "cover",

  -- Whether to disable showing non-error feedback
  silent = false,
}

-- Comment (replaces comment.nvim)
require("mini.comment").setup {
  -- Options which control module behavior
  options = {
    -- Function to compute custom 'commentstring' (optional)
    custom_commentstring = nil,

    -- Whether to ignore blank lines when commenting
    ignore_blank_line = false,

    -- Whether to recognize as comment only lines without indent
    start_of_line = false,

    -- Whether to force single space inner padding for comment parts
    pad_comment_parts = true,
  },

  -- Module mappings. Use `''` (empty string) to disable one.
  mappings = {
    -- Toggle comment (like `gcip` - comment inner paragraph) for both
    -- Normal and Visual modes
    comment = "gc",

    -- Toggle comment on current line
    comment_line = "gcc",

    -- Toggle comment on visual selection
    comment_visual = "gc",

    -- Define 'comment' textobject (like `dgc` - delete whole comment block)
    textobject = "gc",
  },
}

-- Sessions (replaces auto-session)
require("mini.sessions").setup {
  -- Whether to read default session if Neovim opened without file arguments
  autoread = false,

  -- Whether to write current session before quitting Neovim
  autowrite = true,

  -- Directory where global sessions are stored (use `''` to disable)
  directory = vim.fn.stdpath "data" .. "/sessions",

  -- File for local session (use `''` to disable)
  file = "",

  -- Whether to force possibly harmful actions (meaning depends on function)
  force = { read = false, write = true, delete = false },

  -- Hook functions for actions. Default `nil` means 'do nothing'.
  hooks = {
    -- Before successful action
    pre = { read = nil, write = nil, delete = nil },
    -- After successful action
    post = { read = nil, write = nil, delete = nil },
  },

  -- Whether to print session path after action
  verbose = { read = false, write = true, delete = true },
}

-- Statusline (replaces lualine.nvim)
require("mini.statusline").setup {
  -- Content of statusline as functions which return statusline string. See
  -- `:h MiniStatusline.section_*()` for all available functions.
  content = {
    -- Content for active window
    active = function()
      local check_macro_recording = function()
        if vim.fn.reg_recording() ~= "" then
          return "Recording @" .. vim.fn.reg_recording()
        else
          return ""
        end
      end

      local mode, mode_hl = MiniStatusline.section_mode { trunc_width = 120 }
      local git = MiniStatusline.section_git { trunc_width = 40 }
      local diff = MiniStatusline.section_diff { trunc_width = 75 }
      local diagnostics = MiniStatusline.section_diagnostics { trunc_width = 75 }
      local lsp = MiniStatusline.section_lsp { trunc_width = 75 }
      local filename = MiniStatusline.section_filename { trunc_width = 140 }
      local fileinfo = MiniStatusline.section_fileinfo { trunc_width = 120 }
      local location = MiniStatusline.section_location { trunc_width = 75 }
      local search = MiniStatusline.section_searchcount { trunc_width = 75 }
      local macro = check_macro_recording()

      return MiniStatusline.combine_groups {
        { hl = mode_hl, strings = { mode } },
        { hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics, lsp } },
        "%<", -- Mark general truncate point
        { hl = "MiniStatuslineFilename", strings = { filename } },
        "%=", -- End left alignment
        { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
        { hl = mode_hl, strings = { search, location, macro } },
      }
    end,

    -- Content for inactive window(s)
    inactive = function()
      local filename = MiniStatusline.section_filename { trunc_width = 140 }
      return MiniStatusline.combine_groups {
        { hl = "MiniStatuslineInactive", strings = { filename } },
      }
    end,
  },

  -- Whether to use icons (requires 'nvim-web-devicons')
  use_icons = vim.g.have_nerd_font or false,

  -- Whether to set Vim's settings for statusline (make it always shown with
  -- global statusline). It is recommended to keep this `true`.
  set_vim_settings = true,
}

-- Git diff (can replace gitsigns.nvim for basic functionality)
require("mini.diff").setup {
  -- Delays (in ms) defining how much to wait before updating diff
  delay = {
    -- How much to wait before update after typing in Insert mode
    text_change = 200,
  },

  -- Module mappings. Use `''` (empty string) to disable one.
  mappings = {
    -- Apply hunks inside a visual/operator region
    apply = "gh",

    -- Reset hunks inside a visual/operator region
    reset = "gH",

    -- Hunk range textobject to be used inside operator
    -- Works also in Visual mode if mapping differs from apply and reset
    textobject = "gh",

    -- Go to hunk range in corresponding direction
    goto_first = "[H",
    goto_prev = "[h",
    goto_next = "]h",
    goto_last = "]H",
  },

  -- Options for how hunks are visualized
  view = {
    -- Visualization style. Possible values are 'sign' and 'number'.
    style = "sign",

    -- Signs used for hunks with 'sign' view
    signs = {
      add = "▎",
      change = "▎",
      delete = "▎",
    },

    -- Priority of used visualization extmarks
    priority = 199,
  },

  -- Source for how reference text is computed/updated/etc
  -- Uses `git` executable for all actions (assuming file is version-controlled)
  source = nil,
}

-- Snippets (provides snippet functionality for completion)
require("mini.snippets").setup {
  -- Module mappings. Use `''` (empty string) to disable one.
  mappings = {
    -- Expand snippet at cursor position - disable since we handle it in Tab
    expand = "",
    -- Jump to next placeholder - disable since we handle it in Tab  
    jump_next = "",
    -- Jump to previous placeholder - disable since we handle it in S-Tab
    jump_prev = "",
    -- Stop jumping (clears all placeholder highlighting)
    stop = "<C-c>",
  },

  -- Options for snippet expansions
  snippets = {
    -- Use built-in snippets
    -- These provide common snippets for various languages
  },

  -- Generator functions (advanced usage)
  -- Can be used to create custom snippet sources
  gen_loader = {
    -- Load VSCode-style snippets from friendly-snippets equivalent
    -- Since we removed friendly-snippets, we'll rely on LSP snippets
  },
}

-- Completion (replaces nvim-cmp)
require("mini.completion").setup {
  -- Delay (debounce type, in ms) between certain Neovim event and action.
  -- This can be used to (virtually) disable certain automatic actions by
  -- setting very high delay time (like 10^7).
  delay = { completion = 100, info = 100, signature = 50 },

  -- Configuration for action windows:
  -- - `height` and `width` are maximum dimensions.
  -- - `border` defines border (as for `nvim_open_win()`).
  window = {
    info = { height = 25, width = 80, border = "none" },
    signature = { height = 25, width = 80, border = "none" },
  },

  -- Way of how module does LSP completion
  lsp_completion = {
    -- `source_func` should be one of 'completefunc' or 'omnifunc'.
    source_func = "completefunc",

    -- `auto_setup` should be boolean indicating if LSP completion is set up
    -- on every `BufEnter` event.
    auto_setup = true,

    -- `process_items` should be a function which takes LSP
    -- 'textDocument/completion' response items and word to complete.
    -- Its output should be a table of the same nature as input items.
    -- The most common use-cases are custom filtering and sorting.
    -- You can use default `process_items` as `MiniCompletion.default_process_items()`.
    process_items = function(items, base)
      -- Don't show 'Text' items from LSP when not in comment context
      local res = vim.tbl_filter(function(item)
        return item.kind ~= 1 or base:match("^%s*%-%-") or base:match("^%s*//") or base:match("^%s*#")
      end, items)
      return MiniCompletion.default_process_items(res, base)
    end,
  },

  -- Fallback action. It will always be run in Insert mode. To use Neovim's
  -- built-in completion (see `:h ins-completion`), supply its mapping as
  -- string. Example: to use 'whole lines' completion, supply '<C-x><C-l>'.
  fallback_action = function()
    -- First try to expand snippet, then fallback to completion
    if MiniSnippets and MiniSnippets.can_expand() then
      return MiniSnippets.expand()
    else
      return vim.api.nvim_replace_termcodes("<C-x><C-n>", true, false, true)
    end
  end,

  -- Module mappings. Use `''` (empty string) to disable one. Some of them
  -- might conflict with system mappings.
  mappings = {
    force_twostep = "<C-Space>", -- Force two-step completion
    force_fallback = "<A-Space>", -- Force fallback completion
  },

  -- Whether to set Vim's settings for better experience (modifies
  -- `shortmess` and `completeopt`)
  set_vim_settings = true,
}

-- Buffer removal (replaces bufdelete functionality, but snacks.bufdelete is better)
-- Keeping this commented since snacks.bufdelete is more feature-rich
-- require("mini.bufremove").setup()

-- File browser (alternative to yazi, but yazi is probably better for your workflow)
-- Keeping this commented since you already have yazi configured
-- require("mini.files").setup()

-- Set up keymaps that integrate with your existing workflow
local map = vim.keymap.set

-- Session management keymaps (replacing auto-session keymaps)
map("n", "<leader>wr", function()
  MiniSessions.read()
end, { desc = "Read session" })
map("n", "<leader>ws", function()
  MiniSessions.write()
end, { desc = "Write session" })
map("n", "<leader>wd", function()
  MiniSessions.delete()
end, { desc = "Delete session" })

-- Mini.diff keymaps (if replacing gitsigns)
map("n", "]h", function()
  require("mini.diff").goto_hunk "next"
end, { desc = "Next hunk" })
map("n", "[h", function()
  require("mini.diff").goto_hunk "prev"
end, { desc = "Prev hunk" })

-- Completion keymaps (replicating nvim-cmp experience)
-- These work in Insert mode to navigate completion menu
map("i", "<C-j>", function()
  if vim.fn.pumvisible() == 1 then
    return "<C-n>"
  else
    return "<C-j>"
  end
end, { desc = "Next completion item", expr = true })

map("i", "<C-k>", function()
  if vim.fn.pumvisible() == 1 then
    return "<C-p>"
  else
    return "<C-k>"
  end
end, { desc = "Previous completion item", expr = true })

map("i", "<C-e>", function()
  if vim.fn.pumvisible() == 1 then
    return "<C-e>"
  else
    return "<C-e>"
  end
end, { desc = "Close completion menu", expr = true })

-- Use Tab and Shift-Tab for completion navigation and snippet expansion
map("i", "<Tab>", function()
  -- First check if we're in a completion menu
  if vim.fn.pumvisible() == 1 then
    return "<C-n>"
  -- Then check if we can expand a snippet
  elseif MiniSnippets and MiniSnippets.can_expand() then
    MiniSnippets.expand()
    return ""
  -- Check if we can jump to next placeholder
  elseif MiniSnippets and MiniSnippets.can_jump("next") then
    MiniSnippets.jump("next")
    return ""
  else
    return "<Tab>"
  end
end, { desc = "Next completion, expand snippet, or Tab", expr = true })

map("i", "<S-Tab>", function()
  if vim.fn.pumvisible() == 1 then
    return "<C-p>"
  elseif MiniSnippets and MiniSnippets.can_jump("prev") then
    MiniSnippets.jump("prev")
    return ""
  else
    return "<S-Tab>"
  end
end, { desc = "Previous completion, jump prev, or Shift-Tab", expr = true })

-- The comment keymaps are automatically set up by mini.comment
-- The surround keymaps are automatically set up by mini.surround
-- The pairs functionality works automatically
-- The completion keymaps work with <C-Space> for force completion
-- Snippet workflow: Tab expands/jumps next, S-Tab jumps prev, C-c stops
-- Copilot workflow: Alt+l accept, Alt+Right accept word, Alt+Enter panel

