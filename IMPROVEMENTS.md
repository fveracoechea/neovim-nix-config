# Neovim Configuration Improvements

Based on analysis of your current configuration, here are recommended improvements to enhance your Neovim setup.

## Priority Improvements

### 1. Keymaps Organization (`lua/keymaps.lua`)

**Current Issues:**
- Keymaps are scattered without logical grouping
- Missing common navigation and LSP mappings
- No buffer or diagnostic navigation

**Recommended Additions:**

```lua
-- Buffer Navigation
map("n", "]b", "<CMD>bnext<CR>", { desc = "Next buffer" })
map("n", "[b", "<CMD>bprevious<CR>", { desc = "Previous buffer" })
map("n", "<leader>bd", "<CMD>bdelete<CR>", { desc = "Delete buffer" })
map("n", "<leader>bo", "<CMD>%bdelete|edit#|bdelete#<CR>", { desc = "Close other buffers" })

-- Quick Fix Navigation
map("n", "]q", "<CMD>cnext<CR>", { desc = "Next quickfix item" })
map("n", "[q", "<CMD>cprev<CR>", { desc = "Previous quickfix item" })
map("n", "<leader>qo", "<CMD>copen<CR>", { desc = "Open quickfix list" })
map("n", "<leader>qc", "<CMD>cclose<CR>", { desc = "Close quickfix list" })

-- Diagnostic Navigation
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostic" })
map("n", "<leader>dl", "<CMD>Telescope diagnostics<CR>", { desc = "List diagnostics" })

-- Better indenting in visual mode
map("v", "<", "<gv", { desc = "Indent left and reselect" })
map("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Move lines up/down
map("n", "<A-j>", "<CMD>m .+1<CR>==", { desc = "Move line down" })
map("n", "<A-k>", "<CMD>m .-2<CR>==", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Better escape
map("i", "jk", "<ESC>", { desc = "Exit insert mode" })

-- Clear search highlights
map("n", "<leader>nh", "<CMD>nohl<CR>", { desc = "Clear search highlights" })
```

### 2. Options Consistency (`lua/options.lua`)

**Current Issues:**
- Mixed usage of `vim.o`, `vim.opt`, and `vim.g`
- Missing modern Neovim options

**Recommended Changes:**

```lua
-- Replace mixed API usage with consistent vim.opt
local opt = vim.opt

-- Performance
opt.updatetime = 250        -- Faster CursorHold events
opt.timeoutlen = 500       -- Which-key timeout
opt.redrawtime = 10000     -- Allow more time for loading syntax on large files

-- UI Enhancements
opt.pumheight = 10         -- Limit popup menu height
opt.conceallevel = 0       -- Show concealed text (useful for markdown)
opt.scrolloff = 8          -- Keep 8 lines visible when scrolling
opt.sidescrolloff = 8      -- Keep 8 columns visible when scrolling
opt.showmode = false       -- Don't show mode (lualine shows it)
opt.cmdheight = 1          -- Command line height
opt.laststatus = 3         -- Global statusline

-- Search
opt.inccommand = "split"   -- Live preview of substitutions

-- Completion
opt.completeopt = { "menu", "menuone", "preview", "noselect" }
opt.shortmess:append("c")  -- Don't show completion messages

-- Backup and Swap
opt.backup = false         -- Don't create backup files
opt.writebackup = false    -- Don't create backup before overwrite
opt.swapfile = false       -- Already set, but keeping for clarity

-- Folding (if you use it)
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldenable = false     -- Don't fold by default
```

### 3. LSP Configuration Enhancement (`lua/plugins/lspconfig.lua`)

**Current Issues:**
- Missing on_attach function with keymaps
- No LSP-specific key bindings
- Missing capabilities configuration

**Recommended Enhancement:**

```lua
require("lsp-file-operations").setup()

local x = vim.diagnostic.severity

-- Enhanced diagnostic configuration
vim.diagnostic.config {
  virtual_text = { 
    prefix = "",
    severity = { min = vim.diagnostic.severity.WARN }, -- Only show warnings and errors
  },
  signs = { 
    text = { 
      [x.ERROR] = "󰅙 ", 
      [x.WARN] = " ", 
      [x.INFO] = " ", 
      [x.HINT] = "󰠠 " 
    } 
  },
  underline = true,
  float = { 
    border = "single",
    source = "always",  -- Show source in floating window
    header = "",
    prefix = "",
  },
  severity_sort = true,   -- Sort diagnostics by severity
  update_in_insert = false, -- Don't update diagnostics in insert mode
}

-- LSP on_attach function with keymaps
local on_attach = function(client, bufnr)
  local map = vim.keymap.set
  local opts = { buffer = bufnr, silent = true }
  
  -- Navigation
  map("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
  map("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
  map("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
  map("n", "gt", vim.lsp.buf.type_definition, vim.tbl_extend("force", opts, { desc = "Go to type definition" }))
  map("n", "gr", "<CMD>Telescope lsp_references<CR>", vim.tbl_extend("force", opts, { desc = "Show references" }))
  
  -- Actions
  map("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
  map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code actions" }))
  map("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, vim.tbl_extend("force", opts, { desc = "Format buffer" }))
  
  -- Documentation
  map("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover documentation" }))
  map("n", "<leader>k", vim.lsp.buf.signature_help, vim.tbl_extend("force", opts, { desc = "Signature help" }))
  
  -- Workspace
  map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, vim.tbl_extend("force", opts, { desc = "Add workspace folder" }))
  map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, vim.tbl_extend("force", opts, { desc = "Remove workspace folder" }))
  map("n", "<leader>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, vim.tbl_extend("force", opts, { desc = "List workspace folders" }))
end

-- Add capabilities for nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Update your LSP server configurations to use on_attach and capabilities
-- You'll need to modify lua/lsp-servers.lua to accept these parameters
require("lsp-servers").setup(on_attach, capabilities)
```

### 4. Plugin Optimizations

#### Telescope Enhancement (`lua/plugins/telescope.lua`)

**Add to your telescope setup:**

```lua
-- Add to defaults table
file_ignore_patterns = {
  "node_modules",
  ".git/",
  "dist/",
  "build/",
  "*.lock",
},
preview = {
  mime_hook = function(filepath, bufnr, opts)
    local is_image = function(filepath)
      local image_extensions = {'png','jpg','jpeg','gif','bmp','tiff','ico'}
      local split_path = vim.split(filepath:lower(), '.', {plain=true})
      local extension = split_path[#split_path]
      return vim.tbl_contains(image_extensions, extension)
    end
    if is_image(filepath) then
      local term = vim.api.nvim_open_term(bufnr, {})
      local function send_output(_, data, _ )
        for _, d in ipairs(data) do
          vim.api.nvim_chan_send(term, d .. '\r\n')
        end
      end
      vim.fn.jobstart(
        {
          'catimg', filepath  -- Terminal image viewer
        },
        {on_stdout=send_output, stdout_buffered=true, pty=true})
    else
      require("telescope.previewers.utils").set_preview_message(bufnr, opts.winid, "Binary cannot be previewed")
    end
  end
},
```

#### CMP Enhancement (`lua/plugins/cmp.lua`)

**Add more completion sources:**

```lua
-- Add to your sources table
sources = cmp.config.sources({
  { name = "nvim_lsp", priority = 1000 },
  { name = "copilot", priority = 900 },
  { name = "luasnip", priority = 750 },
  { name = "buffer", priority = 500, keyword_length = 3 },
  { name = "path", priority = 250 },
}, {
  { name = "buffer", keyword_length = 5 },
})

-- Add performance improvements
performance = {
  debounce = 60,
  throttle = 30,
  fetching_timeout = 500,
},

-- Add experimental features
experimental = {
  ghost_text = {
    hl_group = "CmpGhostText",
  },
},
```

## Structure Improvements

### 1. Create Utils Module (`lua/utils.lua`)

```lua
-- Shared utility functions across configurations
local M = {}

-- Create keymap with default options
function M.map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- Check if plugin is installed
function M.has_plugin(plugin)
  return require("lazy.core.config").plugins[plugin] ~= nil
end

-- Toggle option
function M.toggle_option(option)
  vim.opt[option] = not vim.opt[option]:get()
  print(option .. " = " .. tostring(vim.opt[option]:get()))
end

return M
```

### 2. Add Autocmds (`lua/autocmds.lua`)

```lua
-- Auto commands for enhanced functionality
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Highlight on yank
augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
  group = "YankHighlight",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})

-- Auto resize panes when resizing nvim window
augroup("ResizePanes", { clear = true })
autocmd("VimResized", {
  group = "ResizePanes",
  command = "tabdo wincmd =",
})

-- Close some filetypes with <q>
augroup("CloseWithQ", { clear = true })
autocmd("FileType", {
  group = "CloseWithQ",
  pattern = { "qf", "help", "man", "notify", "lspinfo", "spectre_panel" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<CMD>close<CR>", { buffer = event.buf, silent = true })
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
augroup("AutoCreateDir", { clear = true })
autocmd("BufWritePre", {
  group = "AutoCreateDir",
  callback = function(event)
    if event.match:match("^%w%w+://") then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})
```

### 3. Update Main Config

**Add to your `neovim.nix` extraLuaConfig:**

```lua
require "options"
require "keymaps"
require "autocmds"  -- Add this line
```

## Implementation Priority

1. **High Priority**: LSP keymaps and enhanced options
2. **Medium Priority**: Buffer navigation and diagnostic keymaps  
3. **Low Priority**: Utils module and autocmds

## Testing

After implementing these changes:

1. Run `:checkhealth` to ensure everything is working
2. Test LSP functionality with `gd`, `gr`, `<leader>rn`
3. Verify buffer navigation with `]b`, `[b`
4. Check diagnostic navigation with `]d`, `[d`

These improvements will significantly enhance your Neovim workflow while maintaining the clean structure you already have.