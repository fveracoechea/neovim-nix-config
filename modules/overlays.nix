{inputs, ...}: {
  nixpkgs = {
    overlays = [
      (final: prev: {
        vimPlugins =
          prev.vimPlugins
          // {
            import_cost-nvim = prev.vimUtils.buildVimPlugin {
              name = "import_cost-nvim";
              src = inputs.import_cost-nvim;
            };
          };
      })
    ];
  };
}
