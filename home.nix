# m1 user layer on the dotfiles core.
{ config, lib, ... }:
let
  machineDir = "${config.home.homeDirectory}/code/jaza-syed/dotfiles-m1";
  link = path: config.lib.file.mkOutOfStoreSymlink "${machineDir}/${path}";
in
{
  home.username = "jsyed";
  home.homeDirectory = "/Users/jsyed";
  home.stateVersion = "26.05";
  programs.home-manager.enable = true;

  dotfiles.repoDir = "${config.home.homeDirectory}/code/jaza-syed/dotfiles";

  programs.git.settings.user = {
    name = "Jaza Syed";
    email = "jaza.syed@gmail.com";
  };

  home.file = {
    ".claude/machine.md".source = link "claude/machine.md";
  };

  # Seed settings.json only when missing; Claude Code's atomic writes would replace a symlink.
  home.activation.claudeSettings = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    [ -e "$HOME/.claude/settings.json" ] || $DRY_RUN_CMD cp "${machineDir}/claude/settings.json" "$HOME/.claude/settings.json"
  '';

  xdg.configFile."jj/conf.d/machine.toml".text = ''
    [user]
    name = "Jaza Syed"
    email = "jaza.syed@gmail.com"
  '';
}
