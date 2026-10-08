{
  lib,
  pkgs,
  ...
}:
lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {
  home.packages = with pkgs; [
    ghostty-bin
  ];

  xdg.configFile = {
    ghostty = {
      source = ./ghostty;
      recursive = true;
    };
  };
}
