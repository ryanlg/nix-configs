{
  inputs,
  lib,
  config,
  pkgs-unstable,
  ...
}:
{
  myHome = {
    fonts.meslo.enable = true;
    shell.zsh.enable = true;
    editors.nvim.enable = true;
    terminals.alacritty.enable = true;
    multiplexers.zellij.enable = true;
    multiplexers.tmux.enable = true;
    utilities = {
      tig.enable = true;
      lazygit.enable = true;
      uv.enable = true;
      just.enable = true;
      fzf.enable = true;
      direnv.enable = true;
      git.enable = true;
    };
    browsers.firefox.enable = true;
    llms = {
      codex.enable = true;
      ollama.enable = true;
    };
    virtualizations = {
      colima.enable = true;
      docker-cli.enable = true;
    };
  };

  home.stateVersion = "25.11";
}
