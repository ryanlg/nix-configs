{ config, lib, pkgs-unstable, ... }:
let
  cfg = config.myHome.editors.nvim;
in
{
  options.myHome.editors.nvim.enable = lib.mkEnableOption "Enable Neovim";

  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      enable = true;
      vimAlias = true;
      defaultEditor = true;

      imports = [
        ./plugins.nix
        ./keymaps.nix
        ./settings.nix
        ./saving.nix
      ];

      # @upgrade
      # nixpkgs-25.11 has this plugin at 2025-11-19 and git status auto-refresh
      # doesn't work.
      plugins.neo-tree.package = pkgs-unstable.vimPlugins.neo-tree-nvim;
    };
  };
}
