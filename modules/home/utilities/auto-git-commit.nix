{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myHome.utilities.auto-git-commit;
  script = pkgs.writeShellScript "auto-git-commit" ''
    set -u

    git_bin="${cfg.package}/bin/git"
    commit_msg=${lib.escapeShellArg cfg.message}

    for repo_dir in ${lib.escapeShellArgs cfg.directories}; do
      if [ ! -d "$repo_dir/.git" ]; then
        continue
      fi

      if ! "$git_bin" -C "$repo_dir" status --porcelain | grep -q .; then
        continue
      fi

      "$git_bin" -C "$repo_dir" add -A

      if "$git_bin" -C "$repo_dir" commit -m "$commit_msg"; then
        "$git_bin" -C "$repo_dir" push ${lib.escapeShellArgs cfg.pushArgs}
      fi
    done
  '';
in
{
  options.myHome.utilities.auto-git-commit = {
    enable = lib.mkEnableOption "auto git commit and push";

    package = lib.mkPackageOption pkgs "git" { };

    directories = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "List of git repo directories to auto-commit and push.";
    };

    message = lib.mkOption {
      type = lib.types.str;
      default = "auto commit";
      description = "Commit message used for automated commits.";
    };

    dailyTime = lib.mkOption {
      type = lib.types.str;
      default = "03:00";
      description = "Fixed daily run time in 24-hour HH:MM format.";
    };

    pushArgs = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "Additional arguments passed to git push.";
    };
  };

  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = cfg.directories != [ ];
        message = "myHome.utilities.auto-git-commit.directories must be non-empty.";
      }
      {
        assertion = builtins.match "^(?:[01][0-9]|2[0-3]):[0-5][0-9]$" cfg.dailyTime != null;
        message = "myHome.utilities.auto-git-commit.dailyTime must be in 24-hour HH:MM format.";
      }
    ];

    systemd.user.services.auto-git-commit = lib.mkIf (!pkgs.stdenv.isDarwin) {
      Unit = {
        Description = "Auto git commit and push";
      };
      Service = {
        Type = "oneshot";
        ExecStart = script;
      };
    };

    systemd.user.timers.auto-git-commit = lib.mkIf (!pkgs.stdenv.isDarwin) {
      Unit = {
        Description = "Auto git commit and push timer";
      };
      Timer = {
        OnCalendar = "*-*-* ${cfg.dailyTime}:00";
        Unit = "auto-git-commit.service";
      };
      Install = {
        WantedBy = [ "timers.target" ];
      };
    };

    launchd.agents.auto-git-commit = lib.mkIf pkgs.stdenv.isDarwin {
      enable = true;
      config = {
        ProgramArguments = [ script ];
        RunAtLoad = false;
        StartCalendarInterval = {
          Hour = builtins.fromJSON (builtins.elemAt (lib.splitString ":" cfg.dailyTime) 0);
          Minute = builtins.fromJSON (builtins.elemAt (lib.splitString ":" cfg.dailyTime) 1);
        };
      };
    };
  };
}
