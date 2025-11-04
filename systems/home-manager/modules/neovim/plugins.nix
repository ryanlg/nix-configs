{ pkgs, ... }:
{
  # Add packages to PATH
  extraPackages = with pkgs; [
    fd
    fzf
    ripgrep
    git
    gzip
    shellcheck
  ];

  plugins = {
    # Visual
    web-devicons.enable = true;

    # Editor Utilities
    neo-tree.enable = true;
    telescope = {
      enable = true;

      extensions = {
        fzf-native.enable = true;
        undo.enable = true;
      };
    };

    # Syntax & Highlights
    nix.enable = true;
  };
}
