{ lib, pkgs, ... }:
let
  browser = [ "Schizofox.desktop" ];
  docs = [ "org.gnome.Papers.desktop" ];
  music = [ "org.strawberrymusicplayer.strawberry.desktop" ];
  photos = [ "swayimg.desktop" ];
  text = [ "Helix.desktop" ];
  vids = [ "mpv.desktop" ];

  associations = {
    "application/json" = browser;
    "application/x-extension-htm" = browser;
    "application/x-extension-html" = browser;
    "application/x-extension-shtml" = browser;
    "application/x-extension-xht" = browser;
    "application/x-extension-xhtml" = browser;
    "application/xhtml+xml" = browser;
    "text/html" = browser;
    "x-scheme-handler/about" = browser;
    "x-scheme-handler/ftp" = browser;
    "x-scheme-handler/http" = browser;
    "x-scheme-handler/https" = browser;
    "x-scheme-handler/unknown" = browser;

    "x-scheme-handler/discord" = [ "vesktop.desktop" ];
    "x-scheme-handler/magnet" = [ "org.qbittorrent.qBittorrent.desktop" ];
    "x-scheme-handler/steam" = [ "steam.desktop" ];
    "x-scheme-handler/tg" = [ "org.telegram.desktop.desktop" ];
    "x-scheme-handler/x-bittorrent" = [ "org.qbittorrent.qBittorrent.desktop" ];

    "audio/aac" = music;
    "audio/flac" = music;
    "audio/mpeg" = music;
    "audio/ogg" = music;
    "audio/opus" = music;
    "audio/wav" = music;
    "audio/x-ms-wma" = music;

    "image/avif" = photos;
    "image/bmp" = photos;
    "image/gif" = photos;
    "image/heic" = photos;
    "image/jpeg" = photos;
    "image/png" = photos;
    "image/svg+xml" = photos;
    "image/tiff" = photos;
    "image/webp" = photos;
    "image/x-icon" = photos;

    "video/mp4" = vids;
    "video/ogg" = vids;
    "video/quicktime" = vids;
    "video/webm" = vids;
    "video/x-matroska" = vids;
    "video/x-msvideo" = vids;
    "video/x-ms-wmv" = vids;

    "application/pdf" = docs;
    "text/csv" = text;
    "text/plain" = text;
  };
in
{
  xdg = {
    terminal-exec.enable = true;
    mimeApps = {
      enable = true;
      associations.added = associations;
      defaultApplications = associations;
    };

    desktopEntries."org.openmw.launcher" = {
      name = "OpenMW Launcher";
      genericName = "Role Playing Game";
      comment = "An engine replacement for The Elder Scrolls III: Morrowind";
      exec = lib.getExe (
        pkgs.writeShellScriptBin "openmw-launcher-wrapper" ''
          export OSG_VERTEX_BUFFER_HINT="VERTEX_BUFFER_OBJECT"

          ${lib.getExe pkgs.steam-run} ${lib.getExe' pkgs.gamemode "gamemoderun"} "$HOME/.local/bin/openmw/openmw-launcher"
        ''
      );
      prefersNonDefaultGPU = true;
      icon = "openmw";
      type = "Application";
      categories = [
        "Game"
        "RolePlaying"
      ];
      settings.Keywords = "Morrowind;Reimplementation;Mods;esm;bsa";
    };
  };
}
