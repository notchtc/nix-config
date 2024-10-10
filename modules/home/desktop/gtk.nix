{ config, pkgs, ... }:
{
  stylix.targets.gtk.extraCss = ''
    window.background { border-radius: 0; }
  '';

  gtk = {
    enable = true;

    iconTheme = {
      name = "MoreWaita";
      package = pkgs.morewaita-icon-theme;
    };

    cursorTheme = {
      name = "${config.stylix.cursor.name}";
      package = "${config.stylix.cursor.package}";
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };
}
