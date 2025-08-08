require("copilot").setup {
  suggestion = { 
    enabled = true,
    auto_trigger = true,   -- Enable auto-trigger for better UX
    debounce = 75,
    keymap = {
      accept = "<M-l>",     -- Alt+l to accept (doesn't conflict with Tab)
      accept_word = "<M-Right>",  -- Alt+Right to accept word
      accept_line = "<M-Down>",   -- Alt+Down to accept line  
      next = "<M-]>",       -- Alt+] for next suggestion
      prev = "<M-[>",       -- Alt+[ for previous suggestion
      dismiss = "<C-]>",    -- Ctrl+] to dismiss
    },
  },
  panel = { 
    enabled = true,        -- Enable panel for manual browsing
    auto_refresh = false,  -- Don't auto-refresh to avoid conflicts
    keymap = {
      jump_prev = "[[",
      jump_next = "]]",
      accept = "<CR>",
      refresh = "gr",
      open = "<M-CR>"      -- Alt+Enter to open panel
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
