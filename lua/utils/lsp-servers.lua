vim.lsp.enable {
  "html",
  "nil_ls",
  "lua_ls",
  "cssls",
  "nginx_language_server",
  "eslint",
  "graphql",
  "relay_lsp",
  "denols",
  "ts_ls",
  "jsonls",
  "tailwindcss",
}

--LSP configurations
local servers = {
  -- HTML
  html = {},
  -- NIX
  nil_ls = {},
  -- LUA
  lua_ls = {},
  -- CSS
  cssls = {},
  nginx_language_server = {},
  eslint = {},
  graphql = {},
  relay_lsp = {},
  denols = {},
  ts_ls = {},
  -- ts_ls = {
  --   on_attach = function(client, bufnr)
  --     if lspconfig.util.root_pattern("deno.json", "deno.jsonc")(vim.fn.getcwd()) then
  --       if client.name == "ts_ls" then
  --         client.stop()
  --         return
  --       end
  --     end
  --   end,
  --   single_file_support = false,
  --   root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "node_modules"),
  --   init_options = {
  --     preferences = {
  --       disableSuggestions = true,
  --     },
  --   },
  -- },
  -- JSON schemas
  -- Schemas https://www.schemastore.org
  jsonls = {},
  tailwindcss = {},
  -- TailwindCSS
  -- tailwindcss = {
  --   settings = {
  --     tailwindCSS = {
  --       classAttributes = {
  --         "class",
  --         "className",
  --         "class:list",
  --         "classList",
  --         "ngClass",
  --         "classNames",
  --         "styles",
  --       },
  --       experimental = {
  --         -- https://github.com/paolotiu/tailwind-intellisense-regex-list
  --         classRegex = {
  --           -- clsx
  --           { "clsx\\(([^]*)\\)", "(?:'|\"|`)([^\"'`]*)(?:'|\"|`)" },
  --           -- class-variance-authority
  --           { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
  --           { "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
  --           -- Plain Javascript Object
  --           --  const styles = {
  --           --   wrapper: 'flex flex-col',
  --           --   navItem: 'relative mb-2 md:mb-0',
  --           --   bullet: 'absolute w-2 h-2 2xl:w-4 2xl:h-4 bg-red rounded-full',
  --           -- };
  --           { ":\\s*?[\"'`]([^\"'`]*).*?," },
  --           -- JavaScript string variable with keywords
  --           -- const styles = "bg-red-500 text-white";
  --           -- let Classes = "p-4 rounded";
  --           -- var classnames = "flex justify-center";
  --           -- const buttonStyles = "bg-blue-500 hover:bg-blue-700";
  --           -- let formClasses = "space-y-4";
  --           -- var inputClassnames = "border-2 border-gray-300";
  --           -- styles += 'rounded';
  --           {
  --             "(?:\\b(?:const|let|var)\\s+)?[\\w$_]*(?:[Ss]tyles|[Cc]lasses|[Cc]lassnames)[\\w\\d]*\\s*(?:=|\\+=)\\s*['\"]([^'\"]*)['\"]",
  --           },
  --           -- classList
  --           { "classList={{([^;]*)}}", "\\s*?[\"'`]([^\"'`]*).*?:" },
  --         },
  --       },
  --     },
  --   },
  -- },
}
