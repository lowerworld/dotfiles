{
  config,
  lib,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    uutils-coreutils-noprefix
    uutils-diffutils
    uutils-findutils
    zsh-completions
  ];

  programs = {
    bat = {
      enable = true;
    };

    eza = {
      enable = true;
      enableZshIntegration = true;
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
      historyWidget = {
        options = [
          "--border=sharp"
          "--exact"
          "--exit-0"
          "--height=45%"
          "--highlight-line"
          "--keep-right"
          "--layout=reverse"
          "--no-sort"
          "--prompt='󰅂 '"
        ];
      };
    };

    starship = {
      enable = true;
      enableZshIntegration = true;
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    zsh = {
      enable = true;
      autocd = true;
      autosuggestion = {
        enable = true;
      };
      completionInit = "";
      defaultKeymap = "emacs";
      dotDir = "${config.xdg.configHome}/zsh";
      enableCompletion = true;
      history = {
        ignoreAllDups = true;
        saveNoDups = true;
      };
      initContent = lib.mkOrder 1500 ''
        zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Z}{a-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

        for file in ''${ZDOTDIR}/zshrc.d/*.zsh(N-.); do
          source ''${file}
        done
      '';
      plugins = with pkgs; [
        {
          name = "zimfw/environment";
          src = fetchFromGitHub {
            owner = "zimfw";
            repo = "environment";
            rev = "d4bceaa3da89cd819843334dba1a5bf7dc137e14";
            hash = "sha256-B8Cki4uCcSce0xewZ91P9wCpA5+x/AlT1IwC+HVs6OI=";
          };
          file = "init.zsh";
        }
        {
          name = "zimfw/input";
          src = fetchFromGitHub {
            owner = "zimfw";
            repo = "input";
            rev = "bdec2b372f8bd16a072d30ebc447a22dad52cfb4";
            hash = "sha256-/tWks6oFH6/LK8u9SxsZIJ9uAonJ2T6l91BflDwog80=";
          };
          file = "init.zsh";
        }
        {
          name = "zimfw/completion";
          src = fetchFromGitHub {
            owner = "zimfw";
            repo = "completion";
            rev = "8d3e0f4e6272f4d3bad659eaa13929f9dd96f123";
            hash = "sha256-xBurErM7KMMDObN3zPwTSOvKqXl9FDZxGfxugwlX/fk=";
          };
          file = "init.zsh";
        }
      ];
      sessionVariables = {
        LESSHISTFILE = "-";

        NEXT_TELEMETRY_DISABLED = "1";
        TURBO_TELEMETRY_DISABLED = "1";

        EZA_CONFIG_DIR = "${config.xdg.configHome}/eza";

        _ZO_FZF_OPTS = builtins.concatStringsSep " " [
          "--bind=ctrl-z:ignore,btab:up,tab:down"
          "--border=sharp"
          "--cycle"
          "--exact"
          "--exit-0"
          "--height=45%"
          "--highlight-line"
          "--keep-right"
          "--layout=reverse"
          "--no-sort"
          "--prompt='󰅂 '"
          "--tabstop=1"
        ];
      };
      setOptions = [
        "CLOBBER"
        "HIST_NO_STORE"
        "HIST_REDUCE_BLANKS"

        "NO_EXTENDED_GLOB"
      ];
      shellAliases = {
        cat = "bat";
        ll = "eza --long --classify --all --group-directories-first --time-style=long-iso";
        ls = "eza";
      };
      syntaxHighlighting = {
        enable = true;
        highlighters = [ "brackets" ];
        styles = {
          arg0 = "fg=118";
          back-dollar-quoted-argument = "fg=135";
          back-double-quoted-argument = "fg=135";
          back-quoted-argument-delimiter = "fg=161";
          command-substitution-delimiter = "fg=161";
          comment = "fg=59";
          dollar-double-quoted-argument = "fg=118";
          dollar-quoted-argument = "fg=144";
          double-quoted-argument = "fg=144";
          globbing = "fg=161";
          history-expansion = "fg=81";
          path = "none";
          precommand = "fg=161,underline";
          process-substitution-delimiter = "fg=161";
          rc-quote = "fg=135";
          redirection = "fg=161";
          reserved-word = "fg=161,bold";
          single-quoted-argument = "fg=144";
          suffix-alias = "fg=161,underline";
          unknown-token = "none";
        };
      };
    };
  };

  xdg.configFile = {
    eza = {
      source = ./eza;
      recursive = true;
    };
    "starship.toml" = {
      source = ./starship/starship.toml;
    };
  };
}
