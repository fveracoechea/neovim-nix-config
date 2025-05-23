---@type TailwindTools.Option
local tailwind_config = {
  server = {
    override = false,
  },
}

require("tailwind-tools").setup(tailwind_config)
