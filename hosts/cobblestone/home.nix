{
  inputs,
  lib,
  config,
  pkgs,
  outputs,
  ...
}:
{
  imports = [
    ../../home-manager/modules
  ];

  nixpkgs.overlays = outputs.overlays;

  home = {
    username = "ryan";
    homeDirectory = "/home/ryan";
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

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  # Nicely reload system units when changing configs
  # systemd.user.startServices = "sd-switch";

  home.stateVersion = "25.05";
}
