{ config, pkgs, ... }:
{
  gtk = {
    enable = true;
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;

    cursorTheme = {
      name = "${config.stylix.cursor.name}";
      package = "${config.stylix.cursor.package}";
    };
  };

  stylix = {
    targets.gtk.flatpakSupport.enable = false;
    icons = {
      enable = true;
      package = pkgs.morewaita-icon-theme;
      light = "MoreWaita";
      dark = "MoreWaita";
    };
  };
}
