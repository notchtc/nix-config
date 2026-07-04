{
  config.modules.home.qbittorrent =
    { lib, pkgs, ... }:
    let
      inherit (lib.attrsets) genAttrs;
      inherit (lib.trivial) const flip;
    in
    {
      packages = [ pkgs.qbittorrent ];

      xdg.mime-apps.default-applications = flip genAttrs (const "org.qbittorrent.qBittorrent.desktop") [
        "x-scheme-handler/magnet"
        "x-scheme-handler/x-bittorrent"
      ];
    };
}
