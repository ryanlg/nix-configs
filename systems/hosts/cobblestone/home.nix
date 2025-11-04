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
    homeDirectory = "/home/ryan";
  };

  programs = {
    home-manager.enable = true;
    git.enable = true;
    fzf.enable = true;
    ripgrep.enable = true;
    fd.enable = true;
  };

  # Nicely reload system units when changing configs
  # systemd.user.startServices = "sd-switch";

  home.stateVersion = "25.05";
}
