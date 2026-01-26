{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myHome.utilities.just;
in
{
  options.myHome.utilities.just = {
    enable = lib.mkEnableOption "Enable just";
    package = lib.mkPackageOption pkgs "just" { };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}
