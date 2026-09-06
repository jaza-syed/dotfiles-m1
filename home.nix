# m1 user layer on the dotfiles core.
{ config, ... }:
{
  home.username = "jsyed";
  home.homeDirectory = "/Users/jsyed";
  home.stateVersion = "26.05";
  programs.home-manager.enable = true;

  dotfiles.repoDir = "${config.home.homeDirectory}/code/jaza-syed/dotfiles";
}
