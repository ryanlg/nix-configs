{ config, lib, ... }:
let
  cfg = config.mySystem.sys.keyrepeat;
in
{
  system = {
    defaults = lib.mkIf cfg.enable {
      NSGlobalDomain = {
        KeyRepeat = 2;
        InitialKeyRepeat = 12;
        ApplePressAndHoldEnabled = false;
      };
    };
  };
}