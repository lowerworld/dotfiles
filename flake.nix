{
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixpkgs-unstable";
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      flake-parts,
      home-manager,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.home-manager.flakeModules.home-manager
      ];

      flake =
        let
          system = builtins.currentSystem;
          username = builtins.getEnv "USER";
          homeDirectory = builtins.getEnv "HOME";
        in
        {
          homeModules.home-manager = {
            home = {
              inherit username;
              inherit homeDirectory;

              stateVersion = "26.05";
            };

            programs.home-manager.enable = true;
          };

          homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
            pkgs = import nixpkgs { inherit system; };

            modules = [
              inputs.self.homeModules.home-manager
              ./editor.nix
              ./misc.nix
              ./shell.nix
              ./terminal.nix
              ./vcs.nix
              ./virtualisation.nix
            ];
          };
        };
    };
}
