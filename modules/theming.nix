{
  config.modules = {
    nixos.theming =
      {
        inputs,
        lib,
        pkgs,
        ...
      }:
      let
        inherit (lib.attrsets) attrValues;
      in
      {
        imports = [ inputs.qtengine.result.nixosModules.default ];

        environment.systemPackages = attrValues {
          inherit (pkgs.kdePackages) breeze breeze-icons;
          inherit (pkgs.kdePackages.breeze) qt5;
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
      };

    home.theming =
      { lib, pkgs, ... }:
      let
        inherit (lib.generators) toINI;

        gtkSettings = {
          gtk-cursor-theme-name = "phinger-cursors-dark";
          gtk-cursor-theme-size = 24;
          gtk-font-name = "sans-serif 11";
          gtk-icon-theme-name = "breeze-dark";
          gtk-theme-name = "adw-gtk3-dark";
        };
      in
      {
        packages = [
          pkgs.adw-gtk3
          pkgs.phinger-cursors
        ];

        environment.sessionVariables = {
          XCURSOR_SIZE = 24;
          XCURSOR_THEME = "phinger-cursors-dark";
        };

        xdg = {
          config.files = {
            "gtk-3.0/settings.ini" = {
              generator = toINI { };
              value.Settings = gtkSettings;
            };

            "gtk-4.0/settings.ini" = {
              generator = toINI { };
              value.Settings = gtkSettings;
            };
          };

          data.files = {
            "icons/phinger-cursors-dark".source = "${pkgs.phinger-cursors}/share/icons/phinger-cursors-dark";
            "icons/default/index.theme".text = ''
              [Icon Theme]
              Name=Default
              Inherits=phinger-cursors-dark
            '';
          };
        };
      };
  };
}
