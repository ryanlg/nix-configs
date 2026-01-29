{ config, lib, ... }:
let
  cfg = config.mySystem.timezone;
in
{
  options.mySystem.timezone = lib.mkOption {
    default = "Australia/Melbourne";
  };

  config = {
    time.timeZone = cfg;
  };
}
