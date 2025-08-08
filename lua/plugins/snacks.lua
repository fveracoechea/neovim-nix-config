local snacks = require "snacks"

snacks.setup {
  animate = {
    enabled = true,
    duration = 250,
  },

  bigfile = {
    enabled = true,
    size = 1.5 * 1024 * 1024,
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

  bufdelete = { enabled = true },

  dashboard = {
    enabled = true,
    sections = {
      { section = "header" },
      { section = "keys", gap = 1, padding = 1 },
      { section = "recent_files", gap = 1, cwd = true, limit = 5, padding = 1 },
    },
    preset = {
      keys = {
        { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.picker.files()" },
        { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
        { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.picker.recent()" },
        { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.picker.grep()" },
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

  debug = { enabled = true },
  git = { enabled = true },
  gitbrowse = { enabled = true },

  indent = {
    enabled = true,
    char = "┊",
    blank = " ",
    priority = 200,
    only_scope = false,
    only_current = false,
  },

  input = {
    enabled = true,
    icon = " ",
    icon_hl = "SnacksInputIcon",
    icon_pos = "left",
  },

  lazygit = {
    enabled = true,
    configure = true,
    theme = {
      activeBorderColor = { fg = "SpecialChar", bold = true },
      inactiveBorderColor = { fg = "FloatBorder" },
      searchingActiveBorderColor = { fg = "MatchParen", bold = true },
    },
  },

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

  quickfile = { enabled = true },

  picker = {
    enabled = true,
    prompt = " ",
    win = {
      input = {
        keys = {
          ["<C-k>"] = "move_up",
          ["<C-j>"] = "move_down",
          ["<ESC>"] = { "close", mode = { "n", "i" } },
        },
      },
      list = {
        keys = {
          ["<C-k>"] = "move_up",
          ["<C-j>"] = "move_down",
        },
      },
    },
  },

  rename = { enabled = true },

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

  scroll = {
    enabled = true,
    animate = {
      duration = { step = 15, total = 250 },
      easing = "linear",
    },
    spamming = 10,
    filter = function(buf)
      return vim.bo[buf].buftype ~= "terminal"
    end,
  },

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

  terminal = {
    enabled = true,
    win = {
      style = "terminal",
    },
  },

  toggle = { enabled = true },

  words = {
    enabled = true,
    debounce = 200,
    notify_jump = false,
    notify_end = true,
    foldopen = true,
    jumplist = true,
    modes = { "n", "i", "c" },
  },

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

-- Note: Keymaps are now centralized in lua/keymaps.lua

