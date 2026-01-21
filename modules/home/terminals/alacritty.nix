{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myHome.terminals.alacritty;
in
{
  options.myHome.terminals.alacritty = {
    enable = lib.mkEnableOption "Enable Alacrity";
    package = lib.mkPackageOption pkgs "alacritty" { };
  };

  config = lib.mkIf cfg.enable {
    programs.alacritty = {
      enable = true;
      package = cfg.package;
      theme = "sonokai";
      settings = {
        window = {
          # Title bar, transparent background and no title bar buttons.
          decorations = "None";
          # This makes key combos like alt+b for ncurses movement work
          option_as_alt = "OnlyLeft";
          # The window will be maximized on startup.
          startup_mode = "Maximized";
          padding = {
            x = 3;
            y = 2;
          };
        };
        font = {
          # @todo: make dynamic
          normal.family = "MesloLGM Nerd Font";
          size = 12;
        };
        colors = {
          primary.background = "#191919";
          normal.cyan = "#85b2d6";
        };
        mouse.hide_when_typing = true;
      };
    };
  };
}
