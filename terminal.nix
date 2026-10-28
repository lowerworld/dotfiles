{
  lib,
  pkgs,
  ...
}:
lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {
  xdg.configFile = {
    ghostty = {
      source = ./ghostty;
      recursive = true;
    };
  };
}
