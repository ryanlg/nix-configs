{ pkgs, ... }:
{
  imports = [
    ./plugins/web-devicons.nix
    ./plugins/lualine.nix
    ./plugins/zen-mode.nix
    ./plugins/neo-tree.nix
    ./plugins/telescope.nix
    ./plugins/trouble.nix
    ./plugins/nix.nix
    ./plugins/zenbones.nix
    ./plugins/window-picker.nix
  ];

  # Add packages to PATH
  extraPackages = with pkgs; [
    fd
    fzf
    ripgrep
    git
    gzip
    shellcheck
  ];
}
