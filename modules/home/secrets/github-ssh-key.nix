{
  config,
  lib,
  ...
}:
let
  cfg = config.myHome.secrets.github-ssh-key;
in
{
  options.myHome.secrets.github-ssh-key.enable =
    lib.mkEnableOption "Decrypt and use the GitHub SSH key";

  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = config.myHome.secrets.enable;
        message = "myHome.secrets.github-ssh-key requires myHome.secrets.enable.";
      }
    ];

    myHome.utilities.ssh.enable = true;

    sops.secrets.github-ssh-key = {
      sopsFile = ../../../secrets/shared/github-ssh-key;
      format = "binary";
      mode = "0400";
    };

    programs.ssh.settings."github.com" = lib.hm.dag.entryBefore [ "*" ] {
      HostName = "github.com";
      User = "git";
      IdentityFile = config.sops.secrets.github-ssh-key.path;
      IdentitiesOnly = true;
      UseKeychain = true;
    };
  };
}
