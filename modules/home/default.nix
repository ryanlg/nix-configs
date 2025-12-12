{ inputs, ... }:
{
    imports = [
      inputs.nixvim.homeManagerModules.nixvim

      ./shared
      ./shells
      ./editors
      ./fonts
      ./terminals
    ];
}
