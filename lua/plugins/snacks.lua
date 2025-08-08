local snacks = require "snacks"

snacks.setup {
  -- Integrated keymap setup using your existing shortcuts
  -- stylua: ignore
  keys = {
    -- Dashboard 
    { "<leader>;", function() snacks.dashboard() end, desc = "Dashboard" },
    -- File and text finding (replacing telescope keymaps)
    { "<leader>ff", function() snacks.picker.files() end, desc = "Find files in cwd" },
    { "<leader>fr", function() snacks.picker.recent() end, desc = "Find recent files" },
    { "<leader>fs", function() snacks.picker.grep() end, desc = "Find string in cwd" },
    { "<leader>fc", function() snacks.picker.grep_buffers() end, desc = "Find in current buffer" },
    { "<leader>fw", function() snacks.picker.grep_word() end, desc = "Find string under cursor in Workspace" },
    { "<leader>b", function() snacks.picker.buffers() end, desc = "Find open buffers" },
    { "<leader>fa", function() snacks.picker.files({ hidden = true, no_ignore = true }) end, desc = "Find all files" },
    -- LSP pickers
    { "<leader>lr", function() snacks.picker.lsp_references() end, desc = "References" },
    { "gd", function() snacks.picker.lsp_definitions() end, desc = "Definition" },
    { "<leader>li", function() snacks.picker.lsp_implementations() end, desc = "Implementation" },
    { "<leader>lt", function() snacks.picker.lsp_type_definitions() end, desc = "Type definition" },
    { "<leader>d", function() snacks.picker.diagnostics() end, desc = "Show buffer diagnostics" },
    { "<leader>D", function() snacks.picker.diagnostics_buffer() end, desc = "Show buffer diagnostics (all buffers)" },
    -- Buffer management 
    { "<leader>bd", function() snacks.bufdelete() end, desc = "Delete Buffer" },
    { "<leader>bo", function() snacks.bufdelete.other() end, desc = "Delete Other Buffers" },
    -- Git integration
    { "<leader>gb", function() snacks.git.blame_line() end, desc = "Git Blame Line" },
    { "<leader>gB", function() snacks.gitbrowse() end, desc = "Git Browse" },
    { "<leader>gf", function() snacks.lazygit.log_file() end, desc = "Lazygit Current File History" },
    { "<leader>lg", function() snacks.lazygit() end, desc = "Open Lazygit" },
    { "<leader>gl", function() snacks.lazygit.log() end, desc = "Lazygit Log (cwd)" },
    -- Notifications 
    { "<leader>n", function() snacks.notifier.show_history() end, desc = "Notification History" },
    { "<leader>nd", function() snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
    -- LSP rename
    { "<leader>rn", function() snacks.rename() end, desc = "LSP Rename" },
    -- Terminal
    { "<c-/>", function() snacks.terminal() end, desc = "Toggle Terminal" },
    { "<c-_>", function() snacks.terminal() end, desc = "Toggle Terminal (which-key workaround)" },
    { "<c-/>", "<cmd>close<cr>", desc = "Hide Terminal", mode = "t" },
    { "<c-_>", "<cmd>close<cr>", desc = "Hide Terminal (which-key workaround)", mode = "t" },
    -- Word references
    { "]]", function() snacks.words.jump(vim.v.count1) end, desc = "Next Reference" },
    { "[[", function() snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference" },
    -- Zen mode
    { "<leader>z", function() snacks.zen() end, desc = "Toggle Zen Mode" },
    { "<leader>Z", function() snacks.zen.zoom() end, desc = "Toggle Zoom" },
    -- Scratch buffer
    { "<leader>.", function() snacks.scratch() end, desc = "Toggle Scratch Buffer" },
    { "<leader>S", function() snacks.scratch.select() end, desc = "Select Scratch Buffer" },
    -- Toggle utilities 
    { "<leader>ul", function() snacks.toggle.line_number() end, desc = "Toggle Line Numbers" },
    { "<leader>uL", function() snacks.toggle.option("relativenumber", { name = "Relative Numbers" }) end, desc = "Toggle Relative Numbers" },
    { "<leader>uw", function() snacks.toggle.option("wrap", { name = "Wrap" }) end, desc = "Toggle Line Wrap" },
    { "<leader>us", function() snacks.toggle.option("spell", { name = "Spelling" }) end, desc = "Toggle Spelling" },
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
