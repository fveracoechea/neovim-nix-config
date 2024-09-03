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
      (final: prev: {
        vimPlugins =
          prev.vimPlugins
          // {
            lazydev-nvim = prev.vimUtils.buildVimPlugin {
              name = "lazydev-nvim";
              src = inputs.lazydev-nvim;
            };
          };
      })
      (final: prev: {
        vimPlugins =
          prev.vimPlugins
          // {
            lsp-file-operations-nvim = prev.vimUtils.buildVimPlugin {
              name = "lsp-file-operations-nvim";
              src = inputs.lsp-file-operations-nvim;
            };
          };
      })
    ];
  };
}
