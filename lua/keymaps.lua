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
map("n", "<leader>x", "<CMD>close<CR>", { desc = "Close current split" })
map("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })

-- ============================================================================
-- PLUGIN MAPPINGS
-- ============================================================================

-- Yazi file manager
map("n", "<C-n>", "<CMD>Yazi cwd<CR>", { desc = "Open the file manager in nvim's working directory" })
map("n", "<leader>e", "<CMD>Yazi<CR>", { desc = "Open yazi at the current file" })

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

local snacks = require "snacks"

-- Dashboard
map("n", "<leader>;", function()
  snacks.dashboard()
end, { desc = "Dashboard" })

-- File and text finding
map("n", "<leader>ff", function()
  snacks.picker.files()
end, { desc = "Find files in cwd" })
map("n", "<leader>fr", function()
  snacks.picker.recent()
end, { desc = "Find recent files" })
map("n", "<leader>fs", function()
  snacks.picker.grep()
end, { desc = "Find string in cwd" })
map("n", "<leader>fc", function()
  snacks.picker.grep_buffers()
end, { desc = "Find in current buffer" })
map("n", "<leader>fw", function()
  snacks.picker.grep_word()
end, { desc = "Find string under cursor in Workspace" })
map("n", "<leader>b", function()
  snacks.picker.buffers()
end, { desc = "Find open buffers" })
map("n", "<leader>fa", function()
  snacks.picker.files { hidden = true, no_ignore = true }
end, { desc = "Find all files" })

-- LSP pickers (buffer-local maps set in lsp-settings.lua)
-- Global LSP keymaps for reference:
-- <leader>lr - LSP references
-- gd - LSP definitions
-- <leader>li - LSP implementations
-- <leader>lt - LSP type definitions
-- <leader>ca - Code actions
-- <leader>rn - Smart rename
-- <leader>d - Buffer diagnostics
-- <leader>D - All diagnostics
-- [d - Previous diagnostic
-- ]d - Next diagnostic

-- Buffer management
map("n", "<leader>bd", function()
  snacks.bufdelete()
end, { desc = "Delete Buffer" })
map("n", "<leader>bo", function()
  snacks.bufdelete.other()
end, { desc = "Delete Other Buffers" })

-- Git integration
map("n", "<leader>gb", function()
  snacks.git.blame_line()
end, { desc = "Git Blame Line" })
map("n", "<leader>gB", function()
  snacks.gitbrowse()
end, { desc = "Git Browse" })
map("n", "<leader>gf", function()
  snacks.lazygit.log_file()
end, { desc = "Lazygit Current File History" })
map("n", "<leader>lg", function()
  snacks.lazygit()
end, { desc = "Open Lazygit" })
map("n", "<leader>gl", function()
  snacks.lazygit.log()
end, { desc = "Lazygit Log (cwd)" })

-- Notifications
map("n", "<leader>n", function()
  snacks.notifier.show_history()
end, { desc = "Notification History" })
map("n", "<leader>nd", function()
  snacks.notifier.hide()
end, { desc = "Dismiss All Notifications" })

-- LSP rename (buffer-local map set in lsp-settings.lua)
-- <leader>rn - LSP rename

-- Terminal
map("n", "<c-/>", function()
  snacks.terminal()
end, { desc = "Toggle Terminal" })
map("n", "<c-_>", function()
  snacks.terminal()
end, { desc = "Toggle Terminal (which-key workaround)" })
map("t", "<c-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
map("t", "<c-_>", "<cmd>close<cr>", { desc = "Hide Terminal (which-key workaround)" })

-- Word references
map("n", "]]", function()
  snacks.words.jump(vim.v.count1)
end, { desc = "Next Reference" })
map("n", "[[", function()
  snacks.words.jump(-vim.v.count1)
end, { desc = "Prev Reference" })

-- Zen mode
map("n", "<leader>z", function()
  snacks.zen()
end, { desc = "Toggle Zen Mode" })
map("n", "<leader>Z", function()
  snacks.zen.zoom()
end, { desc = "Toggle Zoom" })

-- Scratch buffer
map("n", "<leader>.", function()
  snacks.scratch()
end, { desc = "Toggle Scratch Buffer" })
map("n", "<leader>S", function()
  snacks.scratch.select()
end, { desc = "Select Scratch Buffer" })

-- Toggle utilities
map("n", "<leader>ul", function()
  snacks.toggle.line_number()
end, { desc = "Toggle Line Numbers" })
map("n", "<leader>uL", function()
  snacks.toggle.option("relativenumber", { name = "Relative Numbers" })
end, { desc = "Toggle Relative Numbers" })
map("n", "<leader>uw", function()
  snacks.toggle.option("wrap", { name = "Wrap" })
end, { desc = "Toggle Line Wrap" })
map("n", "<leader>us", function()
  snacks.toggle.option("spell", { name = "Spelling" })
end, { desc = "Toggle Spelling" })

-- ============================================================================
-- MINI PLUGIN MAPPINGS
-- ============================================================================

-- Session management
map("n", "<leader>wr", function()
  require("mini.sessions").read()
end, { desc = "Read session" })
map("n", "<leader>ws", function()
  require("mini.sessions").write()
end, { desc = "Write session" })
map("n", "<leader>wd", function()
  require("mini.sessions").delete()
end, { desc = "Delete session" })

-- Mini.diff keymaps
map("n", "]h", function()
  require("mini.diff").goto_hunk "next"
end, { desc = "Next hunk" })
map("n", "[h", function()
  require("mini.diff").goto_hunk "prev"
end, { desc = "Prev hunk" })

-- ============================================================================
-- REFACTORING PLUGIN MAPPINGS
-- ============================================================================

-- Refactor using snacks.picker instead of telescope
map({ "n", "x" }, "<leader>rr", function()
  local refactoring = require "refactoring"
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

-- ============================================================================
-- LINT PLUGIN MAPPINGS
-- ============================================================================

map("n", "<leader>ll", function()
  require("lint").try_lint()
end, { desc = "Trigger linting for current file" })
