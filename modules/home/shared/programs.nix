# Universal tools that all users should have and work out of the box.
{ pkgs, ... }:
{
  # @todo: Need to figure out a good way of separating NixOS and hm installed
  # pacakges to avoid duplicates
  programs = {
    home-manager.enable = true;

    fd.enable = true;
    fzf.enable = true;
    ripgrep.enable = true;
  };
}
