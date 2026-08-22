{ inputs, ... }:
{
  imports = [
    inputs.nix-homebrew.darwinModules.nix-homebrew

    ./sys
    ./utilities
    ./homebrew.nix
  ];
}
