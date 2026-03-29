{
  config,
  lib,
  pkgs,
  ...
}:
{
  xdg.portal = lib.mkIf config.mama.profiles.graphical.enable {
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    xdgOpenUsePortal = true;

    config.niri.default = [
      "gnome"
      "gtk"
    ];
  };
}
