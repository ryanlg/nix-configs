{ config, lib, pkgs, ... }:
let
  cfg = config.myHome.fonts.meslo;
in
{
  options.myHome.fonts.meslo.enable = lib.mkEnableOption "Enable Meslo font";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.nerd-fonts.meslo-lg
    ];

    fonts.fontconfig.enable = pkgs.stdenv.isLinux;
  };
}
