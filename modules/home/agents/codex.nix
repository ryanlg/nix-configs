{
  config,
  lib,
  pkgs-unstable,
  ...
}:
let
  cfg = config.myHome.agents.codex;
in
{
  options.myHome.agents.codex = {
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
