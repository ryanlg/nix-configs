{ inputs, ... }:
{
  nix = {
    # make `nix run` and `nix shell` use the same nixpkgs as the one used by this flake
    # for example, to run `talosctl` from the `unstable` branch, we can run `nix shell unstable#talosctl`
    registry = {
      stable.flake = inputs.nixpkgs;
      unstable.flake = inputs.nixpkgs-unstable;
    };
    channel.enable = false; # remove nix-channel related tools & configs, we use flakes instead

    settings = {
      # NIX_PATH is still used by many useful tools, so we set it to the same value as the one used by this flake
      # make `nix repl '<nixpkgs>'` use the same nixpkgs as the one used by this flake
      nix-path = "nixpkgs=${inputs.nixpkgs.outPath}";

      experimental-features = [
        "nix-command"
        "flakes"
      ];

      # Automatically detect files in the store that have identical contents on a timer
      # `nix.settings.auto-optimise-store` is known to corrupt the Nix Store, please
      # use `nix.optimise.automatic` instead.
      nix.optimise.automatic = true;

      # Garbage collector will keep the outputs of non-garbage derivations
      keep-outputs = true;
      # Prevent garbage collector from keeping the derivations from which non-garbage store paths were built.
      keep-derivations = false;
    };
  };
}
