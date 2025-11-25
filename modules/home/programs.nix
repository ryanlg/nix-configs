{ config, lib, pkgs, ... }:
let
  cfg = config.myHome.programs.misc;
in
{
  options.myHome.programs.misc.enable = lib.mkEnableOption "Install universal tools";

  config = lib.mkIf cfg.enable {
    /* Need to figure out a good way of separating NixOS and hm installed pacakges to avoid duplicates */
    programs = {
      git.enable = true;
      fzf.enable = true;
      ripgrep.enable = true;
      fd.enable = true;
    };
  };
}
