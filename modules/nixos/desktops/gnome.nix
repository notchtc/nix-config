{
  lib,
  pkgs,
  ...
}: {
  services = {
    xserver = {
      enable = true;

      displayManager = {
        gdm.enable = true;
        defaultSession = "gnome";
        autoLogin = {
          enable = true;
          user = "chtc";
        };
      };

      desktopManager.gnome.enable = true;

      xkb = {
        layout = "pl";
        options = "caps:swapescape";
      };

      excludePackages = [pkgs.xterm];
    };
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
