local cmp = require "cmp"
local minikind_format = require("cmp-minikind").cmp_format()
local tailwind_format = require("tailwind-tools.cmp").lspkind_format

require("copilot").setup {
  suggestion = { enabled = false },
  panel = { enabled = false },
}

require("copilot_cmp").setup()

local function border(hl_name)
  return {
    { "╭", hl_name },
    { "─", hl_name },
    { "╮", hl_name },
    { "│", hl_name },
    { "╯", hl_name },
    { "─", hl_name },
    { "╰", hl_name },
    { "│", hl_name },
  }
end

cmp.register_source("mini_snippets", require("utils.cmp-mini-snippets").new())

cmp.setup {
  window = {
    completion = {
      side_padding = 1,
      border = border "CmpBorder",
      scrollbar = true,
    },
    documentation = {
      border = border "CmpDocBorder",
      scrollbar = true,
    },
  },

  completion = {
    completeopt = "menuone,preview,noinsert,noselect",
  },

  -- configure how nvim-cmp interacts with snippet engine
  snippet = {
    expand = function(args)
      local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
      insert { body = args.body } -- Insert at cursor
      cmp.resubscribe { "TextChangedI", "TextChangedP" }
      require("cmp.config").set_onetime { sources = {} }
    end,
  },

  mapping = cmp.mapping.preset.insert {
    ["<CR>"] = cmp.mapping.confirm { select = true },
    ["<C-b>"] = cmp.mapping.scroll_docs(-1),
    ["<C-f>"] = cmp.mapping.scroll_docs(5),
    ["<C-c>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
  },

  -- sources for autocompletion
  sources = cmp.config.sources {
    { name = "nvim_lsp" },
    { name = "mini_snippets" },
    { name = "copilot" },
    { name = "buffer" }, -- text within current buffer
    { name = "path" }, -- file system paths
  },

  sorting = {
    priority_weight = 2,
  },

  formatting = {
    format = function(entry, vim_item)
      local item = tailwind_format(entry, vim_item)
      return minikind_format(entry, item)
    end,
  },
}

vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#A6E3A1" })
