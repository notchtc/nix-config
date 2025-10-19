{ pkgs, ... }:
{
  imports = [
    ./gnome.nix
    ./plasma.nix
  ];

  gtk = {
    enable = true;
    colorScheme = "dark";

    font = {
      name = "Sarasa UI J";
      package = pkgs.sarasa-gothic;
      size = 11;
    };
  };

  home.pointerCursor = {
    name = "phinger-cursors-dark";
    package = pkgs.phinger-cursors;
    dotIcons.enable = false;
    gtk.enable = true;
  };
}
