{
  config,
  lib,
  pkgs-unstable,
  ...
}:
let
  cfg = config.myHome.editors.nvim;
in
{
  options.myHome.editors.nvim.enable = lib.mkEnableOption "Enable Neovim";

  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      enable = true;
      vimAlias = true;
      # This doesn't seem to work... $VISUAL is stuck at the default.
      defaultEditor = true;

      imports = [
        ./plugins.nix
        ./keymaps.nix
        ./settings.nix
        ./saving.nix
      ];
    };
  };
}
