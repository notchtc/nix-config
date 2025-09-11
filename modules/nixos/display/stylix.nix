{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [ inputs.stylix.result.nixosModules.stylix ];
  config = lib.mkIf config.mama.profiles.graphical.enable {
    stylix = {
      enable = true;

      base16Scheme = "${pkgs.base16-schemes}/share/themes/selenized-dark.yaml";
      image = ./wallpaper.jpg;
      polarity = "dark";

      cursor = {
        package = pkgs.phinger-cursors;
        name = "phinger-cursors-dark";
        size = 24;
      };

      fonts = {
        serif = {
          package = pkgs.dejavu_fonts;
          name = "DejaVu Serif";
        };

        sansSerif = {
          package = pkgs.sarasa-gothic;
          name = "Sarasa UI J";
        };

        monospace = {
          package = pkgs.sarasa-gothic;
          name = "Sarasa Term J";
        };

        emoji = {
          package = pkgs.noto-fonts-emoji;
          name = "Noto Color Emoji";
        };

        sizes = {
          applications = 10;
          desktop = 10;
          popups = 10;
          terminal = 10;
        };
      };
    };
  };
}
