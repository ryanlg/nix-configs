{ ... }:
{
  plugins.zen-mode = {
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

  keymaps = [
    {
      # Toggle zen-mode
      mode = "n";
      key = "<leader>vg";
      action = "<Cmd>ZenMode<CR>";
    }
  ];
}
