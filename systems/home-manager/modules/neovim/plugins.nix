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
      keymaps = {
        "<leader>ff" = "find_files";
        "<leader>fg" = "live_grep";
        "<leader>fb" = "buffers";
      };
    };

    # Syntax & Highlights
    nix.enable = true;
  };
}
