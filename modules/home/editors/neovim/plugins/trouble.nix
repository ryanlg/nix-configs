{ pkgs, ... }:
{
  plugins.trouble.enable = true;

  keymaps = [
    {
      mode = "n";
      key = "<leader>xx";
      action = "<cmd>Trouble diagnostics toggle filter.buf=0<cr>";
    }
  ];
}
