{
  config.modules = {
    nixos.theming = {
      qt = {
        enable = true;
        platformTheme = "qt5ct";
        style = "breeze";
      };
    };

    home.theming =
      { lib, pkgs, ... }:
      let
        inherit (lib) attrValues;
      in
      {
        packages = attrValues { inherit (pkgs) adw-gtk3 papirus-icon-theme phinger-cursors; };

        rum.misc.gtk = {
          enable = true;

          gtk2Location = ".config/gtk-2.0/gtkrc";

          settings = {
            cursor-theme-name = "phinger-cursors-dark";
            cursor-theme-size = 32;
            font-name = "Atkinson Hyperlegible Next 11";
            icon-theme-name = "Papirus-Dark";
            theme-name = "adw-gtk3-dark";
          };
        };
      };
  };
}
