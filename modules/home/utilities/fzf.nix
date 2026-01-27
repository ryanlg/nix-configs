{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  cfg = config.myHome.utilities.fzf;
in
{
  options.myHome.utilities.fzf = {
    enable = lib.mkEnableOption "Enable Zsh";
    package = lib.mkPackageOption pkgs "fzf" { };
  };

  config = lib.mkIf cfg.enable {
    programs.fzf = {
      enable = true;
      package = cfg.package;
      enableZshIntegration = true;
    };
  };
}
