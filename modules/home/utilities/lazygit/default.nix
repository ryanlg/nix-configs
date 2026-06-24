{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myHome.utilities.lazygit;
in
{
  options.myHome.utilities.lazygit = {
    enable = lib.mkEnableOption "Enable lazygit";
    package = lib.mkPackageOption pkgs "lazygit" { };
  };

  config = lib.mkIf cfg.enable {
    programs.lazygit = {
      enable = true;
      package = cfg.package;
      settings.git.log.order = "default";
    };
  };
}
