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
    # Local checkout until the core is published (ROADMAP item 9); relock with
    # `nix flake update dotfiles` after core commits.
    dotfiles = {
      url = "git+file:///Users/jsyed/code/jaza-syed/dotfiles";
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
