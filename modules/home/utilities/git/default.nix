{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myHome.utilities.git;
  userCfg = config.user;
in
{
  options.myHome.utilities.git = {
    enable = lib.mkEnableOption "git";
    package = lib.mkPackageOption pkgs "git" { };
  };

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;

      ignores = lib.splitString "\n" (builtins.readFile ./globalgitignore);

      settings = {
        user = {
          name = userCfg.username;
          email = userCfg.email;
        };
        core = {
          # Usually only beneficial for large repos, but no harm for
          # smaller ones.
          commitGraph = true;
          fetchCommitGraph = true;
          fsmonitor = true;
        };
      };
    };
  };
}
