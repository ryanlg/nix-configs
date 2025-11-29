{ config, lib, ... }:
let
  cfg = config.mySystem.sys.keymaps;
in
{
  options.mySystem.sys.keymaps = {
    enable = lib.mkEnableOption "Manage keymaps";

    rightAltAsCtrl = lib.mkOption {
      description = "Use right Alt key as right Ctrl";
      default = true;
    };

    escAsFn = lib.mkOption {
      description = "Use Escape as layer switch";
      default = true;
    };

    capsAsEsc = lib.mkOption {
      description = "Use Casp Lock as Escape";
      default = true;
    };
  };

  config = lib.mkIf cfg.enable {
    # Kanata itself is cross-platform, but whatever needed to start it
    # automatically isn't. In addition, the install script needed on macOS is
    # also different and was only recently fixed as of writing, which means
    # Darwin and Linux need to pull from different pkgs.
    # There is a `services.hardware.kanata` in nixpkgs to bootstrap Kanata, but
    # that's Linux only. For macOS, we'll have to do it ourselves.

    # The implementation is split.
  };
}
