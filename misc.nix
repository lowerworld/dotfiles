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
    mise = {
      enable = true;
    };
  };
}
