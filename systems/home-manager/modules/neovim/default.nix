{ pkgs, ... }:
{
  programs.nixvim = {
    enable = true;

    imports = [
      ./plugins.nix
      ./keymaps.nix
      ./settings.nix
    ];
  };
}
