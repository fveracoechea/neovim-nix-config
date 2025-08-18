{
  pkgs,
  inputs,
  ...
}: {
  # Tree-sitter grammars configuration
  treeSitterGrammars = p: [
    # Core languages
    p.tree-sitter-nix
    p.tree-sitter-vim
    p.tree-sitter-bash
    p.tree-sitter-lua
    p.tree-sitter-c

    # Web technologies
    p.tree-sitter-javascript
    p.tree-sitter-typescript
    p.tree-sitter-tsx
    p.tree-sitter-html
    p.tree-sitter-css
    p.tree-sitter-vue
    p.tree-sitter-svelte
    p.tree-sitter-graphql

    # Data formats
    p.tree-sitter-json
    p.tree-sitter-yaml
    p.tree-sitter-markdown
    p.tree-sitter-markdown-inline

    # Other languages
    p.tree-sitter-python
    p.tree-sitter-prisma
    p.tree-sitter-dockerfile

    # Build systems
    p.tree-sitter-make
    p.tree-sitter-cmake

    # Misc
    p.tree-sitter-gitignore
    p.tree-sitter-query
    p.tree-sitter-vimdoc

    # Custom grammar
    (pkgs.tree-sitter.buildGrammar {
      language = "nginx";
      version = "unstable-2024-10-04";
      src = inputs.tree-sitter-nginx;
    })
  ];
}
