{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  cfg = config.myHome.shell.zsh;
in
{
  options.myHome.shell.zsh.enable = lib.mkEnableOption "Enable Zsh";
  options.myHome.shell.zsh.setDefault = lib.mkOption {
    default = true;
    example = true;
    description = "Make Zsh the default shell for the default user.";
  };

  config = lib.mkIf cfg.enable {
    home.shell.enableZshIntegration = true;

    programs.zsh = {
      enable = true;

      history = {
        append = true;
        # Save timestamps to the history file
        extended = true;
        # Expire duplicates first
        expireDuplicatesFirst = true;
        # Don't display a line previously found in the history file during ctrl+r
        findNoDups = true;
        # Do not put commands into history if it's the same as previous one
        ignoreDups = true;
        # Don't save if first character is space.
        ignoreSpace = true;
        # Save all lines. Save is for on-disk, size is for in-memory.
        save = 1000000000;
        size = 1000000000;
      };

      prezto = {
        enable = true;
        pmodules = [
          # Prereq for many modules, keep at the top
          "environment"
          "terminal"
          "editor"
          "directory"
          "spectrum"
          "utility"
          "completion"
          "git"
          # Provides functions to create, list, and extract archives.
          "archive"
        ];
      };

      shellAliases = {
        ".." = "cd ..";
        "..." = "cd ../..";
        "...." = "cd ../../..";
        "....." = "cd ../../../..";
        "......" = "cd ../../../../..";
        "......." = "cd ../../../../../..";

        # "git branch switch"
        # This overshadows Prezto's git alias for `git show-branch` that "lists branches and their
        # commits with ancestry graphs."
        "gbs" = "git switch";

        # tmux
        "tmuxa" = "tmux new-session -A";
        "tmuxl" = "tmux list-sessions";

        # noglob please
        "nix" = "noglob nix";
        "git" = "noglob git";
        "nixos-rebuild!" = "noglob sudo nixos-rebuild";
        "darwin-rebuild!" = "noglob sudo darwin-rebuild";
        "home-manager" = "noglob home-manager";

        # Default to nvim
        "vim" = "nvim";
      };
    };

    programs.starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        cmd_duration.disabled = true;
        battery.disabled = true;
      };
    };

    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
