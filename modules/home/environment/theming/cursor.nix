{
  lib,
  pkgs,
  profiles,
  ...
}:
{
  home.pointerCursor = lib.mkIf profiles.graphical.enable {
    enable = true;
    dotIcons.enable = false;
    gtk.enable = true;

    name = "phinger-cursors-dark";
    package = pkgs.phinger-cursors;
  };
}
