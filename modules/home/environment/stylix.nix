{
  config,
  lib,
  profiles,
  ...
}:
let
  style-colors = ''
    [ColorScheme]
    active_colors=#ffe0def4, #ff26233a, #ff6e6a86, #ff6e6a86, #ff191724, #ff191724, #ffe0def4, #ffffffff, #ffe0def4, #ff191724, #ff1f1d2e, #ff000000, #fff6c177, #ff191724, #ffc4a7e7, #fff6c177, #ff1f1d2e, #ff000000, #ff191724, #ffe0def4, #80e0def4, #ff308cc6
    disabled_colors=#ff908caa, #ff26233a, #ff6e6a86, #ff6e6a86, #ff191724, #ff191724, #ff908caa, #ffffffff, #ff908caa, #ff191724, #ff1f1d2e, #ff000000, #fff6c177, #66191724, #ffc4a7e7, #fff6c177, #ff1f1d2e, #ff000000, #ff191724, #ffe0def4, #80e0def4, #ff919191
    inactive_colors=#ffe0def4, #ff26233a, #ff6e6a86, #ff6e6a86, #ff191724, #ff191724, #ffe0def4, #ffffffff, #ffe0def4, #ff191724, #ff1f1d2e, #ff000000, #fff6c177, #ff191724, #ffc4a7e7, #fff6c177, #ff1f1d2e, #ff000000, #ff191724, #ffe0def4, #80e0def4, #ff308cc6
  '';
in
{
  config = lib.mkIf profiles.graphical.enable {
    home.pointerCursor.x11.enable = lib.mkForce false;
    stylix = {
      targets = {
        blender.enable = false;
        forge.enable = false;
        gdu.enable = false;
        gtk.flatpakSupport.enable = false;
        sxiv.enable = false;
        xresources.enable = false;
      };
    };

    # fix KDE shenanigans
    home.sessionVariables.QT_STYLE_OVERRIDE = lib.mkForce "";
    xdg.configFile = {
      kdeglobals.source =
        let
          themePackage =
            builtins.head
            <| builtins.filter (
              p: builtins.match ".*stylix-kde-theme.*" (baseNameOf p) != null
            ) config.home.packages;

          colorSchemeSlug =
            lib.concatStrings
            <| lib.filter lib.isString
            <| builtins.split "[^a-zA-Z]" config.lib.stylix.colors.scheme;
        in
        "${themePackage}/share/color-schemes/${colorSchemeSlug}.colors";

      "qt5ct/style-colors.conf".text = style-colors;
      "qt6ct/style-colors.conf".text = style-colors;
    };

    qt = {
      qt5ctSettings.Appearance.color_scheme_path = "${config.xdg.configHome}/qt5ct/style-colors.conf";
      qt6ctSettings.Appearance.color_scheme_path = "${config.xdg.configHome}/qt6ct/style-colors.conf";
    };
  };
}
