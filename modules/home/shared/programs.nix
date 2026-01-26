# Universal tools that all users should have and work out of the box.
{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myHome.shared.programs;
in
{
  options.myHome.shared.programs = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable shared programs";
    };
    minimal = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Install only the minimal shared programs set";
    };
    core = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable core tool replacements";
      };
    };
    essentials = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable essential CLI tools";
      };
    };
    networking = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable networking tools";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    programs.home-manager.enable = true;

    home.packages =
      if cfg.minimal then
        [
          pkgs.jq
          pkgs.fd
          pkgs.ripgrep
        ]
      else
        lib.optionals cfg.core.enable (
          with pkgs;
          [
            bat
            btop
            fd
            gdu
            ripgrep
          ]
        )
        ++ lib.optionals cfg.essentials.enable (
          with pkgs;
          [
            fzf
            jq
          ]
        )
        ++ lib.optionals cfg.networking.enable (
          with pkgs;
          [
            ldns
            gping
            xh
            trippy
          ]
        );
  };
}
