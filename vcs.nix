{
  lib,
  pkgs,
  ...
}:
{
  home.packages =
    with pkgs;
    [
      tig
    ]
    ++ lib.optionals pkgs.stdenv.hostPlatform.isDarwin [
      git-credential-manager
    ];

  programs = {
    delta = {
      enable = true;
      enableGitIntegration = true;
    };

    git = {
      enable = true;
      settings = {
        alias = {
          ci = "commit";
          co = "checkout";
          cp = "cherry-pick";
          df = "diff";
          sidediff = "-c delta.features=side-by-side diff";
          st = "--paginate status --branch --short";
          tip = "log --no-walk --stat";
        };
        clean = {
          requireForce = false;
        };
        color = {
          ui = "auto";
        };
        core = {
          abbrev = 8;
          autocrlf = false;
          quotepath = false;
          safecrlf = true;
        };
        grep = {
          lineNumber = true;
        };
        init = {
          defaultBranch = "main";
        };
        log = {
          decorate = "short";
        };
        pull = {
          ff = "only";
        };
        push = {
          default = "simple";
        };
        rerere = {
          enabled = true;
        };
      }
      // lib.optionalAttrs pkgs.stdenv.hostPlatform.isDarwin {
        credential = {
          helper = "manager";
        };
      };
    };
  };

  xdg.configFile = {
    tig = {
      source = ./tig;
      recursive = true;
    };
  };
}
