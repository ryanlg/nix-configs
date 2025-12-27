{ pkgs, config, ... }:
{
  programs.zellij.enable = true;

  home.sessionVariables = {
    ZELLIJ_CONFIG_DIR = "${config.xdg.configHome}/zellij";
  };

  xdg.configFile."zellij/config.kdl".source = ./config/config.kdl;
  xdg.configFile."zellij/layouts".source = ./config/layouts;
  xdg.configFile."zellij/plugins/zjstatus.wasm".source = "${pkgs.zjstatus}/bin/zjstatus.wasm";
}
