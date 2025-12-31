{ lib, ... }:
lib.nixvim.plugins.mkNeovimPlugin {
  name = "window-picker";
  package = "nvim-window-picker";
  description = "This plugins prompts the user to pick a window and returns the window id of the picked window";

  maintainers = [ ];
} // {
  plugins.window-picker.enable = true;
}
