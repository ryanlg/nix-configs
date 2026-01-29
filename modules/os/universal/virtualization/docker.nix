{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.mySystem.virtualization.docker;
in
{
  options.mySystem.virtualization.docker = {
    enable = lib.mkEnableOption "Docker engine";
  };

  config = {
    assertions = [
      {
        assertion = !(cfg.enable && pkgs.stdenv.isDarwin);
        message = ''
          mySystem.virtualization.docker is not supported on macOS. Use myHome.virtualizations.colima instead.
        '';
      }
    ];
  };
}
