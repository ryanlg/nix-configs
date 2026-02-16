{ ... }:
{
  plugins.lsp = {
    enable = true;

    servers = {
      "rust_analyzer" = {
        enable = true;

        # There's no globally installed Rust dev env. Use the one from devShell
        package = null;
        installCargo = false;
        installRustc = false;

        cmd = [ "rust-analyzer" ];
        settings."rust-analyzer".checkOnSave.command = "cargo check";
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>tk";
      action = "<Cmd>lua vim.lsp.buf.hover()<CR>";
    }
    {
      mode = "n";
      key = "<leader>tf";
      action = "<Cmd>lua vim.lsp.buf.format({ async = true })<CR>";
    }
  ];
}
