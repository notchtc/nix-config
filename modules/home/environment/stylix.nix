{
  config,
  lib,
  profiles,
  ...
}:
{
  config = lib.mkIf profiles.graphical.enable {
    stylix = {
      targets = {
        blender.enable = false;
        forge.enable = false;
        gdu.enable = false;
        gtk.flatpakSupport.enable = false;
        xresources.enable = false;
      };
    };

    xdg.configFile.kdeglobals.source =
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
  };
}
