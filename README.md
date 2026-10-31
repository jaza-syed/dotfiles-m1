# dotfiles-m1

Machine-specific configuration for the m1 personal Mac, consuming the public
dotfiles core. Phase 3 of the core's
[install.md](https://github.com/jaza-syed/dotfiles-core/blob/main/install.md)
sets up this machine from this repo, and [operations.md](operations.md)
contains the recurring commands.

## Layers

`flake.nix` sets the username once and defines two targets, both named `m1`:
the standalone Home Manager layer (`home.nix`) and the nix-darwin system layer
(`darwin.nix`). The user layer imports the core's shared and macOS home
modules, and the system layer runs sketchybar and borders as launchd services.

`darwin-rebuild` needs its absolute path under sudo because sudo's PATH lacks
the nix directories. The darwin switch must run from a terminal with Full Disk
Access or the Safari defaults write fails.

## Claude

`~/.claude/settings.json` is a real file that the user layer seeds from
`claude/settings.json` when it is missing, not a link, because Claude Code's
atomic writes would replace a link.

## CI and updates

CI evaluates both targets on every push and pull request. Renovate opens a
weekly lock maintenance PR and automerges it on green CI.

## Where changes take effect

A lock override only matters for modules and packages. Content behind the
out-of-store links (nvim, shell fragments, the Claude files, themes) always
comes from the local checkouts through `dotfiles.repoDir` and this repo's
path, so editing those files takes effect immediately, with no relock or
switch, and before the edit is committed or pushed. The lock pins what a
switch builds, not what the links serve.
