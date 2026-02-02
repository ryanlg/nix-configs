{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.mySystem.shared.programs;
in
{
  options.mySystem.shared.programs.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Enable shared system programs";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      git
      vim
      curl
      wget
    ];
  };
}
