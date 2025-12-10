{
  config,
  lib,
  pkgs-unstable,
  ...
}:

{
  imports = [
    ../../modules/os/shared
    ../../modules/os/universal
    ../../modules/os/darwin
  ];

  # Add ability to used TouchID for sudo authentication
  security.pam.services.sudo_local.touchIdAuth = true;

  mySystem = {
    timezone = "Australia/Melbourne";
    sys.keymaps = {
      enable = true;
      kanata.package = pkgs-unstable.kanata;
      karabiner-dk.package = pkgs-unstable.karabiner-dk;
    };
  };

  system = {
    stateVersion = 6;
    primaryUser = "ryan";
  };
}
