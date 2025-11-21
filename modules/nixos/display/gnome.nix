{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) attrValues mkForce mkIf;
  inherit (config.mama) desktop;
in
{
  config = mkIf (desktop == "gnome") {
    services = {
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;

      gnome = {
        core-apps.enable = false;
        gnome-initial-setup.enable = mkForce false;
      };
    };

    environment = {
      variables = {
        QT_QPA_PLATFORMTHEME = "gtk3";
        QT_WAYLAND_DECORATION = "adwaita";
      };

      systemPackages = attrValues {
        inherit (pkgs)
          ffmpegthumbnailer
          gnome-calculator
          loupe
          nautilus
          qadwaitadecorations
          qadwaitadecorations-qt6
          ;
      };

      gnome.excludePackages = attrValues { inherit (pkgs) gnome-backgrounds gnome-tour; };
    };
  };
}
