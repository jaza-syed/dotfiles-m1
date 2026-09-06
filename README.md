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

## Changing the Claude settings

`~/.claude/settings.json` is a real file seeded from `claude/settings.json`
here, not a link, because Claude Code's atomic writes would replace a link.
After editing the repo copy, check for runtime drift and copy it into place:

```sh
difft ~/.claude/settings.json claude/settings.json
cp claude/settings.json ~/.claude/settings.json
```

If the diff shows a runtime change worth keeping (for example a `/model`
switch), fold it into the repo copy first. New Claude Code sessions pick up
the copied settings.

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

The override only matters for modules and packages. Content behind the
out-of-store links (nvim, shell fragments, the Claude files, themes) always
comes from the local core checkout through `dotfiles.repoDir`, so editing
those files takes effect immediately, with no relock or switch, and before
the edit is committed or pushed. The lock pins what a switch builds, not
what the links serve.

Everything else is in the core's
[operations.md](https://github.com/jaza-syed/dotfiles-core/blob/main/operations.md).
