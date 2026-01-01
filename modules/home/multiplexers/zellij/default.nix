{ lib, pkgs, config, ... }:
let
  cfg = config.myHome.multiplexers.zellij;
in
{
  options.myHome.multiplexers.zellij = {
    enable = lib.mkEnableOption "Enable zellij";
    package = lib.mkPackageOption pkgs "zellij" {};
  };

  config = lib.mkIf cfg.enable {
    programs.zellij.enable = true;

    home.sessionVariables = {
      ZELLIJ_CONFIG_DIR = "${config.xdg.configHome}/zellij";
    };

    xdg.configFile."zellij/config.kdl".source = ./config/config.kdl;
    xdg.configFile."zellij/layouts/default.kdl".source = pkgs.replaceVars ./config/layouts/default.kdl {
      ZELLIJ_CONFIG_DIR = "${config.xdg.configHome}/zellij";
    };
    xdg.configFile."zellij/plugins/zjstatus.wasm".source = "${pkgs.zjstatus}/bin/zjstatus.wasm";
  };
}
