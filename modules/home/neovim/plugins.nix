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
    lualine = {
      enable = true;
      settings = {
        options = {
          component_separators = {
            left = "";
            right = "";
          };
          section_separators = {
            left = "";
            right = "";
          };
        };
      };
    };
    zen-mode = {
      enable = true;
      settings = {
        window = {
          height = 0.85;
          options = {
              # Show invisible characters
              list = true;
              # Do not disable line number column
              number = false;
          };
        };
      };
    };

    # Editor Utilities
    neo-tree.enable = true;
    telescope = {
      enable = true;

      extensions = {
        fzf-native.enable = true;
        undo.enable = true;
      };
    };
    trouble.enable = true;

    # Syntax & Highlights
    nix.enable = true;
  };

  extraPlugins = with pkgs.vimPlugins; [
    zenbones-nvim
  ];
}
