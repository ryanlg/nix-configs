{ ... }:
{
  # @todo: some improvements for neo-tree
  # https://github.com/nvim-neo-tree/neo-tree.nvim/wiki/Recipes
  # - Custom Window Chooser
  plugins.neo-tree = {
    enable = true;
    settings = {
      filesystem = {
        use_libuv_file_watcher = true;
      };
    };
  };

  keymaps = [
    {
      key = "<leader>nt";
      action = "<cmd>Neotree toggle<cr>";
    }
    # Open tree to current file
    {
      key = "<leader>nr";
      action = "<cmd>Neotree reveal<cr>";
    }
  ];
}
