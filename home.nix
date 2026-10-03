{
  pkgs,
  username,
  homeDirectory,
  ...
}:
{
  home = {
    stateVersion = "26.05";

    inherit username;
    inherit homeDirectory;

    packages = with pkgs; [
      migu
      nerd-fonts._0xproto
      nil
      nixd
      nixfmt
      statix
    ];
  };

  programs = {
    home-manager = {
      enable = true;
    };

    mise = {
      enable = true;
    };
  };

  imports = [
    ./editor.nix
    ./shell.nix
    ./terminal.nix
    ./vcs.nix
    ./virtualisation.nix
  ];
}
