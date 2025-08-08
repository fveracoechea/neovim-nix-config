-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
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
-- PLUGIN MAPPINGS (NOT HANDLED BY SNACKS/MINI)
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
