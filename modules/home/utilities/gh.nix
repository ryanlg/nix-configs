{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myHome.utilities.gh;
in
{
  options.myHome.utilities.gh = {
    enable = lib.mkEnableOption "GitHub CLI tool";
    package = lib.mkPackageOption pkgs "gh" { };
  };

  config = lib.mkIf cfg.enable {
    programs.gh.enable = true;
  };
}
