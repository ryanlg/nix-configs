{ config, lib, ... }:
let
  cfg = config.mySystem.virtualization.docker;
in
{
  config = lib.mkIf cfg.enable {
    virtualisation.docker.enable = true;
  };
}
