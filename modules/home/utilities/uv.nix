{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkPackageOption
    mkOption
    literalExpression
    ;

  tomlFormat = pkgs.formats.toml { };

  cfg = config.myHome.utilities.uv;
in
{
  options.myHome.utilities.uv = {
    enable = mkEnableOption "Enable uv";
    package = mkPackageOption pkgs "uv" { };
    settings = mkOption {
      type = tomlFormat.type;
      default = { };
      example = literalExpression ''
        {
          python-downloads = "never";
          python-preference = "only-system";
          pip.index-url = "https://test.pypi.org/simple";
        }
      '';
      description = ''
        Configuration written to
        {file}`$XDG_CONFIG_HOME/uv/uv.toml`.
        See <https://docs.astral.sh/uv/configuration/files/>
        and <https://docs.astral.sh/uv/reference/settings/>
        for more information.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    programs.uv = {
      enable = true;
      package = cfg.package;
      settings = cfg.settings;
    };
  };
}
