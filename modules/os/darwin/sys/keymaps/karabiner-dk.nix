# This is needed for Kanata as it depends on Karabiner's
# driver to act as a virtual keyboard.
# This config is an amalgmation of
# - https://github.com/auscyber/dotfiles/blob/21f73a/modules/darwin/keybinds/karabiner_driver/default.nix
# - https://github.com/nix-darwin/nix-darwin/pull/1595
# because the nix-darwin upstream for this driver does not work as of writing.
{ config, lib, pkgs, ... }:
let
  cfg = config.services.karabiner-dk;

  parentAppDir = "/Applications/.karabiner";
in
{
  options.services.karabiner-dk = {
    enable = lib.mkEnableOption "Karabiner-DK";
    package = lib.mkPackageOption pkgs "karabiner-dk" { };
  };
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      cfg.package
    ];

    launchd.daemons.Karabiner-DriverKit-VirtualHIDDevice-Daemon = {
      serviceConfig = {
        ProgramArguments = [
          "${cfg.package}/Library/Application Support/org.pqrs/Karabiner-DriverKit-VirtualHIDDevice/Applications/Karabiner-VirtualHIDDevice-Daemon.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Daemon"
        ];
        ProcessType = "Interactive";
        Label = "org.pqrs.Karabiner-DriverKit-VirtualHIDDevice-Daemon";
        RunAtLoad = true;
        KeepAlive = true;
        StandardOutPath = "/var/log/karabiner-vhidd.log";
        StandardErrorPath = "/var/log/karabiner-vhidd.err.log";
      };
    };
    launchd.daemons.start-karabiner-dk = {
      script = ''
        spctl -a -vvv -t install "${parentAppDir}/.Karabiner-VirtualHIDDevice-Manager.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Manager"
        "${parentAppDir}/.Karabiner-VirtualHIDDevice-Manager.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Manager" activate
      '';
      serviceConfig = {
        Label = "org.nixos.start-karabiner-dk";
        RunAtLoad = true;
        StandardOutPath = "/var/log/karabiner-vhidm.log";
        StandardErrorPath = "/var/log/karabiner-vhidm.err.log";
      };
    };

    system.activationScripts.preActivation.text = ''
      mkdir -p ${parentAppDir}
      # Kernel extensions must reside inside of /Applications, they cannot be symlinks
      cp -R ${cfg.package}/Applications/.Karabiner-VirtualHIDDevice-Manager.app ${parentAppDir}
    '';
    system.activationScripts.postActivation.text = ''
      launchctl kickstart -k system/org.pqrs.Karabiner-DriverKit-VirtualHIDDevice-Daemon
      launchctl kickstart -k system/org.nixos.start-karabiner-dk
    '';
  };
}

