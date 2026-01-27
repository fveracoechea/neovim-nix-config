local cmp = require "cmp"

require("cmp").register_source("mini_snippets", require("cmp_mini_snippets").new())

cmp.setup {
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },

  completion = {
    completeopt = "menuone,preview,noinsert,noselect",
  },

  snippet = {
    expand = function(args)
      local MiniSnippets = require "mini.snippets"
      local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
      insert { body = args.body }
      cmp.resubscribe { "TextChangedI", "TextChangedP" }
      require("cmp.config").set_onetime { sources = {} }
    end,
  },

  mapping = cmp.mapping.preset.insert {
    ["<C-b>"] = cmp.mapping.scroll_docs(-1),
    ["<C-f>"] = cmp.mapping.scroll_docs(5),
    ["<C-c>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
  },

  sources = cmp.config.sources {
    { name = "nvim_lsp" },
    { name = "mini_snippets" },
    { name = "copilot" },
    { name = "buffer" },
    { name = "path" },
  },

  sorting = {
    priority_weight = 2,
  },

  formatting = {
    format = function(entry, vim_item)
      local MiniIcons = require "mini.icons"
      local icon, hl = MiniIcons.get("lsp", vim_item.kind)
      vim_item.kind = icon .. " " .. vim_item.kind
      vim_item.kind_hl_group = hl
      return vim_item
    end,
  },
}
