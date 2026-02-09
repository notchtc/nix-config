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

    fonts = {
      packages = lib.attrValues {
        inherit (pkgs) corefonts noto-fonts-cjk-sans noto-fonts-cjk-serif;
        nerd-fonts = pkgs.nerd-fonts.symbols-only;
      };
    };

    boot.plymouth.font = "${pkgs.atkinson-hyperlegible-next}/share/fonts/opentype/AtkinsonHyperlegibleNext-Regular.otf";

    environment.variables = {
      FREETYPE_PROPERTIES = "autofitter:no-stem-darkening=0 autofitter:darkening-parameters=500,0,1000,500,2500,500,4000,0 cff:no-stem-darkening=0 type1:no-stem-darkening=0 t1cid:no-stem-darkening=0";
      QT_NO_SYNTHESIZED_BOLD = 1;
    };
  };
}
