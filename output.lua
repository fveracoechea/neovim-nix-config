require "options"
require "keymaps"
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
        return item.kind ~= 1 or base:match "^%s*%-%-" or base:match "^%s*//" or base:match "^%s*#"
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
  elseif MiniSnippets and MiniSnippets.can_jump "next" then
    MiniSnippets.jump "next"
    return ""
  else
    return "<Tab>"
  end
end, { desc = "Next completion, expand snippet, or Tab", expr = true })

map("i", "<S-Tab>", function()
  if vim.fn.pumvisible() == 1 then
    return "<C-p>"
  elseif MiniSnippets and MiniSnippets.can_jump "prev" then
    MiniSnippets.jump "prev"
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

local snacks = require "snacks"

snacks.setup {
  -- Integrated keymap setup using your existing shortcuts
  -- stylua: ignore
  keys = {
    -- Dashboard 
    { "<leader>;", function() Snacks.dashboard() end, desc = "Dashboard" },
    -- File and text finding (replacing telescope keymaps)
    { "<leader>ff", function() Snacks.picker.files() end, desc = "Find files in cwd" },
    { "<leader>fr", function() Snacks.picker.recent() end, desc = "Find recent files" },
    { "<leader>fs", function() Snacks.picker.grep() end, desc = "Find string in cwd" },
    { "<leader>fc", function() Snacks.picker.grep_buffers() end, desc = "Find in current buffer" },
    { "<leader>fw", function() Snacks.picker.grep_word() end, desc = "Find string under cursor in Workspace" },
    { "<leader>b", function() Snacks.picker.buffers() end, desc = "Find open buffers" },
    { "<leader>fa", function() Snacks.picker.files({ hidden = true, no_ignore = true }) end, desc = "Find all files" },
    -- LSP pickers (replacing telescope LSP integrations)  
    { "<leader>lr", function() Snacks.picker.lsp_references() end, desc = "References" },
    { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Definition" },
    { "<leader>li", function() Snacks.picker.lsp_implementations() end, desc = "Implementation" },
    { "<leader>lt", function() Snacks.picker.lsp_type_definitions() end, desc = "Type definition" },
    { "<leader>d", function() Snacks.picker.diagnostics() end, desc = "Show buffer diagnostics" },
    { "<leader>D", function() Snacks.picker.diagnostics_buffer() end, desc = "Show buffer diagnostics (all buffers)" },
    -- Buffer management 
    { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
    { "<leader>bo", function() Snacks.bufdelete.other() end, desc = "Delete Other Buffers" },
    -- Git integration
    { "<leader>gb", function() Snacks.git.blame_line() end, desc = "Git Blame Line" },
    { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse" },
    { "<leader>gf", function() Snacks.lazygit.log_file() end, desc = "Lazygit Current File History" },
    { "<leader>lg", function() Snacks.lazygit() end, desc = "Open Lazygit" }, -- Keep your existing shortcut
    { "<leader>gl", function() Snacks.lazygit.log() end, desc = "Lazygit Log (cwd)" },
    -- Notifications 
    { "<leader>n", function() Snacks.notifier.show_history() end, desc = "Notification History" },
    { "<leader>nd", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" }, -- Keep your existing shortcut
    -- LSP rename
    { "<leader>rn", function() Snacks.rename() end, desc = "LSP Rename" },
    -- Terminal (using standard terminal shortcuts)
    { "<c-/>", function() Snacks.terminal() end, desc = "Toggle Terminal" },
    { "<c-_>", function() Snacks.terminal() end, desc = "Toggle Terminal (which-key workaround)" },
    { "<c-/>", "<cmd>close<cr>", desc = "Hide Terminal", mode = "t" },
    { "<c-_>", "<cmd>close<cr>", desc = "Hide Terminal (which-key workaround)", mode = "t" },
    -- Word references (replacing todo-comments navigation)
    { "]]", function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference" },
    { "[[", function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference" },
    -- Zen mode
    { "<leader>z", function() Snacks.zen() end, desc = "Toggle Zen Mode" },
    { "<leader>Z", function() Snacks.zen.zoom() end, desc = "Toggle Zoom" },
    -- Scratch buffer
    { "<leader>.", function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
    { "<leader>S", function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
    -- Toggle utilities 
    { "<leader>ul", function() Snacks.toggle.line_number() end, desc = "Toggle Line Numbers" },
    { "<leader>uL", function() Snacks.toggle.option("relativenumber", { name = "Relative Numbers" }) end, desc = "Toggle Relative Numbers" },
    { "<leader>uw", function() Snacks.toggle.option("wrap", { name = "Wrap" }) end, desc = "Toggle Line Wrap" },
    { "<leader>us", function() Snacks.toggle.option("spell", { name = "Spelling" }) end, desc = "Toggle Spelling" },
  },

  -- Enable animations for various UI elements
  animate = {
    enabled = true,
    duration = 150,
  },

  -- Big file optimizations
  bigfile = {
    enabled = true,
    size = 1.5 * 1024 * 1024, -- 1.5MB
    -- Disable features that can slow down big files
    setup = function()
      vim.opt_local.spell = false
      vim.opt_local.swapfile = false
      vim.opt_local.undofile = false
      vim.opt_local.breakindent = false
      vim.opt_local.colorcolumn = ""
      vim.opt_local.statuscolumn = ""
      vim.opt_local.signcolumn = "no"
      vim.opt_local.foldcolumn = "0"
      vim.opt_local.winbar = ""
    end,
  },

  -- Buffer deletion without disrupting layout
  bufdelete = { enabled = true },

  -- Dashboard (replaces alpha.nvim)
  dashboard = {
    enabled = true,
    sections = {
      { section = "header" },
      { section = "keys", gap = 1, padding = 1 },
      { section = "recent_files", gap = 1, cwd = true, limit = 5, padding = 1 },
    },
    preset = {
      keys = {
        { icon = " ", key = "f", desc = "Find File", action = ":Snacks picker files" },
        { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
        { icon = " ", key = "r", desc = "Recent Files", action = ":Snacks picker recent" },
        { icon = " ", key = "g", desc = "Find Text", action = ":Snacks picker grep" },
        { icon = " ", key = "q", desc = "Quit", action = ":qa" },
      },
      header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
    },
  },

  -- Debug utilities
  debug = { enabled = true },

  -- Git utilities and browser integration
  git = { enabled = true },
  gitbrowse = { enabled = true },

  -- Indent guides (replaces indent-blankline.nvim)
  indent = {
    enabled = true,
    char = "┊",
    blank = " ",
    priority = 200,
    only_scope = false,
    only_current = false,
  },

  -- Better vim.ui.input
  input = {
    enabled = true,
    icon = " ",
    icon_hl = "SnacksInputIcon",
    icon_pos = "left",
  },

  -- LazyGit integration (replaces lazygit.nvim)
  lazygit = {
    enabled = true,
    configure = true,
    theme = {
      activeBorderColor = { fg = "SpecialChar", bold = true },
      inactiveBorderColor = { fg = "FloatBorder" },
      searchingActiveBorderColor = { fg = "MatchParen", bold = true },
    },
  },

  -- Notifications (replaces nvim-notify)
  notifier = {
    enabled = true,
    timeout = 3000,
    width = { min = 40, max = 0.4 },
    height = { min = 1, max = 0.6 },
    margin = { top = 0, right = 1, bottom = 0 },
    padding = true,
    sort = { "level", "added" },
    level = vim.log.levels.TRACE,
    icons = {
      error = " ",
      warn = " ",
      info = " ",
      debug = " ",
      trace = " ",
    },
    style = "compact",
    top_down = true,
    date_format = "%R",
    more_format = " ↓ %d lines ",
    refresh = 50,
  },

  -- Quick file rendering for fast startup
  quickfile = { enabled = true },

  -- Picker configuration (replaces telescope.nvim)
  picker = {
    enabled = true,
    -- Match your telescope prompt configuration
    prompt = " ",
    -- Configure picker behavior similar to your telescope setup
    sort = { "score", "created" },
    layout = {
      position = "top",
      preview_width = 0.6,
    },
    -- Smart path display like telescope
    sources = {
      files = {
        follow = true,
      },
      buffers = {
        sort_lastused = true,
        ignore_current_buffer = true,
      },
      grep = {
        case_mode = "smart_case",
      },
      diagnostics = {
        severity_limit = vim.diagnostic.severity.HINT,
      },
    },
    -- Configure window layout to match your telescope ivy theme for some pickers
    win = {
      input = {
        keys = {
          ["<C-k>"] = "move_up",
          ["<C-j>"] = "move_down",
          ["<C-h>"] = "help",
          ["<ESC>"] = { "close", mode = { "n", "i" } },
        },
      },
      list = {
        keys = {
          ["<C-k>"] = "move_up",
          ["<C-j>"] = "move_down",
          ["<C-x>"] = "delete_buffer", -- Match your telescope buffer delete key
        },
      },
    },
    -- Match your telescope behavior for different sources
    config = {
      buffers = {
        layout = {
          height = 0.55,
          position = "center",
        },
      },
      diagnostics = {
        layout = {
          height = 0.55,
          preview = false,
        },
      },
      lsp_references = {
        layout = {
          height = 0.55,
          position = "center",
        },
      },
      lsp_definitions = {
        layout = {
          height = 0.55,
          position = "center",
        },
      },
      lsp_implementations = {
        layout = {
          height = 0.55,
          position = "center",
        },
      },
    },
  },

  -- LSP rename with plugin integration
  rename = { enabled = true },

  -- Scope detection and navigation
  scope = {
    enabled = true,
    keys = {
      textobject = {
        ii = {
          min_size = 2,
          edge = false,
          cursor = true,
          treesitter = { blocks = { enabled = false } },
        },
      },
    },
  },

  -- Smooth scrolling (replaces neoscroll.nvim)
  scroll = {
    enabled = true,
    animate = {
      duration = { step = 15, total = 100 },
      easing = "linear",
    },
    spamming = 10,
    -- Disable in certain filetypes
    filter = function(buf)
      return vim.bo[buf].buftype ~= "terminal"
    end,
  },

  -- Status column
  statuscolumn = {
    enabled = true,
    left = { "mark", "sign" },
    right = { "fold", "git" },
    folds = {
      open = false,
      git_hl = false,
    },
    git = {
      patterns = { "GitSigns", "MiniDiffSign" },
    },
    refresh = 50,
  },

  -- Terminal management
  terminal = {
    enabled = true,
    win = {
      style = "terminal",
    },
  },

  -- Toggle utilities
  toggle = { enabled = true },

  -- LSP word references (partial replacement for todo-comments.nvim)
  words = {
    enabled = true,
    debounce = 200,
    notify_jump = false,
    notify_end = true,
    foldopen = true,
    jumplist = true,
    modes = { "n", "i", "c" },
  },

  -- Zen mode
  zen = {
    enabled = true,
    toggles = {
      dim = true,
      git_signs = false,
      mini_diff_signs = false,
      diagnostics = false,
      inlay_hints = false,
    },
    show = {
      statusline = false,
      tabline = false,
    },
    win = {
      backdrop = 0.95,
      width = 0.8,
    },
    zoom = {
      toggles = {},
      show = {
        statusline = true,
        tabline = true,
      },
      win = {
        backdrop = false,
      },
    },
  },
}
require("yazi").setup {
  -- if you want to open yazi instead of netrw, see below for more info
  open_for_directories = false,
  floating_window_scaling_factor = 0.85,
  yazi_floating_window_winblend = 0,
  yazi_floating_window_border = "rounded",
}
require("catppuccin").setup {
  flavour = "mocha",
  transparent_background = true,
  float = {
    transparent = true,
    solid = true,
  },
  integrations = {
    -- Disabled telescope since we use snacks.picker
    telescope = {
      enabled = false,
    },
    which_key = true,
    lsp_trouble = true,
    nvim_surround = false, -- Disabled since we use mini.surround
    notify = false, -- Disabled since we use snacks.notifier
    noice = true,
    indent_blankline = {
      enabled = false, -- Disabled since we use snacks.indent
    },
    -- Add snacks integrations if available
    mini = true, -- For mini.nvim integration
  },
}

-- set colorscheme - setup must be called before loading
vim.cmd.colorscheme "catppuccin"
require("noice").setup {
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = false, -- do not use a classic bottom cmdline for search
    command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false, -- add a border to hover docs and signature help
  },
  -- Route notifications to snacks.notifier instead of noice's built-in notifier
  routes = {
    {
      filter = { event = "notify" },
      view = "notify_send", -- This will use vim.notify which snacks.notifier handles
    },
  },
}
require("copilot").setup {
  suggestion = {
    enabled = true,
    auto_trigger = true, -- Enable auto-trigger for better UX
    debounce = 75,
    keymap = {
      accept = "<M-l>", -- Alt+l to accept (doesn't conflict with Tab)
      accept_word = "<M-Right>", -- Alt+Right to accept word
      accept_line = "<M-Down>", -- Alt+Down to accept line
      next = "<M-]>", -- Alt+] for next suggestion
      prev = "<M-[>", -- Alt+[ for previous suggestion
      dismiss = "<C-]>", -- Ctrl+] to dismiss
    },
  },
  panel = {
    enabled = true, -- Enable panel for manual browsing
    auto_refresh = false, -- Don't auto-refresh to avoid conflicts
    keymap = {
      jump_prev = "[[",
      jump_next = "]]",
      accept = "<CR>",
      refresh = "gr",
      open = "<M-CR>", -- Alt+Enter to open panel
    },
  },
  -- Disable copilot for certain filetypes to avoid conflicts
  filetypes = {
    yaml = false,
    markdown = false,
    help = false,
    gitcommit = false,
    gitrebase = false,
    hgcommit = false,
    svn = false,
    cvs = false,
    ["."] = false,
  },
}
require("lsp-file-operations").setup()

local x = vim.diagnostic.severity

-- Sets global diagnostic config
vim.diagnostic.config {
  virtual_text = { prefix = "" },
  -- Change the Diagnostic symbols in the sign column (gutter)
  signs = { text = { [x.ERROR] = "󰅙 ", [x.WARN] = " ", [x.INFO] = " ", [x.HINT] = "󰠠 " } },
  underline = true,
  float = { border = "single" },
}

require "lsp-servers"
require("hover").setup {
  init = function()
    require "hover.providers.lsp"
    require "hover.providers.diagnostic"
  end,
  preview_opts = {
    border = "rounded",
  },
  preview_window = false,
  title = true,
}
---@type TailwindTools.Option
local tailwind_config = {
  server = {
    override = false,
  },
}

require("tailwind-tools").setup(tailwind_config)
local conform = require "conform"

local js_formatters = { "prettier", "deno_fmt", stop_after_first = true }

conform.setup {
  formatters = {
    deno_fmt = {
      -- When cwd is not found, don't run the formatter (default false)
      require_cwd = true,
    },
    prettier = {
      -- When cwd is not found, don't run the formatter (default false)
      require_cwd = true,
    },
  },
  formatters_by_ft = {
    javascript = js_formatters,
    typescript = js_formatters,
    javascriptreact = js_formatters,
    typescriptreact = js_formatters,
    css = js_formatters,
    html = js_formatters,
    json = js_formatters,
    jsonc = js_formatters,
    yaml = js_formatters,
    markdown = js_formatters,
    svelte = { "prettier" },
    graphql = { "prettier" },
    liquid = { "prettier" },
    lua = { "stylua" },
    python = { "isort", "black" },
    nix = { "alejandra" },
  },
  format_on_save = {
    lsp_format = "fallback",
    timeout_ms = 1000,
  },
}
local lint = require "lint"

lint.linters_by_ft = {
  python = { "pylint" },
}

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  group = lint_augroup,
  callback = function()
    lint.try_lint()
  end,
})

vim.keymap.set("n", "<leader>ll", function()
  lint.try_lint()
end, { desc = "Trigger linting for current file" })
local null_ls = require "null-ls"

null_ls.setup {
  sources = {
    null_ls.builtins.diagnostics.codespell,

    null_ls.builtins.code_actions.proselint,

    null_ls.builtins.code_actions.refactoring,
  },
}
require("refactoring").setup {
  show_success_message = true,
}

-- Refactoring keymaps (updated to work without telescope)
local refactoring = require "refactoring"

-- Refactor using snacks.picker instead of telescope
vim.keymap.set({ "n", "x" }, "<leader>rr", function()
  -- Use vim.ui.select (which is handled by snacks.picker) for refactor options
  local refactors = {
    "Extract Function",
    "Extract Function To File",
    "Extract Variable",
    "Inline Variable",
    "Extract Block",
    "Extract Block To File",
  }

  vim.ui.select(refactors, {
    prompt = "Select refactor:",
  }, function(choice)
    if not choice then
      return
    end

    if choice == "Extract Function" then
      refactoring.refactor "Extract Function"
    elseif choice == "Extract Function To File" then
      refactoring.refactor "Extract Function To File"
    elseif choice == "Extract Variable" then
      refactoring.refactor "Extract Variable"
    elseif choice == "Inline Variable" then
      refactoring.refactor "Inline Variable"
    elseif choice == "Extract Block" then
      refactoring.refactor "Extract Block"
    elseif choice == "Extract Block To File" then
      refactoring.refactor "Extract Block To File"
    end
  end)
end, { desc = "Choose a refactor option" })
require("gitsigns").setup()
local codesnap = require "codesnap"

codesnap.setup {
  save_path = "~/Pictures/Codesnap",
  has_breadcrumbs = true,
  bg_x_padding = 40,
  bg_y_padding = 28,
  bg_theme = "peach",
  watermark = "",
}
local treesitter = require "nvim-treesitter.configs"

treesitter.setup {
  -- parsers are installed by nix
  ensure_installed = {},
  auto_install = false,
  -- enable syntax highlighting
  highlight = { enable = true },
  -- enable indentation
  indent = { enable = true },
  -- enable autotagging (w/ nvim-ts-autotag plugin)
  autotag = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-space>",
      node_incremental = "<C-space>",
      scope_incremental = false,
      node_decremental = "<bs>",
    },
  },
}
