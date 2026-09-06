{ inputs, ... }:
{
  imports = [
    inputs.nixvim.homeModules.nixvim
    ./shared
    ./secrets
    ./shells
    ./editors
    ./fonts
    ./terminals
    ./multiplexers
    ./utilities
    ./browsers
    ./llms
    ./virtualizations
  ];
}
