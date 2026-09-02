{ config, lib, ... }:
let
  cfg = config.mySystem.utilities.discord;
in
{
  options.mySystem.utilities.discord.enable = lib.mkEnableOption "Install Discord through Homebrew";

  config = lib.mkIf cfg.enable {
    homebrew.casks = [ "discord" ];
  };
}
