{ pkgs, ... }:
{
  programs.nixvim = {
    enable = true;
    vimAlias = true;

    imports = [
      ./plugins.nix
      ./keymaps.nix
      ./settings.nix
    ];
  };
}
