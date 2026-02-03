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
      username ? "Ryan Liang",
      homename ? "ryan",
      email ? "ryan@ryanl.io",
      homebase ? (if lib.strings.hasInfix "darwin" system then "/Users" else "/home"),
      system,
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
          ./hosts/${hostname}/configuration.nix
          {
            system.primaryUser = homename;
          }
          (mkUser {
            inherit
              username
              homename
              homedir
              email
              ;
          })
        ];
      }
    );

  mkHome =
    {
      hostname,
      username ? "Ryan Liang",
      homename ? "ryan",
      email ? "ryan@ryanl.io",
      homebase ? (if lib.strings.hasInfix "darwin" system then "/Users" else "/home"),
      system,
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
        ];
      }
    );
}
