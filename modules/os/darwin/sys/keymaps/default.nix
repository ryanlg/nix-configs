{ config, lib, pkgs-unstable, ... }:
let
  cfg = config.mySystem.sys.keymaps;
in
{
  imports = [
    ./karabiner-dk.nix
  ];

  config = lib.mkIf cfg.enable {
    services.karabiner-dk = {
      enable = true;
      package = pkgs-unstable.karabiner-dk;
    };

    # There is a fix for building Kanata in nixpkgs that has not gone into
    # stable as time of writing.
    environment.systemPackages = [
      pkgs-unstable.kanata
    ];
  };
}
