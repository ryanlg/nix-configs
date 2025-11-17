{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../home-manager/modules
  ];

  home = {
     username = "ryan";
     homeDirectory = "/Users/ryan";
  };

  programs = {
    home-manager.enable = true;
    git.enable = true;
    fzf.enable = true;
    ripgrep.enable = true;
    fd.enable = true;

    # Doesn't work with virgl on QEM
    # alacritty = {
    #   enable = true;
    #   theme = "dark_plus";
    # };
  };

  home.stateVersion = "25.05";
}
