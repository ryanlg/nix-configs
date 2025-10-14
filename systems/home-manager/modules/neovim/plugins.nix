{ ... }:
{
      extraPackages = with pkgs; [
        fd
        fzf
        ripgrep
        git
        gzip
        shellcheck
      ];
    ];
  ];
}
