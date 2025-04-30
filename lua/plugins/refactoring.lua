require("refactoring").setup {
  show_success_message = true,
}

-- load refactoring Telescope extension
require("telescope").load_extension "refactoring"

vim.keymap.set({ "n", "x" }, "<leader>rr", function()
  require("telescope").extensions.refactoring.refactors()
end, { desc = "Choose a refactor options" })
