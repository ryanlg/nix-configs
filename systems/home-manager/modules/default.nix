{ inputs, ... }:
{
    imports = [
      inputs.nixvim.homeManagerModules.nixvim
      ./neovim
    ];
}
