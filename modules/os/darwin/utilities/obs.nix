{ config, lib, ... }:
let
  cfg = config.mySystem.utilities.obs;
in
{
  options.mySystem.utilities.obs.enable = lib.mkEnableOption "Install OBS through Homebrew";

  config = lib.mkIf cfg.enable {
    homebrew.casks = [ "obs" ];
  };
}
