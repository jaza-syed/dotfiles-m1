# Operations

Recurring tasks on m1. Everything else is in the core's
[operations.md](https://github.com/jaza-syed/dotfiles-core/blob/main/operations.md).

## Common commands

`shell/interactive.sh` defines `rebuild`, which switches both layers, and
`relock`, which updates every input, commits the lock and pushes it. The
commands behind them:

```sh
# User layer
home-manager switch --flake .#m1

# System layer
sudo /run/current-system/sw/bin/darwin-rebuild switch --flake .#m1

# Reload sketchybar config, or restart the launchd service entirely
sketchybar --reload
launchctl kickstart -k gui/$(id -u)/org.nixos.sketchybar

# Restart borders (restyling needs no restart: the aerospace mode scripts
# pass new settings to the running instance)
launchctl kickstart -k gui/$(id -u)/org.nixos.jankyborders
```

## Changing the Claude settings

After editing the repo copy, check for runtime drift and copy it into place:

```sh
difft ~/.claude/settings.json claude/settings.json
cp claude/settings.json ~/.claude/settings.json
```

If the diff shows a runtime change worth keeping (for example a `/model`
switch), fold it into the repo copy first. New Claude Code sessions pick up
the copied settings.

## Getting a core change onto this machine

Push the core, then relock here and switch:

```sh
nix flake update dotfiles
git add flake.lock
git commit -m "relock onto the pushed core"
git push

home-manager switch --flake .#m1
sudo /run/current-system/sw/bin/darwin-rebuild switch --flake .#m1
```

Only the layer the change touches needs its switch: packages and links are the
user layer, and Homebrew and macOS defaults are the system layer.

## Testing local core changes

Point the `dotfiles` input at the local checkout to test core changes before
pushing:

```sh
home-manager switch --flake .#m1 \
  --override-input dotfiles "git+file://$HOME/code/jaza-syed/dotfiles" \
  --no-write-lock-file
```

The `git+file` fetch uses the core's working tree: uncommitted changes to
tracked files are included, but untracked files are not, so `git add` a new
file before testing it.
