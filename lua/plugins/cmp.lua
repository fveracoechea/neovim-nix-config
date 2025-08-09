local cmp = require "cmp"
local lspkind = require "lspkind"

require("copilot").setup {
  suggestion = { enabled = false },
  panel = { enabled = false },
}

require("copilot_cmp").setup()

cmp.register_source("mini_snippets", require("cmp_mini_snippets").new())

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
    completeopt = "menuone,preview,noselect",
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
    ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
    ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
    ["<C-e>"] = cmp.mapping.abort(), -- close completion window
    ["<CR>"] = cmp.mapping.confirm { select = false },
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

  -- configure lspkind for vs-code like pictograms in completion menu
  formatting = {
    expandable_indicator = true,
    fields = { "kind", "abbr", "menu" },
    format = lspkind.cmp_format {
      maxwidth = 50,
      ellipsis_char = "...",
      symbol_map = {
        Namespace = "󰌗",
        Text = "󰉿",
        Method = "󰆧",
        Function = "󰆧",
        Constructor = "",
        Field = "󰜢",
        Variable = "󰀫",
        Class = "󰠱",
        Interface = "",
        Module = "",
        Property = "󰜢",
        Unit = "󰑭",
        Value = "󰎠",
        Enum = "",
        Keyword = "󰌋",
        Snippet = "",
        Color = "󰏘",
        File = "󰈚",
        Reference = "󰈇",
        Folder = "󰉋",
        EnumMember = "",
        Constant = "󰏿",
        Struct = "󰙅",
        Event = "",
        Operator = "󰆕",
        TypeParameter = "󰊄",
        Table = "",
        Object = "󰅩",
        Tag = "",
        Array = "[]",
        Boolean = "",
        Number = "",
        Null = "󰟢",
        Supermaven = "",
        String = "󰉿",
        Calendar = "",
        Watch = "󰥔",
        Package = "",
        Copilot = "",
        Codeium = "",
        TabNine = "",
      },
    },
  },
}

vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
