require("tailwind-tools").setup {
  server = {
    override = true, -- setup the server from the plugin
    on_attach = function()
      local map = vim.keymap.set
      map("n", "<leader>twc", ":TailwindConcealToggle<CR>", { desc = "Tailwind conceal toggle" })
      map("n", "<leader>tws", ":TailwindSort<CR>", { desc = "Tailwind sorts all classes in the current buffer" })
      map("n", "<leader>twn", ":TailwindNextClass<CR>", { desc = "Tailwind moves to the NEXT class" })
      map("n", "<leader>twp", ":TailwindNextClass<CR>", { desc = "Tailwind moves to the PREVIOUS class" })
    end,
  },
  conceal = {
    enabled = true, -- can be toggled by commands
    min_length = 40, -- only conceal classes exceeding the provided length
  },
}
