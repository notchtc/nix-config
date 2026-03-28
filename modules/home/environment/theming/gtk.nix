{
  lib,
  pkgs,
  profiles,
  ...
}:
{
  gtk = lib.mkIf profiles.graphical.enable {
    enable = true;
    colorScheme = "dark";

    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    font = {
      name = "Atkinson Hyperlegible Next";
      package = pkgs.atkinson-hyperlegible-next;
    };

    gtk4.theme = null;
  };
}
