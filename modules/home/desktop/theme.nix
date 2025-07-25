{ config, pkgs, ... }:
{
  gtk = {
    enable = true;

    cursorTheme = {
      name = "${config.stylix.cursor.name}";
      package = "${config.stylix.cursor.package}";
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  stylix.icons = {
    enable = true;
    package = pkgs.morewaita-icon-theme;
    light = "MoreWaita";
    dark = "MoreWaita";
  };

  stylix.targets.gtk.flatpakSupport.enable = false;
}
