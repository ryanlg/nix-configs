{ config, lib, pkgs-unstable, ... }:
let
  cfg = config.mySystem.sys.keymaps;
in
{
  imports = [
    ./karabiner-dk.nix
    ./kanata.nix
  ];

  config = lib.mkIf cfg.enable {
    services.karabiner-dk = {
      enable = true;
      package = cfg.karabiner-dk.package;
    };
  };
}
