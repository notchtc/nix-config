{ lib, pkgs, ... }:
{
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  environment.gnome.excludePackages = lib.attrValues {
    inherit (pkgs)
      baobab
      epiphany
      geary
      gnome-console
      gnome-contacts
      gnome-logs
      gnome-maps
      gnome-music
      gnome-shell-extensions
      gnome-software
      gnome-tour
      gnome-user-docs
      orca
      totem
      yelp
      ;
  };

  services.udev.packages = [ pkgs.gnome-settings-daemon ];
}
