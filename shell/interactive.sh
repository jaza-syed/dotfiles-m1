# m1 interactive fragment, sourced after the core interactive.sh through
# dotfiles.shell.extraInteractive.

# macOS applications, absent on Linux.
alias code="/Applications/Visual\ Studio\ Code.app/Contents/MacOS/Code"
alias typora="open -a Typora"
export VLC_APP=/Applications/VLC.app/Contents/MacOS/VLC

MACHINE_DIR="$HOME/code/jaza-syed/dotfiles-m1"

# Switch both m1 layers. Any arguments go to both nix commands, for example
# --override-input.
rebuild() {
    home-manager switch --flake "$MACHINE_DIR#m1" "$@" &&
        sudo /run/current-system/sw/bin/darwin-rebuild switch --flake "$MACHINE_DIR#m1" "$@"
}

# Relock every m1 input, commit the lock and push it.
relock() {
    nix flake update --flake "$MACHINE_DIR" &&
        git -C "$MACHINE_DIR" commit -m "Update the flake inputs" -- flake.lock &&
        git -C "$MACHINE_DIR" push
}
