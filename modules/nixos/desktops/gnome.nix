{
  lib,
  pkgs,
  ...
}: {
  services.xserver = {
    displayManager = {
      gdm.enable = true;
      defaultSession = "gnome";
    };

    desktopManager.gnome.enable = true;
  };

  environment.gnome.excludePackages = lib.attrValues {
    inherit
      (pkgs)
      gnome-photos
      gnome-tour
      snapshot
      ;
    inherit
      (pkgs.gnome)
      cheese
      gnome-music
      gnome-terminal
      epiphany
      geary
      gnome-characters
      totem
      tali
      iagno
      hitori
      atomix
      yelp
      gnome-initial-setup
      gnome-maps
      gnome-contacts
      ;
  };
}
