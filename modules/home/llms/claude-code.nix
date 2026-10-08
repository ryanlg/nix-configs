{
  config,
  lib,
  pkgs-unstable,
  ...
}:
let
  cfg = config.myHome.llms.claude-code;
in
{
  options.myHome.llms.claude-code = {
    enable = lib.mkEnableOption "Enable Claude Code";
    package = lib.mkPackageOption pkgs-unstable "claude-code" { };
  };

  config = lib.mkIf cfg.enable {
    programs.claude-code = {
      enable = true;
      package = cfg.package;
    };
  };
}
