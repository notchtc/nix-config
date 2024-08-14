{ pkgs, ... }:
{
  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface".color-scheme = "prefer-dark";
    };
  };

  gtk = {
    enable = true;

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    theme = {
      name = "Breeze-Dark";
      package = pkgs.kdePackages.breeze-gtk;
    };

    cursorTheme = {
      name = "phinger-cursors-dark";
      package = pkgs.phinger-cursors;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };
}
