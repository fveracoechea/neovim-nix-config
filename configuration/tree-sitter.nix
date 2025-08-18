# Tree-sitter grammars configuration
{
  pkgs,
  inputs,
  ...
}: grammars: [
  # Core languages
  grammars.tree-sitter-nix
  grammars.tree-sitter-vim
  grammars.tree-sitter-bash
  grammars.tree-sitter-lua
  grammars.tree-sitter-c

  # Web technologies
  grammars.tree-sitter-javascript
  grammars.tree-sitter-typescript
  grammars.tree-sitter-tsx
  grammars.tree-sitter-html
  grammars.tree-sitter-css
  grammars.tree-sitter-vue
  grammars.tree-sitter-svelte
  grammars.tree-sitter-graphql

  # Data formats
  grammars.tree-sitter-json
  grammars.tree-sitter-yaml
  grammars.tree-sitter-markdown
  grammars.tree-sitter-markdown-inline

  # Other languages
  grammars.tree-sitter-python
  grammars.tree-sitter-prisma
  grammars.tree-sitter-dockerfile

  # Build systems
  grammars.tree-sitter-make
  grammars.tree-sitter-cmake

  # Misc
  grammars.tree-sitter-gitignore
  grammars.tree-sitter-query
  grammars.tree-sitter-vimdoc

  # Custom grammar
  (pkgs.tree-sitter.buildGrammar {
    language = "nginx";
    version = "unstable-2024-10-04";
    src = inputs.tree-sitter-nginx;
  })
]
