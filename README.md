# dotfiles-m1

Machine-specific configuration for the m1 personal Mac, consuming the public
dotfiles core.

## Common commands

```sh
# User layer
home-manager switch --flake .#jsyed@m1

# System layer
sudo /run/current-system/sw/bin/darwin-rebuild switch --flake .#m1

# After a core push: relock, then switch
nix flake update dotfiles
```

`darwin-rebuild` needs its absolute path because sudo's PATH lacks the nix
directories, and the darwin switch must run from a terminal with Full Disk
Access or the Safari defaults write fails.

## Testing local core changes

Point the `dotfiles` input at the local checkout to test uncommitted core
changes before pushing:

```sh
home-manager switch --flake .#jsyed@m1 \
  --override-input dotfiles git+file:///Users/jsyed/code/jaza-syed/dotfiles \
  --no-write-lock-file
```

The `git+file` fetch uses the core's working tree: uncommitted changes to
tracked files are included, but untracked files are not, so `git add` a new
file before testing it.

Everything else is in the core's
[operations.md](https://github.com/jaza-syed/dotfiles-core/blob/main/operations.md).
