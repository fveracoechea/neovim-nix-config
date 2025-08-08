# Mini.nvim Migration Guide

This document outlines the plugins that have been replaced by mini.nvim modules and the key changes.

## Replaced Plugins

### ✅ Fully Replaced by Mini.nvim
- **nvim-surround** → `mini.surround`
  - Same functionality with `sa`, `sd`, `sr` mappings
  - Enhanced text objects and search methods

- **nvim-autopairs** → `mini.pairs`
  - Automatic bracket, quote, and brace pairing
  - Smart neighbor pattern recognition
  - Better integration with completion

- **comment.nvim** → `mini.comment`
  - Line and block commenting with `gc` and `gcc`
  - Visual mode commenting support
  - Automatic commentstring detection

- **auto-session** → `mini.sessions`
  - Session management with better control
  - Manual read/write instead of automatic
  - Cleaner session directory structure

- **lualine.nvim** → `mini.statusline`
  - Comprehensive statusline with mode, git, diagnostics
  - LSP information and file details
  - Macro recording indicator
  - Better performance than lualine

- **nvim-web-devicons** → `mini.icons`
  - Icon provider for file types
  - Better integration with mini modules
  - Consistent icon theming

- **nvim-cmp** → `mini.completion` + `mini.snippets`
  - Simpler, more performant completion system
  - LSP-based completion with fallback support
  - Custom key mappings for navigation (`<C-j>`, `<C-k>`, `<Tab>`)
  - Integrated snippet expansion and navigation
  - Enhanced copilot suggestions integration

### 🔄 Migration Notes

#### Key Mappings
**Mini.surround** (replaces nvim-surround):
- `sa` - Add surrounding
- `sd` - Delete surrounding  
- `sr` - Replace surrounding
- `sf`/`sF` - Find surrounding

**Mini.comment** (replaces comment.nvim):
- `gc` - Toggle comment (works in visual mode)
- `gcc` - Toggle comment on current line
- `gc` text object for comment blocks

**Mini.sessions** (replaces auto-session):
- `<leader>wr` - Read/restore session
- `<leader>ws` - Write/save session  
- `<leader>wd` - Delete session

**Mini.diff** (optional gitsigns replacement):
- `]h`/`[h` - Navigate hunks
- `gh` - Apply/reset hunks (with visual selection)

**Mini.completion** (replaces nvim-cmp):
- `<C-j>` - Next completion item
- `<C-k>` - Previous completion item  
- `<Tab>` - Next completion, expand snippet, or jump to next placeholder
- `<S-Tab>` - Previous completion or jump to previous placeholder
- `<C-Space>` - Force completion trigger
- `<C-e>` - Close completion menu
- `<C-c>` - Stop snippet jumping

**Copilot Integration**:
- `<Alt-l>` - Accept copilot suggestion
- `<Alt-Right>` - Accept word from suggestion
- `<Alt-Down>` - Accept line from suggestion
- `<Alt-Enter>` - Open copilot panel
- `<Alt-]>` / `<Alt-[>` - Navigate suggestions

#### Configuration Changes
- **Statusline**: Now shows comprehensive info including macro recording
- **Sessions**: Manual control instead of automatic save/restore
- **Icons**: Integrated with mini.statusline and other mini modules
- **Autopairs**: Better handling of quotes and brackets with smart patterns
- **Comment**: Automatic treesitter integration for comment strings
- **Completion**: LSP-based completion with simpler configuration than nvim-cmp
- **Snippets**: Built-in snippet system with Tab expansion and navigation  
- **Copilot**: Re-enabled suggestions with enhanced key mappings and panel support

## Benefits of Mini.nvim Integration

1. **Unified Architecture**: All mini modules share the same design principles
2. **Better Performance**: Optimized Lua code with minimal overhead
3. **Consistent Configuration**: Similar setup patterns across all modules
4. **Independence**: Each module can be used separately or together
5. **Comprehensive**: Mini.nvim covers most common text editing needs
6. **Active Development**: Well-maintained with regular updates

## Optional Replacements to Consider

### Mini.diff vs Gitsigns
**Pros of mini.diff:**
- Lightweight git diff visualization
- Good hunk navigation and basic operations
- Consistent with other mini modules

**Pros of keeping gitsigns:**
- More advanced git features (blame, staging, etc.)
- Better integration with git workflows
- More configuration options

**Recommendation**: Keep gitsigns if you use advanced git features, use mini.diff if you only need basic diff visualization.

### Mini.completion vs nvim-cmp  
**✅ Now using mini.completion + mini.snippets:**
- Simpler, lighter completion system
- LSP-based completion with built-in filtering
- Better performance with less overhead
- Integrated snippet expansion and navigation
- Enhanced copilot suggestions (Alt+l to accept, panel support)
- Smart Tab behavior: completion → snippet expansion → placeholder jumping

**Migration notes:**
- Removed nvim-cmp, luasnip, lspkind, and cmp-* plugins
- Removed copilot-cmp integration plugin
- Added mini.snippets for snippet functionality
- Re-enabled copilot suggestions with better key mappings
- Completion sources now handled automatically by LSP
- Tab key intelligently handles completion, snippets, and placeholders

## Testing the Migration

1. Build the configuration: `nix build`
2. Test key functionality:
   - Statusline display and information
   - Surround operations (`sa`, `sd`, `sr`)
   - Comment toggling (`gc`, `gcc`)
   - Autopairs behavior with quotes and brackets
   - Session management (`<leader>wr`, `<leader>ws`)
   - Icon display throughout the interface
   - Git diff signs (if using mini.diff)
   - **NEW**: Completion with `<C-j>/<C-k>` navigation and `<C-Space>` trigger
   - **NEW**: Snippet expansion with `<Tab>` and placeholder jumping
   - **NEW**: Enhanced copilot with `<Alt-l>` accept and `<Alt-Enter>` panel

## Rollback Instructions

If issues arise, temporarily restore plugins by:
1. Uncommenting removed plugin entries in `neovim.nix`
2. Re-adding their configuration files to the withConfig list
3. Commenting out the mini.nvim configuration
4. Rebuilding with `nix build`

## Future Mini.nvim Modules to Consider

- **mini.files** - File browser (alternative to yazi)
- **mini.pick** - Picker interface (alternative to snacks.picker/telescope)  
- **mini.animate** - Smooth animations
- **mini.clue** - Key binding hints (alternative to which-key)
- **mini.jump** - Enhanced jumping within lines
- **mini.indentscope** - Indent scope visualization

## Notes

- Mini.nvim modules are independent - you can enable/disable individual modules
- Each module creates a global object (e.g., `MiniSurround`, `MiniComment`)
- Configuration is stored in `module.config` for easy access
- All modules follow consistent naming and setup patterns
- Check `:h mini-module-name` for detailed documentation on each module