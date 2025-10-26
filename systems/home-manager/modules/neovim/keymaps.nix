{ ... }:
{
globals.mapleader = ";";

  keymaps = [
    # =======
    # Editing
    # =======
    {
      # Yank selection to system clipboard
      mode = "v";
      key = "<leader>c";
      action = ''"+y'';
    }
    {
      # Yank line to system clipboard
      mode = "v";
      key = "<leader>cc";
      action = ''"+y'';
    }

    # Quick indentaion
    {
      mode = "v";
      key = "<Tab><Tab>";
      action = ">gv";
    }
    {
      mode = "v";
      key = "<S-Tab>";
      action = "<gv";
    }
    {
      mode = "n";
      key = "<Tab><Tab>";
      action = ">>";
    }
    {
      mode = "n";
      key = "<S-Tab>";
      action = "<<";
    }

    # Move between panes
    {
      mode = "n";
      key = "<C-J>";
      action = "<C-W>j";
    }
    {
      mode = "n";
      key = "<C-K>";
      action = "<C-W>k";
    }
    {
      mode = "n";
      key = "<C-H>";
      action = "<C-W>h";
    }
    {
      mode = "n";
      key = "<C-L>";
      action = "<C-W>l";
    }

    # Move faster
    {
      mode = [ "n" "v" ];
      key = "<S-J>";
      action = "6j";
    }
    {
      # Move faster: 3 lines up
      mode = [ "n" "v" ];
      key = "<S-K>";
      action = "3k";
    }

    {
      # Join lines
      mode = "n";
      key = "<leader>j";
      action = "<Cmd>join<CR>";
    }
    {
      # Join lines (no spaces)
      mode = "n";
      key = "<leader>J";
      action = "<Cmd>join!<CR>";
    }
    {
      # Quick save
      mode = "n";
      key = "<leader>w";
      action = "<Cmd>w<CR>";
    }
    {
      # Quick save & quit
      mode = "n";
      key = "<leader>q";
      action = "<Cmd>wq<CR>";
    }

    # Visual
    {
      # Toggle showing invisible characters
      mode = "n";
      key = "<leader>vi";
      action = "<Cmd>set list!<CR>";
    }
    {
      # Toggle cursorline
      mode = "n";
      key = "<leader>vl";
      action = "<Cmd>set cursorline!<CR>";
    }
    {
      # Clear search highlight
      mode = "n";
      key = "<Space>";
      action = "<Cmd>noh<CR>";
    }
    {
      # Resize splits: wider
      mode = "n";
      key = "<leader>+";
      action = "<Cmd>vertical resize +5<CR>";
    }
    {
      # Resize splits: narrower
      mode = "n";
      key = "<leader>-";
      action = "<Cmd>vertical resize -5<CR>";
    }

    # neo-tree
    {
      key = "<leader>nt";
      action = "<cmd>Neotree toggle<cr>";
    }

    # Telescope
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
