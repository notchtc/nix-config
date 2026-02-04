{ lib, pkgs, ... }:
{
  xdg.mimeApps = {
    enable = true;
    defaultApplicationPackages = lib.attrValues {
      inherit (pkgs)
        haruna
        helix
        librewolf
        qbittorrent
        steam
        strawberry
        telegram-desktop
        tutanota-desktop
        vesktop
        ;

      inherit (pkgs.kdePackages) gwenview okular;
    };
  };
}
