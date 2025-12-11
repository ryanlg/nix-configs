{ config, lib, ... }:
let
  cfg = config.mySystem.sys.keyrepeat;
in
{
  options.mySystem.sys.keyrepeat.enable = lib.mkEnableOption "Change key repeat speed";

  # Implementation is split
}