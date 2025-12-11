{ config, lib, ... }:
let
  cfg = config.mySystem.sys.keyrepeat;
in
{
  config = lib.mkIf cfg.enable {
    system = {
      defaults = {
        NSGlobalDomain = {
          KeyRepeat = 2;
          InitialKeyRepeat = 12;
          ApplePressAndHoldEnabled = false;
        };
      };
    };
  };
}
