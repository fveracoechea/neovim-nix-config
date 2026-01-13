inputs: {pkgs, ...}: {
  imports = [
    ./snippets.nix
    (import ./neovim.nix inputs)
  ];

  home.packages = with pkgs; [
    lazygit
    gh
    fzf
    graphql-language-service-cli
    tree-sitter
  ];
}
