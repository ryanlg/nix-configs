{
  config,
  lib,
  pkgs-unstable,
  ...
}:
let
  cfg = config.myHome.llms.codex;
in
{
  options.myHome.llms.codex = {
    enable = lib.mkEnableOption "Enable Codex";
    package = lib.mkPackageOption pkgs-unstable "codex" { };
  };

  config = lib.mkIf cfg.enable {
    programs.codex = {
      enable = true;
      package = cfg.package;
    };
  };
}
