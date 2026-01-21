{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.myHome.multiplexers.tmux;
in
{
  options.myHome.multiplexers.tmux = {
    enable = lib.mkEnableOption "Enable tmux";
    package = lib.mkPackageOption pkgs "tmux" { };
  };

  config = lib.mkIf cfg.enable {
    programs.tmux = {
      enable = true;

      # Run the sensible plugin at the top of the configuration
      sensibleOnTop = true;

      # $TERM
      terminal = "tmux-256color";

      # Prefix key
      prefix = "C-a";
      # Base index for windows and panes
      baseIndex = 1;
      # Use 24 hour clock
      clock24 = true;
      # VI style shortcuts
      keyMode = "vi";
      # Enable mouse support
      mouse = true;
      # Override the hjkl and HJKL bindings for pane navigation and resizing in VI mode
      customPaneNavigationAndResize = true;
      # Maximum number of lines held in window history
      historyLimit = 1000000;
      # Request focus events and pass them through to applications running in tmux
      focusEvents = true;
      # Resize the window to the size of the smallest session for which it is
      # the current window.
      aggressiveResize = true;
      # Time in milliseconds for which tmux waits after an escape is input.
      escapeTime = 0;

      extraConfig = ''
        # Tell tmux we support RGB colors
        set -as terminal-features ",gnome*:RDB"

        # Automatically renumber windows
        set -g renumber-windows on

        # Passthrough prefix to the underlying program
        bind C-a send-prefix

        # Hit prefix + Esc to enter copy mode
        bind Escape copy-mode
        # Press v to start selection
        bind -Tcopy-mode-vi 'v' send -X begin-selection
        # Press y to yank selection and keep the selection
        bind -Tcopy-mode-vi 'y' send -X copy-selection

        # Use | and - to create panes, the defaults are weird
        bind | split-window -h
        bind - split-window -v

        # Synchronize all panes in a window
        bind y setw synchronize-panes

        # Don't exit copy mode after mouse release
        bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-selection

        source ${config.home.homeDirectory}/${config.xdg.configFile."tmux/status.sh".target}
      '';
    };

    xdg.configFile."tmux/status.sh".source = ./status.sh;
  };
}
