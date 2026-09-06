{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myHome.secrets;
in
{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
    ./github-ssh-key.nix
  ];

  options.myHome.secrets = {
    enable = lib.mkEnableOption "Manage secrets with sops-nix";
    ageKeyFile = lib.mkOption {
      type = lib.types.str;
      default = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
      description = "Age identity file used to decrypt secrets";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      age
      sops
    ];

    sops.age = {
      keyFile = cfg.ageKeyFile;
      generateKey = false;
    };
  };
}
