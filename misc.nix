{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    migu
    nerd-fonts._0xproto
    nil
    nixd
    nixfmt
    statix
  ];

  programs = {
    gpg = {
      enable = true;
    };

    mise = {
      enable = true;
    };
  };
}
