{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ../../modules
  ];

  # Set your time zone.
  time.timeZone = "Australia/Melbourne";

  # Add ability to used TouchID for sudo authentication
  security.pam.services.sudo_local.touchIdAuth = true;

  system = {
    stateVersion = 6;
  };
}
