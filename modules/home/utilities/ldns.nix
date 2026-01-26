{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myHome.utilities.ldns;
in
{
  options.myHome.utilities.ldns = {
    enable = lib.mkEnableOption "Enable ldns";
    package = lib.mkPackageOption pkgs "ldns" { };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}
