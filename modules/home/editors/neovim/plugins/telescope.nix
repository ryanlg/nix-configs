{ pkgs, ... }:
{
  plugins.telescope = {
    enable = true;

    extensions = {
      fzf-native.enable = true;
      undo.enable = true;
    };
  };
}
