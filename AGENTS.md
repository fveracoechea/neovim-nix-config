# AGENTS.md

Build/Lint/Test:
1. Format all Lua: stylua . ; single file: stylua path/to/file.lua
2. Flake sanity + Nix fmt (implicit): nix flake check
3. Build Neovim derivation: nix build
4. Apply locally (Home Manager): home-manager switch --flake .
5. Update inputs: nix flake update
6. (No test suite present) Simulate load: nvim --headless '+quit' ensures startup succeeds

Code Style (Lua):
7. Indent 2 spaces; max line 120; prefer double quotes; omit parens for simple require/use.
8. Top-order: options, keymaps, plugins, lsp setup; group requires first.
9. Local helpers at top (local map = vim.keymap.set); avoid polluting _G; use vim.g for globals.
10. Descriptive lower_snake_case locals; CamelCase only for external modules; constants UPPER_SNAKE.
11. Keymaps include desc; group with clear comment banners.
12. Avoid trailing whitespace; keep pure configuration (no side-effect prints).
13. Error handling: wrap optional plugin requires in pcall(require, "name"); fail soft, not hard.

Code Style (Nix):
14. Indent 2; inputs, outputs, packages each on own line blocks.
15. Prefer lib.fileContents for embedding Lua; keep plugin lists deterministic (alphabetical where practical).
16. Use let bindings for reuse; avoid duplication of versions / plugin names.

General:
17. Keep commits minimal & atomic; run stylua + nix flake check before commit.
18. Do not add secrets; no runtime network fetches in Lua (plugins handled by Nix).
19. Validate startup after changes: nvim --headless '+lua vim.cmd("quit")'.
20. If adding tests in future, document single-test invocation here.
