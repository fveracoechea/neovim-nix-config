local snacks = require "snacks"

snacks.setup {

  dashboard = {
    enabled = true,
    sections = {
      { section = "header" },
      { section = "keys", gap = 1, padding = 1 },
      { section = "startup" },
      {
        section = "terminal",
        cmd = "zeitfetch --no-logo;",
        pane = 2,
        indent = 4,
        height = 30,
      },
      { icon = " ", title = "Recent Files", pane = 2, section = "recent_files", indent = 2, padding = { 2, 2 } },
    },
  },
  preset = {
    keys = {
      { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
      { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
      { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
      { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
      { icon = " ", key = "s", desc = "Restore Session", section = ':lua require("mini.sessions").read()' },
      { icon = " ", key = "q", desc = "Quit", action = ":qa" },
    },
  },

  indent = {
    enabled = true,
    char = "┊",
  },

  picker = { enabled = true },
  notifier = { enabled = true },
  bigfile = { enabled = true },
  animate = { enabled = true },
  bufdelete = { enabled = true },
  debug = { enabled = true },
  git = { enabled = true },
  gitbrowse = { enabled = true },
  lazygit = { enabled = true },
  quickfile = { enabled = true },
  input = { enabled = true },
  rename = { enabled = true },
  scope = { enabled = true },
  scroll = { enabled = true },
  statuscolumn = { enabled = true },
  toggle = { enabled = true },
  words = { enabled = true },
}

-- Note: Keymaps are now centralized in lua/keymaps.lua
