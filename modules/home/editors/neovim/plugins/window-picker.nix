{ lib, ... }:
lib.nixvim.plugins.mkNeovimPlugin {
  name = "window-picker";
  package = "nvim-window-picker";
  description = "This plugins prompts the user to pick a window and returns the window id of the picked window";

  maintainers = [ ];
} // {
  plugins.window-picker = {
    enable = true;

    settings = {
      selection_chars = "ABCDEFGHIJKLMN";

      highlights = {
        enabled = true;
        statusline = {
            focused = {
                fg = "#ededed";
                bg = "#8eb1d4";
                bold = true;
            };
            unfocused = {
                fg = "#ededed";
                bg = "#8eb1d4";
                bold = true;
            };
        };
        winbar = {
            focused = {
                fg = "#ededed";
                bg = "#8eb1d4";
                bold = true;
            };
            unfocused = {
                fg = "#ededed";
                bg = "#8eb1d4";
                bold = true;
            };
        };
      };
    };
  };
}
