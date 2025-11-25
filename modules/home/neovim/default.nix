{ config, lib, pkgs, ... }:
let
  cfg = config.myHome.editors.nvim;
in
{
  options.myHome.editors.nvim.enable = lib.mkEnableOption "Enable Neovim";

  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      enable = true;
      vimAlias = true;

      imports = [
        ./plugins.nix
        ./keymaps.nix
        ./settings.nix
      ];
    };
  };
}
