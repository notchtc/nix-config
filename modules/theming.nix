{
  config.modules.home.theming =
    { lib, pkgs, ... }:
    let
      inherit (lib.attrsets) attrValues;
    in
    {
      packages = attrValues {
        inherit (pkgs) adw-gtk3 phinger-cursors;
        inherit (pkgs.kdePackages) breeze breeze-icons;
        inherit (pkgs.kdePackages.breeze) qt5;
      };

      environment.sessionVariables = {
        XCURSOR_SIZE = 24;
        XCURSOR_THEME = "phinger-cursors-dark";
      };

      programs.qtengine = {
        enable = true;

        config = {
          theme = {
            colorScheme = "${pkgs.kdePackages.breeze}/share/color-schemes/BreezeDark.colors";
            iconTheme = "breeze-dark";
            style = "breeze";

            font = {
              family = "sans-serif";
              size = 11;
              weight = -1;
            };

            fontFixed = {
              family = "monospace";
              size = 11;
              weight = -1;
            };
          };

          misc = {
            singleClickActivate = false;
            menusHaveIcons = true;
            shortcutsForContextMenus = true;
          };
        };
      };

      rum.misc.gtk = {
        enable = true;

        gtk2Location = ".config/gtk-2.0/gtkrc";

        settings = {
          cursor-theme-name = "phinger-cursors-dark";
          cursor-theme-size = 24;
          font-name = "sans-serif 11";
          icon-theme-name = "breeze-dark";
          theme-name = "adw-gtk3-dark";
        };
      };

      xdg.data.files = {
        "icons/phinger-cursors-dark".source = "${pkgs.phinger-cursors}/share/icons/phinger-cursors-dark";
        "icons/default/index.theme".text = ''
          [Icon Theme]
          Name=Default
          Inherits=phinger-cursors-dark
        '';
      };
    };
}
