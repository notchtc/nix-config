{ lib, pkgs, ... }:
{
  services = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  environment.gnome.excludePackages = lib.attrValues {
    inherit (pkgs)
      baobab
      decibels
      epiphany
      geary
      gnome-console
      gnome-contacts
      gnome-logs
      gnome-maps
      gnome-music
      gnome-shell-extensions
      gnome-software
      gnome-text-editor
      gnome-tour
      gnome-user-docs
      orca
      totem
      yelp
      ;
  };

  services = {
    gnome.gnome-initial-setup.enable = lib.mkForce false;
    udev.packages = [ pkgs.gnome-settings-daemon ];
  };
}
