{
  nixpkgs,
  nix-darwin,
  home-manager,
  home-manager-unstable,
  config ? { },
  lib,
  withSystem,
  inputs,
  ...
}:
let
  mkUser =
    {
      username,
      homename,
      homedir,
      email,
    }:
    {
      options.user = {
        username = lib.mkOption {
          type = lib.types.str;
          description = "User's preferred name";
          example = "Ryan Liang";
        };
        homename = lib.mkOption {
          type = lib.types.str;
          description = "User's home name";
          example = "ryan";
        };
        homedir = lib.mkOption {
          type = lib.types.str;
          description = "User's home directory path";
          example = "/home/ryan";
        };
        email = lib.mkOption {
          type = lib.types.str;
          description = "User's email";
          example = "ryan@ryanl.io";
        };
      };
      config.user = {
        username = lib.mkDefault username;
        homename = lib.mkDefault homename;
        homedir = lib.mkDefault homedir;
        email = lib.mkDefault email;
      };
    };
in
{
  mkSystem =
    {
      hostname,
      system,
      username ? "Ryan Liang",
      homename ? "ryan",
      email ? "ryan@ryanl.io",
      homebase ? (if lib.strings.hasInfix "darwin" system then "/Users" else "/home"),
      extraModules ? [ ],
    }:
    withSystem system (
      {
        pkgs,
        pkgs-darwin,
        pkgs-unstable,
        system,
        ...
      }:
      let
        isDarwin = lib.strings.hasInfix "darwin" system;
        pkgsForHome = if isDarwin then pkgs-darwin else pkgs;
        homedir = "${homebase}/${homename}";
        mkConfiguration = if isDarwin then nix-darwin.lib.darwinSystem else nixpkgs.lib.nixosSystem;
      in
      mkConfiguration {
        inherit system;
        pkgs = pkgsForHome;
        specialArgs = {
          inherit inputs pkgs-unstable;
        };
        modules = [
          # All users get all modules
          # Gate the split implementation by the system string
          ./modules/os/universal
          (if isDarwin then ./modules/os/darwin else ./modules/os/nixos)

          ./hosts/${hostname}/configuration.nix

          # Only nix-darwin needs this
          (if isDarwin then { system.primaryUser = homename; } else { })

          (mkUser {
            inherit
              username
              homename
              homedir
              email
              ;
          })
        ]
        ++ extraModules;
      }
    );

  mkHome =
    {
      hostname,
      system,
      username ? "Ryan Liang",
      homename ? "ryan",
      email ? "ryan@ryanl.io",
      homebase ? (if lib.strings.hasInfix "darwin" system then "/Users" else "/home"),
      extraModules ? [ ],
    }:
    withSystem system (
      {
        pkgs,
        pkgs-darwin,
        pkgs-unstable,
        ...
      }:
      let
        isDarwin = lib.strings.hasInfix "darwin" system;
        pkgsForHome = if isDarwin then pkgs-darwin else pkgs;
        homedir = "${homebase}/${homename}";
      in
      home-manager.lib.homeManagerConfiguration {
        pkgs = pkgsForHome;
        extraSpecialArgs = {
          inherit inputs pkgs-unstable;
          home-manager-unstable = home-manager-unstable;
        };
        modules = [
          # All users get all modules
          ./modules/home

          ./hosts/${hostname}/home.nix

          {
            home = {
              username = homename;
              homeDirectory = homedir;
            };
          }
          (mkUser {
            inherit
              username
              homename
              homedir
              email
              ;
          })
        ]
        ++ extraModules;
      }
    );
}
