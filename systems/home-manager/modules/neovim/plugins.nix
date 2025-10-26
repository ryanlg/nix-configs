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
    } // import ./configs/telescope.nix;

    # Syntax & Highlights
    nix.enable = true;
  };
}
