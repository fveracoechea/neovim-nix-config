inputs: {...}: {
  imports = [
    ./snippets.nix
    (import ./neovim.nix inputs)
  ];
}
