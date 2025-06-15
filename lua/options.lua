local opt = vim.opt
local o = vim.o
local g = vim.g

-- enable mdx
vim.filetype.add {
  extension = {
    mdx = "markdown",
  },
}

o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- disable netrw at the very start of your init.lua
-- recommended settings from nvim-tree documentation
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-- mouse mode (disabled)
o.mouse = ""

-- set highlight on search
o.hlsearch = true

-- optionally enable 24-bit colour
opt.termguicolors = true

-- save undo history
vim.o.undofile = true

-- always show sign column so that text doesn't shift
opt.signcolumn = "yes"

-- make line numbers default
opt.number = true
opt.relativenumber = true

-- highlight the text line of the cursor
opt.cursorline = true

-- lines longer than the width of the window will not wrap
opt.wrap = false

-- copy indent from current line when starting new one
opt.autoindent = true

-- every wrapped line will continue visually indented
vim.o.breakindent = true

-- case insensitive searching UNLESS /C or capital in search
opt.ignorecase = true
opt.smartcase = true

-- use system clipboard as default register
opt.clipboard:append "unnamedplus"

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false

-- tabs & indenting
o.expandtab = true
o.shiftwidth = 2
o.smartindent = true
o.tabstop = 2
o.softtabstop = 2

-- timeout
vim.o.timeout = true
vim.o.timeoutlen = 500

-- lazygit
vim.g.lazygit_floating_window_scaling_factor = 0.85 -- scaling factor for floating window
