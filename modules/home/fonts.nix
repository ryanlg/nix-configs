{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nerd-fonts.meslo-lg
  ];
  fonts.fontconfig.enable = true;
}
