{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ../../modules/os
  ];

  # Add ability to used TouchID for sudo authentication
  security.pam.services.sudo_local.touchIdAuth = true;

  mySystem = {
    timezone = "Australia/Melbourne";
  };

  system = {
    stateVersion = 6;
  };
}
