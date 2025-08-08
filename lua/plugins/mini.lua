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
local MiniSnippets = require "mini.snippets"
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
        return item.kind ~= 1 or base:match "^%s*%-%-" or base:match "^%s*//" or base:match "^%s*#"
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
  elseif MiniSnippets.can_jump "next" then
    MiniSnippets.jump "next"
    return ""
  else
    return "<Tab>"
  end
end, { desc = "Next completion, expand snippet, or Tab", expr = true })

map("i", "<S-Tab>", function()
  if vim.fn.pumvisible() == 1 then
    return "<C-p>"
  elseif MiniSnippets.can_jump "prev" then
    MiniSnippets.jump "prev"
    return ""
  else
    return "<S-Tab>"
  end
end, { desc = "Previous completion, jump prev, or Shift-Tab", expr = true })

