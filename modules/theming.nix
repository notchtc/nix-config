{
  config.modules = {
    nixos.theming =
      {
        inputs,
        lib,
        modules,
        pkgs,
        ...
      }:
      let
        inherit (lib.attrsets) attrValues;
      in
      {
        imports = [ inputs.qtengine.result.nixosModules.default ];

        environment.systemPackages = attrValues {
          inherit (pkgs.kdePackages) breeze;
          inherit (pkgs.kdePackages.breeze) qt5;
        };

        programs.qtengine = {
          enable = true;

          config = {
            theme = {
              colorScheme = "${pkgs.kdePackages.breeze}/share/color-schemes/BreezeDark.colors";
              iconTheme = "Papirus-Dark";
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

        hjem.extraModules = [ modules.home.theming ];
      };

    home.theming =
      { lib, pkgs, ... }:
      let
        inherit (lib) attrValues;
      in
      {
        packages = attrValues { inherit (pkgs) adw-gtk3 papirus-icon-theme phinger-cursors; };

        environment.sessionVariables = {
          XCURSOR_SIZE = 24;
          XCURSOR_THEME = "phinger-cursors-dark";
        };

        rum.misc.gtk = {
          enable = true;

          gtk2Location = ".config/gtk-2.0/gtkrc";

          settings = {
            cursor-theme-name = "phinger-cursors-dark";
            cursor-theme-size = 24;
            font-name = "sans-serif 11";
            icon-theme-name = "Papirus-Dark";
            theme-name = "adw-gtk3-dark";
          };
        };
      };
  };
}
