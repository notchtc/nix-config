{ config, lib, ... }:
let
  inherit (lib) genAttrs;
  inherit (config.mama) desktop;

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

  audio = [
    "audio/aac"
    "audio/flac"
    "audio/mpeg"
    "audio/ogg"
    "audio/opus"
    "audio/wav"
    "audio-x-ms-wma"
  ];

  image = [
    "image/avif"
    "image/bmp"
    "image/gif"
    "image/heic"
    "image/jpeg"
    "image/png"
    "image/svg+xml"
    "image/tiff"
    "image/webp"
    "image/x-icon"
  ];

  text = [
    "text/csv"
    "text/plain"
  ];

  torrent = [
    "x-scheme-handler/magnet"
    "x-scheme-handler/x-bittorrent"
  ];

  video = [
    "video/mp4"
    "video/ogg"
    "video/quicktime"
    "video/webm"
    "video/x-matroska"
    "video/x-msvideo"
    "video/x-ms-wmv"
  ];

  associations =
    (genAttrs browser (_: [ "Schizofox.desktop" ]))
    // (genAttrs audio (
      _:
      if desktop == "gnome" then
        [ "io.github.quodlibet.QuodLibet.desktop" ]
      else
        [ "org.strawberrymusicplayer.strawberry.desktop" ]
    ))
    // (genAttrs image (
      _: if desktop == "plasma" then [ "org.kde.gwenview.desktop" ] else [ "org.gnome.Loupe.desktop" ]
    ))
    // (genAttrs text (_: [ "Helix.desktop" ]))
    // genAttrs video (_: if desktop == "plasma" then [ "org.kde.haruna.desktop" ] else "mpv.desktop")
    // genAttrs torrent (_: [ "org.qbittorrent.qBittorrent.desktop" ])
    // {
      "application/pdf" =
        if desktop == "plasma" then [ "org.kde.okular" ] else [ "org.gnome.Papers.desktop" ];
      "x-scheme-handler/discord" = [ "vesktop.desktop" ];
      "x-scheme-handler/steam" = [ "steam.desktop" ];
      "x-scheme-handler/tg" = [ "org.telegram.desktop.desktop" ];
    };
in
{
  xdg = {
    terminal-exec = {
      enable = true;
      settings.default = [ "com.mitchellh.ghostty.desktop" ];
    };
    mimeApps = {
      enable = true;
      associations.added = associations;
      defaultApplications = associations;
    };
  };
}
