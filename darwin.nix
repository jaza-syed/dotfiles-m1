# m1 personal Mac.
{ ... }:
{
  networking.hostName = "m1";
  nixpkgs.hostPlatform = "aarch64-darwin";
  system.primaryUser = "jsyed";
  users.users.jsyed.home = "/Users/jsyed";
  system.stateVersion = 6;

  # Personal-only Homebrew additions on top of the core set.
  homebrew = {
    brews = [ "transmission-cli" ];

    casks = [
      # Terminals & dev
      "iterm2"
      "orbstack"
      "wireshark"

      # Browsers
      "tor-browser"

      # Productivity
      "notion"

      # Media & audio
      "audacity"
      "blender"
      "supercollider"
      "midi-monitor"
      "jellyfin-media-player"
      "soulseek"
      "transmission"
      "zotero"

      # Misc
      "anki"
      "keymapp"
      "navigator"
      "signal"
      "telegram"
    ];

    masApps = {
      "Amazon Kindle" = 302584613;
      "CrystalFetch ISO Downloader" = 6454431289;
      "Toggl Track" = 1291898086;
    };
  };
}
