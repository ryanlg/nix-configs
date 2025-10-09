{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
  ];

  # home = {
  #   username = "your-username";
  #   homeDirectory = "/home/your-username";
  # };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  # Nicely reload system units when changing configs
  # systemd.user.startServices = "sd-switch";

  home.stateVersion = "25.05";
}
