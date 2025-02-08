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

  stylix.iconTheme = {
    enable = true;
    package = pkgs.papirus-icon-theme;
    light = "Papirus-Light";
    dark = "Papirus-Dark";
  };
}
