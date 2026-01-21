{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.mySystem.sys.keymaps;
in
{
  options.mySystem.sys.keymaps = {
    enable = lib.mkEnableOption "Manage keymaps";

    karabiner-dk.package = lib.mkPackageOption pkgs "karabiner-dk" {
      extraDescription = "This option is only used by Darwin systems.";
    };

    kanata.package = lib.mkPackageOption pkgs "kanata" { };
  };

  config = lib.mkIf cfg.enable {
    # Kanata itself is cross-platform, but whatever needed to start it
    # automatically isn't. In addition, the install script needed on macOS is
    # also different and was only recently fixed as of writing, which means
    # Darwin and Linux need to pull from different pkgs.
    # There is a `services.hardware.kanata` in nixpkgs to bootstrap Kanata, but
    # that's Linux only. For macOS, we'll have to do it ourselves.

    environment.systemPackages = [
      cfg.karabiner-dk.package
    ];

    # The rest of the implementation is split.
  };
}
