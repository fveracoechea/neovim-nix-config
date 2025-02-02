# Custom packages, that can be defined similarly to ones from nixpkgs
pkgs: let
  nodeEnv = import ../node-env.nix pkgs;
in
  {
    # example = pkgs.callPackage ./example { };
  }
  // (pkgs.callPackage ./node-packages.nix {inherit nodeEnv;})
