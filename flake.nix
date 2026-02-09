{
  # Based on github.com/Misterio77/nix-starter-configs
  description = "My Nix IaC";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-25.11-darwin";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-25.11";

    # flake-parts - very lightweight flake framework
    # https://flake.parts
    flake-parts.url = "github:hercules-ci/flake-parts";

    # home-manager: manage user homes
    # https://github.com/nix-community/home-manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager-unstable = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nixvim - Neovim distribution built around Nix modules
    # https://github.com/nix-community/nixvim
    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # zjstatus - Status bar for Zellij
    # https://github.com/dj95/zjstatus
    zjstatus = {
      url = "github:dj95/zjstatus";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      home-manager-unstable,
      disko,
      nix-darwin,
      zjstatus,
      ...
    }@inputs:
    let
      linuxSystems = [ "aarch64-linux" ];
      darwinSystems = [ "aarch64-darwin" ];
      systems = linuxSystems ++ darwinSystems;

      overlays = [
        (final: prev: {
          zjstatus = zjstatus.packages.${prev.stdenv.hostPlatform.system}.default;
        })
        # @upgrade: this is needed for inetutils to build on darwin, which is a dependency
        # fontconfig, which is built by default.
        (import ./overlays/inetutils)
      ];

      # Allow these unfree packages to be installed
      unfreePackages = [
        "1password"
      ];
    in
    inputs.flake-parts.lib.mkFlake { inherit inputs; } (
      { withSystem, ... }:
      let
        flakeLib = import ./lib.nix {
          lib = nixpkgs.lib;
          inherit
            inputs
            withSystem
            nixpkgs
            nix-darwin
            home-manager
            home-manager-unstable
            ;
        };
      in
      {
        inherit systems;

        perSystem =
          { pkgs, system, ... }:
          let
            nixpkgsArgs = {
              inherit system overlays;
              config.allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) unfreePackages;
            };
            mkPkgs = src: import src nixpkgsArgs;
          in
          {
            _module.args = {
              pkgs = mkPkgs inputs.nixpkgs;
              pkgs-darwin = mkPkgs inputs.nixpkgs-darwin;
              pkgs-unstable = mkPkgs inputs.nixpkgs-unstable;
            };
            formatter = pkgs.nixfmt-tree;
          };

        flake = {
          darwinConfigurations = {
            rybook = flakeLib.mkSystem {
              hostname = "rybook";
              system = "aarch64-darwin";
            };
          };

          homeConfigurations = {
            "ryan@rybook" = flakeLib.mkHome {
              hostname = "rybook";
              system = "aarch64-darwin";
            };
          };
        };
      }
    );
}
