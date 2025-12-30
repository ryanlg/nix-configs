{ config, lib, pkgs, ...}:
let
  cfg = config.mySystem.sys.keymaps;

  # Relative path starting under /etc to the kanata config file
  kanataConfigRelativePath = "kanata/kanata.kdb";

  # Path to the LaunchDaemon plist for the daemon
  daemonLaunchPlist = "/Library/LaunchDaemons/org.nixos.kanata.plist";
in
{
  # options.mySystem.sys.keymaps = {
  #   enable = lib.mkEnableOption "Manage keymaps";
  #
  #   # rightAltAsCtrl = lib.mkOption {
  #   #   description = "Use right Alt key as right Ctrl";
  #   #   default = true;
  #   # };
  #   #
  #   # escAsFn = lib.mkOption {
  #   #   description = "Use Escape as layer switch";
  #   #   default = true;
  #   # };
  #   #
  #   # capsAsEsc = lib.mkOption {
  #   #   description = "Use Casp Lock as Escape";
  #   #   default = true;
  #   # };
  #   #
  #   # config-path = lib.mkOption {
  #   #   type = lib.tyes.str;
  #   #   default = "${pkgs.kanata}/share/kanata/kanata.kbd";
  #   #   description = "Location of Kanata's config file";
  #   # };
  #
  #   kanata.package = lib.mkPackageOption pkgs "kanata" {};
  # };

  config = lib.mkIf cfg.enable {
    environment = {
      systemPackages = [ cfg.kanata.package ];

      etc."${kanataConfigRelativePath}".text = builtins.readFile ./../../../universal/sys/keymaps/kanata.kdb;
    };

    launchd.daemons.kanata = let 
      exe = lib.meta.getExe cfg.kanata.package;
      conf = "/etc/${kanataConfigRelativePath}";
    in {
      serviceConfig = {
        ProgramArguments = [
          "/bin/sh"
          "-c"
          "/bin/wait4path ${cfg.kanata.package} && sudo ${exe} -c ${conf}"
        ];
        StandardErrorPath = "/tmp/kanata.err.log";
        StandardOutPath = "/tmp/kanata.out";
        RunAtLoad = true;
        KeepAlive = true;
        ProcessType = "Interactive";
      };
    };

    system.activationScripts.postActivation.text = ''
      # Use bootout to kill the running daemon. If it's not already running, bootout will fail so ignore the error.
      set +o pipefail
      launchctl bootout system ${daemonLaunchPlist} > /dev/null 2>&1 || true
      set -o pipefail
      launchctl bootstrap system ${daemonLaunchPlist}
    '';
  };
}
