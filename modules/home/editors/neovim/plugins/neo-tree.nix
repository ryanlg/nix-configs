{ ... }:
{
  plugins.neo-tree = {
    enable = true;
    settings = {
      filesystem.use_libuv_file_watcher = true;
      window.mappings = {
        "s" = "vsplit_with_window_picker";
        "S" = "split_with_window_picker";
        "<cr>" = "open_with_window_picker";
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
    # Open Git status in a floating window
    {
      key = "<leader>ng";
      action = "<cmd>Neotree float git_status<cr>";
    }
  ];
}
