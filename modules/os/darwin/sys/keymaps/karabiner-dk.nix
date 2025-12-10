# This is needed for Kanata as it depends on Karabiner's driver to act as a virtual keyboard.
# This config is an amalgmation of
# - https://github.com/auscyber/dotfiles/blob/21f73a/modules/darwin/keybinds/karabiner_driver/default.nix
# - https://github.com/nix-darwin/nix-darwin/pull/1595
# plus some personal touch, because the nix-darwin upstream for this driver does not work as of writing.
{ config, lib, pkgs, pkgs-unstable, ... }:
let
  cfg = config.services.karabiner-dk;

  # Kernel extensions must reside under /Applications and cannot be symlinks
  parentAppDir = "/Applications/.karabiner";
  # Relative path to the daemon binary in the package
  daemonRelative = "Library/Application\\ Support/org.pqrs/Karabiner-DriverKit-VirtualHIDDevice/Applications/Karabiner-VirtualHIDDevice-Daemon.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Daemon";
  # Path to the LaunchDaemon plist for the daemon
  daemonLaunchPlist = "/Library/LaunchDaemons/org.pqrs.Karabiner-DriverKit-VirtualHIDDevice-Daemon.plist";
in
{
  options.services.karabiner-dk = {
    enable = lib.mkEnableOption "karabiner-dk";
    package = lib.mkPackageOption pkgs "karabiner-dk" { };
  };
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
    launchd.daemons.Karabiner-DriverKit-VirtualHIDDevice-Daemon = {
      serviceConfig = {
        # We need to wait for the nix store to mount during boot up.
        ProgramArguments = [
          "/bin/sh"
          "-c"
          "/bin/wait4path ${cfg.package} && ${cfg.package}/${daemonRelative}"
        ];
        ProcessType = "Interactive";
        Label = "org.pqrs.Karabiner-DriverKit-VirtualHIDDevice-Daemon";
        RunAtLoad = true;
        KeepAlive = true;
        # Note: Kaarabiner is also hardcoded to log to /var/log/karabiner/virtual_hid_device_service.log.
        StandardOutPath = "/tmp/karabiner-vhidd.log";
        StandardErrorPath = "/tmp/karabiner-vhidd.err.log";
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
        StandardOutPath = "/tmp/karabiner-vhidm.log";
        StandardErrorPath = "/tmp/karabiner-vhidm.err.log";
      };
    };

    system.activationScripts.preActivation.text = ''
      rm -rf ${parentAppDir}
      mkdir -p ${parentAppDir}
      cp -R ${cfg.package}/Applications/.Karabiner-VirtualHIDDevice-Manager.app ${parentAppDir}
    '';
    system.activationScripts.postActivation.text = ''
      # Use bootout to kill the running daemon. If it's not already running, bootout will fail so ignore the error.
      set +o pipefail
      launchctl bootout system ${daemonLaunchPlist} > /dev/null 2>&1 || true
      set -o pipefail
      launchctl bootstrap system ${daemonLaunchPlist}
    '';
  };
}
