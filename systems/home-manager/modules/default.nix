{ inputs, ... }:
{
    imports = [
      inputs.nixvim.nixosModules.nixvim
      ./neovim
    ];
}
