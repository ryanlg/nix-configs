{ pkgs, ... }:
{
  extraPlugins = with pkgs.vimPlugins; [
    zenbones-nvim
  ];
}