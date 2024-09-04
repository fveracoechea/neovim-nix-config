{
  description = "Neovim cofigurations";

  inputs = {
    # NixOS official package sources
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    import-cost-nvim = {
      url = "github:barrett-ruth/import-cost.nvim";
      flake = false;
    };

    lazydev-nvim = {
      url = "github:folke/lazydev.nvim";
      flake = false;
    };

    lsp-file-operations-nvim = {
      url = "github:antosha417/nvim-lsp-file-operations";
      flake = false;
    };

    tree-sitter-nginx = {
      url = "gitlab:joncoole/tree-sitter-nginx";
      flake = false;
    };
  };

  outputs = {...} @ inputs: {
    homeManagerModules.neovim = {...} @ args: (import ./modules inputs args);
  };
}
