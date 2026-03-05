{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.mama.profiles.graphical.enable {
    environment = {
      systemPackages = [
        pkgs.qadwaitadecorations
        pkgs.qadwaitadecorations-qt6
      ];

      variables = {
        QT_STYLE_OVERRIDE = lib.mkForce "";
        QT_WAYLAND_DECORATION = "adwaita";
      };
    };
  };
}
