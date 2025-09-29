{ lib, ... }:
let
  inherit (lib) genAttrs;
  browser = [
    "application/json"
    "application/x-extension-htm"
    "application/x-extension-html"
    "application/x-extension-shtml"
    "application/x-extension-xht"
    "application/x-extension-xhtml"
    "application/xhtml+xml"
    "text/html"
    "x-scheme-handler/about"
    "x-scheme-handler/ftp"
    "x-scheme-handler/http"
    "x-scheme-handler/https"
    "x-scheme-handler/unknown"
  ];

  audio = [ "audio/*" ];

  image = [ "image/*" ];

  text = [
    "text/csv"
    "text/plain"
  ];

  torrent = [
    "x-scheme-handler/magnet"
    "x-scheme-handler/x-bittorrent"
  ];

  video = [ "video/*" ];

  associations =
    (genAttrs browser (_: [ "Schizofox.desktop" ]))
    // (genAttrs audio (_: [ "org.strawberrymusicplayer.strawberry.desktop" ]))
    // (genAttrs image (_: [
      "org.gnome.Loupe.desktop"
    ]))
    // (genAttrs text (_: [ "Helix.desktop" ]))
    // genAttrs video (_: [ "mpv.desktop" ])
    // genAttrs torrent (_: [ "org.qbittorrent.qBittorrent.desktop" ])
    // {
      "application/pdf" = [ "org.gnome.Papers.desktop" ];
      "x-scheme-handler/discord" = [ "vesktop.desktop" ];
      "x-scheme-handler/steam" = [ "steam.desktop" ];
      "x-scheme-handler/tg" = [ "org.telegram.desktop.desktop" ];
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
  };
}
