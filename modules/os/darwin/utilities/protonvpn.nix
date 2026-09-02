{ config, lib, ... }:
let
  cfg = config.mySystem.utilities.protonvpn;
in
{
  options.mySystem.utilities.protonvpn.enable =
    lib.mkEnableOption "Install Proton VPN through Homebrew";

  config = lib.mkIf cfg.enable {
    homebrew.casks = [ "protonvpn" ];
  };
}
