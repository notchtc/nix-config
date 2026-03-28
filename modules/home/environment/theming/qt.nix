{
  config,
  lib,
  profiles,
  ...
}:
{
  config = lib.mkIf profiles.graphical.enable {
    home.sessionVariables.QT_STYLE_OVERRIDE = lib.mkForce "";

    qt = rec {
      enable = true;
      style.name = "breeze";
      platformTheme.name = "qtct";

      qt6ctSettings = {
        Appearance = {
          style = "Breeze";
          icon_theme = config.gtk.iconTheme.name;
          color_scheme_path = "${config.xdg.configHome}/qt6ct/colors/matugen.conf";
          custom_palette = true;
          standard_diialogs = "xdgdesktopportal";
        };
      };

      qt5ctSettings = lib.recursiveUpdate qt6ctSettings {
        Appearance.color_scheme_path = "${config.xdg.configHome}/qt5ct/colors/matugen.conf";
      };

      kde.settings = rec {
        kdeglobals = {
          General.ColorScheme = "DankMatugen";
          UISettings.ColorScheme = kdeglobals.General.ColorScheme;
          Icons.Theme = config.gtk.iconTheme.name;
        };
      };
    };
  };
}
