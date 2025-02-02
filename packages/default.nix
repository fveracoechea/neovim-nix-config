# Custom packages, that can be defined similarly to ones from nixpkgs
pkgs: let
  nodeEnv = import ./node-env.nix {
    inherit
      (pkgs)
      stdenv
      lib
      python2
      runCommand
      writeTextFile
      writeShellScript
      nodejs
      ;
    inherit pkgs;
    libtool =
      if pkgs.stdenv.hostPlatform.isDarwin
      then pkgs.cctools or pkgs.darwin.cctools
      else null;
  };
in
  {
    # example = pkgs.callPackage ./example { };
  }
  // import ./node-packages.nix {
    inherit
      (pkgs)
      fetchurl
      nix-gitignore
      stdenv
      lib
      fetchgit
      ;
    inherit nodeEnv;
  }
