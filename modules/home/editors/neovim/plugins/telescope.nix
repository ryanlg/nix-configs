{ pkgs, ... }:
{
  plugins.telescope = {
    enable = true;

    extensions = {
      fzf-native.enable = true;
      undo.enable = true;
    };
  };

  keymaps = [
    {
      key = "<leader>ff";
      action = "<cmd>Telescope find_files<CR>";
    }
    {
      key = "<leader>fg";
      action = "<cmd>Telescope live_grep<CR>";
    }
    {
      key = "<leader>fb";
      action = "<cmd>Telescope buffers<CR>";
    }
  ];
}
