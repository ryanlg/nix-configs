{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myHome.editors.obsidian;
in
{
  options.myHome.editors.obsidian = {
    enable = lib.mkEnableOption "Enable Obsidian";
    package = lib.mkPackageOption pkgs "obsidian" { };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}
