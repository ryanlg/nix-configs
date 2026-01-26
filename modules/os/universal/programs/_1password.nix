{
  config,
  lib,
  pkgs-unstable,
  ...
}:
let
  cfg = config.mySystem.programs._1password;
in
{
  options.mySystem.programs._1password = {
    enable = lib.mkEnableOption "Install 1Password GUI";
    package = lib.mkPackageOption pkgs-unstable "_1password-gui" { };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      cfg.package
    ];
  };
}
