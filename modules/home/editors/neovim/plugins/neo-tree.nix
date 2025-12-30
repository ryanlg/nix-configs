{ pkgs, ... }:
{
  # @todo: some improvements for neo-tree
  # https://github.com/nvim-neo-tree/neo-tree.nvim/wiki/Recipes
  # - Custom Window Chooser
  plugins.neo-tree = {
    enable = true;
    settings = {
      filesystem = {
        use_lib_uv_file_watcher = true;
      };
    };
  };

  # neo-tree
  keymaps = [
    {
      key = "<leader>nt";
      action = "<cmd>Neotree toggle<cr>";
    }
  ];
}
