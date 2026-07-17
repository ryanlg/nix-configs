{ config, lib, ... }:
let
  cfg = config.mySystem.sys.dock;
in
{
  config = lib.mkIf cfg.enable {
    system = {
      defaults = {
        dock = {
          # Automatically hide and show the dock
          autohide = true;
        }
      }
    }
  }
}
