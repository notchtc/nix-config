{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.mama.desktops.gnome.enable {
    services = {
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;

      gnome = {
        core-apps.enable = false;
        gnome-initial-setup.enable = lib.mkForce false;
      };
    };

    environment = {
      sessionVariables = {
        QT_QPA_PLATFORMTHEME = "gtk3";
        QT_WAYLAND_DECORATION = "adwaita";
      };

      systemPackages = lib.attrValues {
        inherit (pkgs)
          ffmpegthumbnailer
          gnome-calculator
          loupe
          nautilus
          qadwaitadecorations
          qadwaitadecorations-qt6
          ;
      };

      gnome.excludePackages = lib.attrValues { inherit (pkgs) gnome-backgrounds gnome-tour; };
    };
  };
}
