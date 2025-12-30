{
  # Based on github.com/Misterio77/nix-starter-configs
  description = "My Nix IaC";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = github:nix-darwin/nix-darwin/nix-darwin-25.11;

    # flake-parts - very lightweight flake framework
    # https://flake.parts
    flake-parts.url = "github:hercules-ci/flake-parts";

    # home-manager: manage user homes
    # https://github.com/nix-community/home-manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
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

    # disko: declarative disk partitioning and formatting
    # https://github.com/nix-community/disko
    # disko = {
    #   url = "github:nix-community/disko";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # NUR: Nix User Repository
    # https://github.com/nix-community/NUR
    # nur.url = "github:nix-community/NUR";

    # fzf integration with ZSH
    fzf-zsh = {
      url = "github:unixorn/fzf-zsh-plugin";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
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
          zjstatus = zjstatus.packages.${prev.system}.default;
        })
      ];
    in
    inputs.flake-parts.lib.mkFlake { inherit inputs; } ({ withSystem, ...} :
    {
      inherit systems;

      perSystem =
        { pkgs, system, ... }:
        {
          _module.args.pkgs = import inputs.nixpkgs {
            inherit system overlays;
          };
          formatter = pkgs.nixfmt-rfc-style;
        };

      flake = {
        nixosConfigurations = {
          cobblestone = nixpkgs.lib.nixosSystem {
            specialArgs = {
              inherit inputs;
            };
            modules = [
              ./hosts/cobblestone/configuration.nix
            ];
          };
        };

        darwinConfigurations = {
          rybook = nix-darwin.lib.darwinSystem {
            system = "aarch64-darwin";
            specialArgs = {
              inherit inputs;
              pkgs-unstable = import nixpkgs-unstable {
                system = "aarch64-darwin";
              };
            };
            modules = [
              ./hosts/rybook/configuration.nix
              home-manager.darwinModules.home-manager
              #   home-manager.useGlobalPkgs = true;
              #   home-manager.useUserPackages = true;
              #   # home-manager.extraSpecialArgs = specialArgs;
              #   home-manager.users.ryan {import ./systems/hosts/rybook/home.nix;
              # }
            ];
          };
        };

        homeConfigurations = {
          "ryan@cobblestone" = home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages.aarch64-linux;
            extraSpecialArgs = {inherit inputs;};
            modules = [
              ./hosts/cobblestone/home.nix
            ];
          };
          "ryan@rybook" = withSystem "aarch64-darwin" ({pkgs, system, ...}:
            home-manager.lib.homeManagerConfiguration {
              inherit pkgs;
              extraSpecialArgs = {
                inherit inputs;
                pkgs-unstable = import nixpkgs-unstable {
                  system = "aarch64-darwin";
                };
              };
              modules = [
                ./hosts/rybook/home.nix
              ];
            }
          );
        };
      };
    });
}
