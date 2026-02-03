{ config, lib, ... }:
{
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
}
