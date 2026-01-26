{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myHome.virtualizations.docker-cli;
in
{
  options.myHome.virtualizations.docker-cli = {
    enable = lib.mkEnableOption "Enable docker CLI";
    package = lib.mkPackageOption pkgs "docker-client" { };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}
