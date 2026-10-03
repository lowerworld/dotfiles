{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    ast-grep
    fd
    jq
    lazygit
    luarocks
    mermaid-cli
    ripgrep
    tree-sitter
    yq
  ];

  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
  };

  xdg.configFile = {
    nvim = {
      source = ./neovim;
      recursive = true;
    };
  };
}
