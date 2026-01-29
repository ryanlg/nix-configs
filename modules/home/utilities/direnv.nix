{
  config,
  lib,
  ...
}:
let
  cfg = config.myHome.utilities.direnv;
in
{
  options.myHome.utilities.direnv = {
    enable = lib.mkEnableOption "Enable direnv";
  };

  config = lib.mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };
}
