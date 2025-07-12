{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    # ./disk-config.nix
    ../../_modules
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Australia/Melbourne";

  users.users.ryan = {
    isNormalUser = true;
    initialPassword = "a";
    extraGroups = [ "wheel" ];
    packages = with pkgs; [ ];
  };

  environment.systemPackages = with pkgs; [
    git
    curl
    vim
    htop
    tree
    wget
  ];

  # Mount the Nix configs shared by the host.
  # This assumes macOS host and Apple Virtualization.
  fileSystems = {
    "/mnt/nixos" = {
      device = "share";
      fsType = "virtiofs";
    };
  };


  services.openssh.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 ];
}
