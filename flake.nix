{
  description = "m1 personal Mac: home and darwin layers on the dotfiles core";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Follows the core's default branch; move with `nix flake update dotfiles`.
    dotfiles = {
      url = "github:jaza-syed/dotfiles-core";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nix-darwin,
      dotfiles,
      ...
    }:
    {
      homeConfigurations."jsyed@m1" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.aarch64-darwin;
        modules = [
          dotfiles.homeModules.default
          ./home.nix
        ];
      };

      darwinConfigurations.m1 = nix-darwin.lib.darwinSystem {
        modules = [
          dotfiles.darwinModules.defaults
          dotfiles.darwinModules.homebrew
          ./darwin.nix
        ];
      };
    };
}
