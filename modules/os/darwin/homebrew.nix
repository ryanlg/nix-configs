{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.mySystem.homebrew;
in
{
  options.mySystem.homebrew.enable = lib.mkEnableOption "Install and manage Homebrew";

  config = lib.mkIf cfg.enable {
    nix-homebrew = {
      enable = true;
      user = config.user.homename;

      taps = {
        "homebrew/homebrew-core" = inputs.homebrew-core;
        "homebrew/homebrew-cask" = inputs.homebrew-cask;
      };

      enableRosetta = false;
      mutableTaps = false;
    };

    # Keep nix-darwin's Homebrew tap list aligned with nix-homebrew.
    homebrew = {
      enable = true;
      taps = builtins.attrNames config.nix-homebrew.taps;

      enableZshIntegration = true;
    };
  };
}
