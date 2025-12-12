{ config, lib, pkgs, ... }:
let
  cfg = config.myHome.terminals.alacritty;
in
{
  options.myHome.terminals.alacritty = {
    enable = lib.mkEnableOption "Enable Alacrity";
    package = lib.mkPackageOption pkgs "alacritty" {};
  };

  config = lib.mkIf cfg.enable {
    programs.alacritty = {
      enable = true;
      package = cfg.package;
      theme = "rose_pine";
    };
  };
}
