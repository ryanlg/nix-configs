{ config, lib, pkgs, ... }:
let
  cfg = config.myHome.utilities.tig;
in
{
  options.myHome.utilities.tig = {
    enable = lib.mkEnableOption "Enable tig";
    package = lib.mkPackageOption pkgs "tig" {};
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];

    xdg.configFile."tig/config".source = ./tigrc;
  };
}
