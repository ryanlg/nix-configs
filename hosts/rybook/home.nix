{
  inputs,
  lib,
  config,
  pkgs-unstable,
  ...
}: {
  imports = [
    ../../modules/home
  ];

  myHome = {
    fonts.meslo.enable = true;
    shell.zsh.enable = true;
    editors.nvim.enable = true;
    terminals.alacritty.enable = true;
    multiplexers.zellij.enable = true;
    multiplexers.tmux.enable = true;
    utilities = {
      tig.enable = true;
      lazygit.enable = true;
    };
    browsers.firefox.enable = true;
  };

  home = {
     username = "ryan";
     homeDirectory = "/Users/ryan";
  };

  programs = {
    # Doesn't work with virgl on QEM
    # alacritty = {
    #   enable = true;
    #   theme = "dark_plus";
    # };
  };


  home.stateVersion = "25.11";
}
