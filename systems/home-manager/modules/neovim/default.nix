{ inputs, ... }:
{
  config = {
    nixvim = inputs.nixvim.legacyPackages.aarch64-linux.makeNixvimWithModule {
        module.imports = [ 
          ./plugins.nix
        ];
    };
  };
}
