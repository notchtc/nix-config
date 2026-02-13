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

      base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
      image = ./wallpaper.jpg;
      polarity = "dark";

      cursor = {
        name = "BreezeX-RosePine-Linux";
        package = pkgs.rose-pine-cursor;
        size = 24;
      };

      icons = {
        enable = true;
        dark = "Papirus-Dark";
        light = "Papirus-Light";
        package = pkgs.papirus-icon-theme;
      };

      fonts = {
        serif = {
          package = pkgs.source-serif;
          name = "Source Serif 4";
        };

        sansSerif = {
          package = pkgs.atkinson-hyperlegible-next;
          name = "Atkinson Hyperlegible Next";
        };

        monospace = {
          package = pkgs.atkinson-hyperlegible-mono;
          name = "Atkinson Hyperlegible Mono";
        };

        emoji = {
          package = pkgs.noto-fonts-color-emoji;
          name = "Noto Color Emoji";
        };
      };
    };

    # fix KDE shenanigans
    environment.variables.QT_STYLE_OVERRIDE = lib.mkForce "";
  };
}
