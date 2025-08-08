# Snacks.nvim Migration Guide

This document outlines the plugins that have been replaced by snacks.nvim and the key changes.

## Replaced Plugins

### ✅ Fully Replaced
- **alpha-nvim** → `snacks.dashboard`
  - Custom dashboard with similar functionality
  - Key mappings preserved where possible
  - Actions now use snacks.picker instead of telescope commands

- **telescope-nvim** → `snacks.picker`
  - All file finding, grepping, and LSP navigation functionality
  - Preserved all existing keymaps (`<leader>ff`, `<leader>fs`, `<leader>b`, etc.)
  - Improved performance and better integration
  - Dashboard actions now use picker functions

- **nvim-notify** → `snacks.notifier`
  - Notification system with compact style
  - Same visual behavior and configuration

- **neoscroll-nvim** → `snacks.scroll`
  - Smooth scrolling with linear easing
  - Better performance and integration

- **indent-blankline-nvim** → `snacks.indent`
  - Indent guides with same visual character (┊)
  - Better scope detection

- **lazygit-nvim** → `snacks.lazygit`
  - LazyGit integration with theme configuration
  - Enhanced colorscheme integration

### ⚠️ Partially Replaced
- **todo-comments-nvim** → `snacks.words`
  - Word references functionality replaces jumping between comments
  - Lost: TODO highlighting and specific todo comment parsing
  - Consider keeping todo-comments if you heavily use TODO highlighting
  - Note: `<leader>ft` keymap for TodoTelescope is no longer available

- **dressing.nvim** → `snacks.input` + `snacks.picker`
  - Better `vim.ui.input` prompts handled by snacks.input
  - Better `vim.ui.select` menus handled by snacks.picker (ui_select=true)
  - Consistent UI styling with other snacks components

### 🔄 Migration Notes

#### Key Mappings
All telescope keymaps have been preserved and mapped to snacks.picker:
- `<leader>ff` - Find files (now uses snacks.picker.files)
- `<leader>fr` - Recent files (now uses snacks.picker.recent) 
- `<leader>fs` - Find string/Live grep (now uses snacks.picker.grep)
- `<leader>fc` - Find in current buffer (now uses snacks.picker.grep_buffers)
- `<leader>fw` - Find word under cursor (now uses snacks.picker.grep_word)
- `<leader>b` - Find buffers (now uses snacks.picker.buffers)
- `<leader>fa` - Find all files including hidden (preserved functionality)
- LSP keymaps (`<leader>lr`, `gd`, `<leader>li`, `<leader>lt`, `<leader>d`, `<leader>D`) preserved

Other new snacks.nvim mappings:
- `<leader>;` - Dashboard
- `<leader>bd` - Delete Buffer
- `<leader>bo` - Delete Other Buffers
- `<leader>gb` - Git Blame Line
- `<leader>gB` - Git Browse
- `<leader>gg` - LazyGit
- `<leader>n` - Notification History
- `<leader>nd` - Dismiss Notifications (preserved)
- `<leader>rn` - LSP Rename
- `<leader>z` - Zen Mode
- `<leader>.` - Scratch Buffer
- `]]` / `[[` - Next/Prev Word Reference
- Various `<leader>u*` toggles

#### Removed Key Mappings
- `<leader>ft` - Todo comment search (TodoTelescope no longer available)

#### Configuration Changes
- Dashboard header and keys updated to use snacks.picker functions
- Notification style matches previous nvim-notify configuration
- Scroll animation uses linear easing instead of default curves
- Picker configuration matches telescope behavior:
  - Smart path display
  - Similar keybindings (`<C-k>`/`<C-j>` for navigation, `<C-x>` for buffer deletion)
  - Ivy-style layout for LSP pickers and diagnostics
  - Case-insensitive smart searching

## Benefits of Migration

1. **Reduced Plugin Count**: Consolidated 8+ plugins into 1
2. **Better Integration**: All components work together seamlessly 
3. **Performance**: Single plugin with optimized shared code, faster than telescope
4. **Consistency**: Unified configuration and theming
5. **Additional Features**: Gained zen mode, terminal management, better toggles
6. **Maintained Functionality**: All telescope features preserved with same keymaps

## Recommendations

### Keep These Plugins
- **noice-nvim** - Provides cmdline and message improvements beyond notifications
- **gitsigns-nvim** - Kept for advanced git diff signs, hunk navigation, and staging features
- **todo-comments-nvim** - If you rely heavily on TODO highlighting (consider re-adding)

### Future Considerations  
- Monitor snacks.nvim development for additional modules
- Consider other mini.nvim plugins for further consolidation
- Evaluate if todo-comments should be re-added based on usage patterns

## Testing the Migration

1. Build the configuration: `nix build`
2. Test key functionality:
   - Dashboard display and navigation
   - All file finding operations (`<leader>ff`, `<leader>fs`, `<leader>b`, etc.)
   - LSP pickers (go to definition, references, diagnostics)
   - Buffer management and deletion
   - Smooth scrolling behavior
   - Indent guides visibility
   - Notification display
   - LazyGit integration
   - Git blame and browse features
   - Zen mode and terminal toggles

## Rollback Instructions

If issues arise, temporarily restore the old plugins by:
1. Uncommenting telescope-nvim and telescope-fzf-native-nvim entries in `neovim.nix`
2. Re-adding telescope configuration to the withConfig list
3. Commenting out the snacks.nvim picker keymaps
4. Restoring the original telescope keymaps in your main keymaps.lua
5. For other plugins, follow the same pattern of uncommenting in neovim.nix