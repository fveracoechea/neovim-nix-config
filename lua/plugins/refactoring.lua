require("refactoring").setup {
  show_success_message = true,
}

-- Refactoring keymaps (updated to work without telescope)
local refactoring = require "refactoring"

-- Refactor using snacks.picker instead of telescope
vim.keymap.set({ "n", "x" }, "<leader>rr", function()
  -- Use vim.ui.select (which is handled by snacks.picker) for refactor options
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
    if not choice then return end
    
    if choice == "Extract Function" then
      refactoring.refactor("Extract Function")
    elseif choice == "Extract Function To File" then
      refactoring.refactor("Extract Function To File")
    elseif choice == "Extract Variable" then
      refactoring.refactor("Extract Variable")
    elseif choice == "Inline Variable" then
      refactoring.refactor("Inline Variable")
    elseif choice == "Extract Block" then
      refactoring.refactor("Extract Block")
    elseif choice == "Extract Block To File" then
      refactoring.refactor("Extract Block To File")
    end
  end)
end, { desc = "Choose a refactor option" })
