# dotfiles-m1

Machine-specific configuration for the m1 personal Mac, consuming the public
dotfiles core.

- User layer: `nix run home-manager/release-26.05 -- switch --flake .#jsyed@m1`
- System layer: `sudo nix run nix-darwin/nix-darwin-26.05#darwin-rebuild -- switch --flake .#m1`
- After a core push: `nix flake update dotfiles`
