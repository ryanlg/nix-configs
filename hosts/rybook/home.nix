{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/home
  ];

  myHome = {
    fonts.meslo.enable = true;
    shell.zsh.enable = true;
    editors.nvim.enable = true;
  };

  mySystem = {
    sys.keymaps.enable = true;
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

  home.stateVersion = "25.05";
}
