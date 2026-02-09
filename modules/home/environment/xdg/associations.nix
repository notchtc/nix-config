{ lib, ... }:
let
  inherit (lib) genAttrs mergeAttrsList;

  browser = [
    "application/json"
    "application/x-extension-htm"
    "application/x-extension-html"
    "application/x-extension-shtml"
    "application/x-extension-xht"
    "application/x-extension-xhtml"
    "application/xhtml+xml"
    "text/html"
    "x-www-browser"
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

  associations = mergeAttrsList [
    {
      "application/pdf" = [ "org.kde.okular.desktop" ];
      "inode/directory" = [ "Thunar.desktop" ];
      "x-scheme-handler/discord" = [ "vesktop.desktop" ];
      "x-scheme-handler/steam" = [ "steam.desktop" ];
      "x-scheme-handler/tg" = [ "org.telegram.desktop.desktop" ];
    }

    (genAttrs browser (_: [ "librewolf.desktop" ]))
    (genAttrs text (_: [ "Helix.desktop" ]))
    (genAttrs torrent (_: [ "org.qbittorrent.qBittorrent.desktop" ]))

    (genAttrs audio (_: [ "org.strawberrymusicplayer.strawberry.desktop" ]))
    (genAttrs image (_: [ "org.kde.gwenview.desktop" ]))
    (genAttrs video (_: [ "org.kde.haruna.desktop" ]))
  ];
in
{
  xdg.mimeApps = {
    enable = true;
    associations.added = associations;
    defaultApplications = associations;
  };
}
