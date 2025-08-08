local snacks = require "snacks"

snacks.setup {

  dashboard = {
    enabled = true,
    sections = {
      { section = "header" },
      { section = "keys", gap = 1, padding = 1 },
      { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
      {
        section = "terminal",
        cmd = "zeitfetch --no-logo;",
        pane = 2,
        indent = 4,
        height = 16,
      },
      {
        section = "terminal",
        pane = 2,
        indent = 2,
        padding = 1,
        icon = " ",
        title = "Git Status",
        cmd = "git --no-pager diff --stat -B -M -C",
        height = 10,
        ttl = 5 * 60,
        enabled = Snacks.git.get_root() ~= nil,
      },
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
