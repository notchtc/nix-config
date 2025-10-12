{ pkgs, ... }:
{
  gtk = {
    enable = true;
    colorScheme = "dark";

    font = {
      name = "Sarasa UI J";
      package = pkgs.sarasa-gothic;
      size = 11;
    };

    iconTheme = {
      name = "MoreWaita";
      package = pkgs.morewaita-icon-theme;
    };

    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
  };

  home.pointerCursor = {
    name = "phinger-cursors-dark";
    package = pkgs.phinger-cursors;
    dotIcons.enable = false;
    gtk.enable = true;
  };
}
