{
  lib,
  pkgs,
  ...
}:
lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {
  home.packages = with pkgs; [
    docker
    docker-buildx
    docker-compose
    docker-credential-helpers
  ];

  services = {
    colima = {
      enable = true;
    };
  };
}
