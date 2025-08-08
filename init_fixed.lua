require "options";
require "keymaps";

-- Mini.nvim configuration - consolidate multiple plugins into mini modules
-- Each module is independent and can be configured separately

-- Icons (replaces nvim-web-devicons)
require("mini.icons").setup {
  style = "glyph",
}

-- Autopairs (replaces nvim-autopairs)
require("mini.pairs").setup {
  modes = { insert = true, command = false, terminal = false },
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
  custom_surroundings = nil,
  highlight_duration = 500,
  mappings = {
    add = "sa",
    delete = "sd", 
    find = "sf",
    find_left = "sF",
    highlight = "sh",
    replace = "sr",
    update_n_lines = "sn",
    suffix_last = "l",
    suffix_next = "n",
  },
  n_lines = 20,
  respect_selection_type = false,
  search_method = "cover",
  silent = false,
}

-- Comment (replaces comment.nvim)
require("mini.comment").setup {
  options = {
    custom_commentstring = nil,
    ignore_blank_line = false,
    start_of_line = false,
    pad_comment_parts = true,
  },
  mappings = {
    comment = "gc",
    comment_line = "gcc",
    comment_visual = "gc",
    textobject = "gc",
  },
}

-- Sessions (replaces auto-session)
require("mini.sessions").setup {
  autoread = false,
  autowrite = true,
  directory = vim.fn.stdpath "data" .. "/sessions",
  file = "",
  force = { read = false, write = true, delete = false },
  hooks = {
    pre = { read = nil, write = nil, delete = nil },
    post = { read = nil, write = nil, delete = nil },
  },
  verbose = { read = false, write = true, delete = true },
}

-- Statusline (replaces lualine.nvim)
require("mini.statusline").setup {
  content = {
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
        "%<",
        { hl = "MiniStatuslineFilename", strings = { filename } },
        "%=",
        { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
        { hl = mode_hl, strings = { search, location, macro } },
      }
    end,
    inactive = function()
      local filename = MiniStatusline.section_filename { trunc_width = 140 }
      return MiniStatusline.combine_groups {
        { hl = "MiniStatuslineInactive", strings = { filename } },
      }
    end,
  },
  use_icons = vim.g.have_nerd_font or false,
  set_vim_settings = true,
}

-- Git diff (can replace gitsigns.nvim for basic functionality)
require("mini.diff").setup {
  delay = {
    text_change = 200,
  },
  mappings = {
    apply = "gh",
    reset = "gH",
    textobject = "gh",
    goto_first = "[H",
    goto_prev = "[h",
    goto_next = "]h",
    goto_last = "]H",
  },
  view = {
    style = "sign",
    signs = {
      add = "▎",
      change = "▎",
      delete = "▎",
    },
    priority = 199,
  },
  source = nil,
}

-- Snippets (provides snippet functionality for completion)
local MiniSnippets = require("mini.snippets")
MiniSnippets.setup {
  mappings = {
    expand = "",
    jump_next = "",
    jump_prev = "",
    stop = "<C-c>",
  },
  snippets = {},
  gen_loader = {},
}

-- Completion (replaces nvim-cmp)
require("mini.completion").setup {
  delay = { completion = 100, info = 100, signature = 50 },
  window = {
    info = { height = 25, width = 80, border = "none" },
    signature = { height = 25, width = 80, border = "none" },
  },
  lsp_completion = {
    source_func = "completefunc",
    auto_setup = true,
    process_items = function(items, base)
      local res = vim.tbl_filter(function(item)
        return item.kind ~= 1 or base:match("^%s*%-%-") or base:match("^%s*//") or base:match("^%s*#")
      end, items)
      return MiniCompletion.default_process_items(res, base)
    end,
  },
  fallback_action = function()
    if MiniSnippets.can_expand() then
      return MiniSnippets.expand()
    else
      return vim.api.nvim_replace_termcodes("<C-x><C-n>", true, false, true)
    end
  end,
  mappings = {
    force_twostep = "<C-Space>",
    force_fallback = "<A-Space>",
  },
  set_vim_settings = true,
}

-- Set up keymaps that integrate with your existing workflow
local map = vim.keymap.set

-- Session management keymaps
map("n", "<leader>wr", function()
  MiniSessions.read()
end, { desc = "Read session" })
map("n", "<leader>ws", function()
  MiniSessions.write()
end, { desc = "Write session" })
map("n", "<leader>wd", function()
  MiniSessions.delete()
end, { desc = "Delete session" })

-- Mini.diff keymaps
map("n", "]h", function()
  require("mini.diff").goto_hunk "next"
end, { desc = "Next hunk" })
map("n", "[h", function()
  require("mini.diff").goto_hunk "prev"
end, { desc = "Prev hunk" })

-- Completion keymaps
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

-- Fixed Tab and Shift-Tab for completion navigation and snippet expansion
map("i", "<Tab>", function()
  if vim.fn.pumvisible() == 1 then
    return "<C-n>"
  elseif MiniSnippets.can_expand() then
    MiniSnippets.expand()
    return ""
  elseif MiniSnippets.can_jump("next") then
    MiniSnippets.jump("next")
    return ""
  else
    return "<Tab>"
  end
end, { desc = "Next completion, expand snippet, or Tab", expr = true })

map("i", "<S-Tab>", function()
  if vim.fn.pumvisible() == 1 then
    return "<C-p>"
  elseif MiniSnippets.can_jump("prev") then
    MiniSnippets.jump("prev")
    return ""
  else
    return "<S-Tab>"
  end
end, { desc = "Previous completion, jump prev, or Shift-Tab", expr = true })

local snacks = require "snacks"

snacks.setup {
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

  animate = {
    enabled = true,
    duration = 150,
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
    sort = { "score", "created" },
    layout = {
      position = "top",
      preview_width = 0.6,
    },
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
          ["<C-x>"] = "delete_buffer",
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
      duration = { step = 15, total = 100 },
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

require("yazi").setup {
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
    telescope = {
      enabled = false,
    },
    which_key = true,
    lsp_trouble = true,
    nvim_surround = false,
    notify = false,
    noice = true,
    indent_blankline = {
      enabled = false,
    },
    mini = true,
  },
}

vim.cmd.colorscheme "catppuccin"

require("noice").setup {
  lsp = {
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },
  presets = {
    bottom_search = false,
    command_palette = true,
    long_message_to_split = true,
    inc_rename = false,
    lsp_doc_border = false,
  },
  routes = {
    {
      filter = { event = "notify" },
      view = "notify_send",
    },
  },
}

require("copilot").setup {
  suggestion = { 
    enabled = true,
    auto_trigger = true,
    debounce = 75,
    keymap = {
      accept = "<M-l>",
      accept_word = "<M-Right>",
      accept_line = "<M-Down>",
      next = "<M-]>",
      prev = "<M-[>",
      dismiss = "<C-]>",
    },
  },
  panel = { 
    enabled = true,
    auto_refresh = false,
    keymap = {
      jump_prev = "[[",
      jump_next = "]]",
      accept = "<CR>",
      refresh = "gr",
      open = "<M-CR>"
    },
  },
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

vim.diagnostic.config {
  virtual_text = { prefix = "" },
  signs = { text = { [x.ERROR] = "󰅙 ", [x.WARN] = " ", [x.INFO] = " ", [x.HINT] = "󰠠 " } },
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
      require_cwd = true,
    },
    prettier = {
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

-- Removed null-ls configuration as it's deprecated
-- Use conform.nvim and nvim-lint instead (which you already have)

require("refactoring").setup {
  show_success_message = true,
}

local refactoring = require "refactoring"

vim.keymap.set({ "n", "x" }, "<leader>rr", function()
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
    if not choice then return end
    
    if choice == "Extract Function" then
      refactoring.refactor("Extract Function")
    elseif choice == "Extract Function To File" then
      refactoring.refactor("Extract Function To File")
    elseif choice == "Extract Variable" then
      refactoring.refactor("Extract Variable")
    elseif choice == "Inline Variable" then
      refactoring.refactor("Inline Variable")
    elseif choice == "Extract Block" then
      refactoring.refactor("Extract Block")
    elseif choice == "Extract Block To File" then
      refactoring.refactor("Extract Block To File")
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
  ensure_installed = {},
  auto_install = false,
  highlight = { enable = true },
  indent = { enable = true },
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