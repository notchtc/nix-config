{ config, pkgs, ... }:
{
  stylix.targets.gtk.extraCss = ''
    window.background { border-radius: 0; }
  '';

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

  qt = {
    enable = true;
    platformTheme.name = "adwaita";
    style.name = "adwaita-dark";
  };

  stylix.iconTheme = {
    enable = true;
    package = pkgs.morewaita-icon-theme;
    light = "MoreWaita";
    dark = "MoreWaita";
  };
}
