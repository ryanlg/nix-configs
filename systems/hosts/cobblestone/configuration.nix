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
    ../../modules
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
    mesa
    bindfs
  ];

  # Mount the Nix configs shared by the host.
  fileSystems = {
    # Apple Virtualization.
    # "/mnt/nixos" = {
    #   device = "share";
    #   fsType = "virtiofs";
    # };
    # QEMU
    "/mnt/nixos" = {
      device = "share";
      fsType = "9p";
      options = [
        "trans=virtio"
        "version=9p2000.L"
        "debug=0xffff"
        "rw"
        "_netdev"
        "nofail"
        "auto"
      ];
    };
    "/etc/nixos" = {
      device  = "/mnt/nixos";    # bindfs is just a FUSE view of the first mount
      fsType  = "fuse.bindfs";
      depends = [ "/mnt/nixos" ];
      options = [
        "map=501/1000:@20/@100"  # 501/20 is your user account on the host
        "nofail"
        "auto"
      ];
    };
  };

  services.openssh.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 ];

  security.polkit.enable = true;

  # ----------------------
  # Required to enable *any* window server, not just XServer
  services.xserver.enable = true;
  # Config will be provided by home manager
  # programs.sway.enable = true;

  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --user-menu --cmd sway";
      user = "ryan";
    };
  };

  services.spice-vdagentd.enable = true;
  services.qemuGuest.enable = true;
}
