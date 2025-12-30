{ inputs, ... }:
{
    imports = [
      inputs.nixvim.homeModules.nixvim
      ./shared
      ./shells
      ./editors
      ./fonts
      ./terminals
      ./multiplexers
      ./utilities
    ];
}
