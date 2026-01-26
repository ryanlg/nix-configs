{
  config,
  home-manager-unstable,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myHome.virtualizations.colima;
in
{
  # @upgrade: services.colima was added after 25.11 home-manager.
  imports = [
    "${home-manager-unstable}/modules/services/colima.nix"
  ];

  options.myHome.virtualizations.colima = {
    enable = lib.mkEnableOption "Enable Colima";
    package = lib.mkPackageOption pkgs "colima" { };
  };

  config = lib.mkIf cfg.enable {
    services.colima = {
      enable = true;
      package = cfg.package;
      profiles = {
        default = {
          isActive = true;
          isService = true;
          settings = {
            cpu = 4;
            disk = 60;
            memory = 4;
            arch = "host";
            runtime = "docker";
            hostname = null;
            kubernetes = {
              enabled = false;
              version = "v1.33.3+k3s1";
              k3sArgs = [ "--disable=traefik" ];
              port = 0;
            };
            autoActivate = true;
            network = {
              address = false;
              mode = "shared";
              interface = "en0";
              preferredRoute = false;
              dns = [ ];
              dnsHosts = {
                "host.docker.internal" = "host.lima.internal";
              };
              hostAddresses = false;
              gatewayAddress = "192.168.5.2";
            };
            forwardAgent = false;
            docker = { };
            vmType = "qemu";
            portForwarder = "ssh";
            rosetta = false;
            binfmt = true;
            nestedVirtualization = false;
            mountType = "sshfs";
            mountInotify = false;
            cpuType = "host";
            provision = [ ];
            sshConfig = true;
            sshPort = 0;
            mounts = [ ];
            diskImage = "";
            rootDisk = 20;
            env = { };
          };
        };
      };
    };
  };
}
