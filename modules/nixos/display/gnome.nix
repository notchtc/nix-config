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
    };

    environment = {
      sessionVariables.QT_WAYLAND_DECORATION = "adwaita";

      systemPackages = lib.attrValues {
        inherit (pkgs)
          ffmpegthumbnailer
          gnome-tweaks
          qadwaitadecorations
          qadwaitadecorations-qt5
          ;
      };

      gnome.excludePackages = lib.attrValues {
        inherit (pkgs)
          baobab
          decibels
          epiphany
          evince
          geary
          gnome-console
          gnome-contacts
          gnome-logs
          gnome-maps
          gnome-music
          gnome-software
          gnome-text-editor
          gnome-tour
          gnome-user-docs
          orca
          sushi
          totem
          yelp
          ;
      };
    };

    services = {
      gnome.gnome-initial-setup.enable = lib.mkForce false;
      udev.packages = [ pkgs.gnome-settings-daemon ];
    };
  };
}
