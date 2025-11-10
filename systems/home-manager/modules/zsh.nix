{ inputs, ... }:
{
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

      plugins = [
        {
          name = "fzf-zsh";
          src  = inputs.fzf-zsh;
          file = "fzf-zsh-plugin.plugin.zsh";
        }
      ];
    };

    programs.starship = {
      enable = true;
      enableZshIntegration = true;
      settings.battery.disabled = true;
    };
}
