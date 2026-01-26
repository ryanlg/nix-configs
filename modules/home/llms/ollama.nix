{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myHome.llms.ollama;
in
{
  options.myHome.llms.ollama = {
    enable = lib.mkEnableOption "Install ollama";
    package = lib.mkPackageOption pkgs "ollama" { };
  };

  config = lib.mkIf cfg.enable {
    services.ollama = {
      enable = true;
      package = cfg.package;
    };
  };
}
