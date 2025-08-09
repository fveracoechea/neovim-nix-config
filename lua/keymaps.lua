vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local map = vim.keymap.set

-- ============================================================================
-- CORE VIM MAPPINGS
-- ============================================================================

-- Save file
map("n", "<C-s>", "<CMD>w<CR>", { desc = "file save" })

-- Window management
map("n", "<leader>\\", "<C-w>v", { desc = "Split window vertically" })
map("n", "<leader>-", "<C-w>s", { desc = "Split window horizontally" })
map("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })

-- ============================================================================
-- PLUGIN MAPPINGS
-- ============================================================================

-- Yazi file manager
map("n", "<C-n>", "<CMD>Yazi cwd<CR>", { desc = "Open the file manager in nvim's working directory" })
map("n", "<C-y>", "<CMD>Yazi<CR>", { desc = "Open yazi at the current file" })

-- Hover documentation
local hover = require "hover"
map("n", "K", hover.hover, { desc = "Hover" })
map("n", "gK", hover.hover_select, { desc = "hover.nvim (select)" })

-- CodeSnap screenshots
map("v", "<leader>cc", "<CMD>CodeSnap<CR>", { desc = "Save selected code snapshot into clipboard" })
map("v", "<leader>cs", "<CMD>CodeSnapSave<CR>", { desc = "Save selected code snapshot in ~/Pictures" })

-- ============================================================================
-- SNACKS PLUGIN MAPPINGS
-- ============================================================================

local Snacks = require "snacks"

-- Dashboard

map("n", "<leader>;", function()
  Snacks.dashboard()
end, { desc = "Dashboard" })

-- File and text finding

map("n", "<leader>ff", function()
  Snacks.picker.files()
end, { desc = "Find files in cwd" })

map("n", "<leader>fr", function()
  Snacks.picker.recent()
end, { desc = "Find recent files" })

map("n", "<leader>fs", function()
  Snacks.picker.grep()
end, { desc = "Find string in cwd" })

map("n", "<leader>fc", function()
  Snacks.picker.grep_buffers()
end, { desc = "Find in current buffer" })

map("n", "<leader>fw", function()
  Snacks.picker.grep_word()
end, { desc = "Find string under cursor in Workspace" })

map("n", "<leader>fa", function()
  Snacks.picker.files { hidden = true, no_ignore = true }
end, { desc = "Find all files" })

-- Explorer

map("n", "<leader>e", function()
  Snacks.picker.explorer()
end, { desc = "Open the file manager at the current file" })

-- Buffer management

map("n", "<leader>b", function()
  Snacks.picker.buffers { layout = { preset = "ivy" } }
end, { desc = "Find open buffers" })

map("n", "<leader>x", function()
  Snacks.bufdelete()
end, { desc = "Delete Buffer" })

map("n", "<leader>xo", function()
  Snacks.bufdelete.other()
end, { desc = "Delete Other Buffers" })

-- Git integration

map("n", "<leader>gb", function()
  Snacks.git.blame_line()
end, { desc = "Git Blame Line" })

map("n", "<leader>gB", function()
  Snacks.gitbrowse()
end, { desc = "Git Browse" })

map("n", "<leader>gf", function()
  Snacks.lazygit.log_file()
end, { desc = "Lazygit Current File History" })

map("n", "<leader>lg", function()
  Snacks.lazygit()
end, { desc = "Open Lazygit" })

map("n", "<leader>gl", function()
  Snacks.lazygit.log()
end, { desc = "Lazygit Log (cwd)" })

-- Notifications

map("n", "<leader>n", function()
  Snacks.notifier.show_history()
end, { desc = "Notification History" })
map("n", "<leader>nd", function()
  Snacks.notifier.hide()
end, { desc = "Dismiss All Notifications" })

-- Word references
map("n", "]]", function()
  Snacks.words.jump(vim.v.count1)
end, { desc = "Next Reference" })
map("n", "[[", function()
  Snacks.words.jump(-vim.v.count1)
end, { desc = "Prev Reference" })

-- Zen mode
map("n", "<leader>z", function()
  Snacks.zen()
end, { desc = "Toggle Zen Mode" })
map("n", "<leader>Z", function()
  Snacks.zen.zoom()
end, { desc = "Toggle Zoom" })

-- Scratch buffer

map("n", "<leader>.", function()
  Snacks.scratch()
end, { desc = "Toggle Scratch Buffer" })

map("n", "<leader>S", function()
  Snacks.scratch.select()
end, { desc = "Select Scratch Buffer" })

-- Toggle utilities

map("n", "<leader>ul", function()
  Snacks.toggle.line_number()
end, { desc = "Toggle Line Numbers" })

map("n", "<leader>uL", function()
  Snacks.toggle.option("relativenumber", { name = "Relative Numbers" })
end, { desc = "Toggle Relative Numbers" })

map("n", "<leader>uw", function()
  Snacks.toggle.option("wrap", { name = "Wrap" })
end, { desc = "Toggle Line Wrap" })

map("n", "<leader>us", function()
  Snacks.toggle.option("spell", { name = "Spelling" })
end, { desc = "Toggle Spelling" })

-- ============================================================================
-- MINI PLUGIN MAPPINGS
-- ============================================================================

-- Session management

map("n", "<leader>wr", function()
  local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
  require("mini.sessions").read(cwd)
end, { desc = "Read session" })

map("n", "<leader>ws", function()
  local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
  require("mini.sessions").write(cwd)
end, { desc = "Write session" })

map("n", "<leader>wd", function()
  local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
  require("mini.sessions").delete(cwd)
end, { desc = "Delete session" })

-- Mini.diff keymaps

map("n", "]h", function()
  require("mini.diff").goto_hunk "next"
end, { desc = "Next hunk" })

map("n", "[h", function()
  require("mini.diff").goto_hunk "prev"
end, { desc = "Prev hunk" })

-- Mini.completion keymaps

local MiniSnippets = require "mini.snippets"

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

-- ============================================================================
-- LINT PLUGIN MAPPINGS
-- ============================================================================

map("n", "<leader>ll", function()
  require("lint").try_lint()
end, { desc = "Trigger linting for current file" })
