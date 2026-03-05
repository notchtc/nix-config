{
  config,
  lib,
  profiles,
  ...
}:
{
  config = lib.mkIf profiles.graphical.enable {
    home.sessionVariables.QT_STYLE_OVERRIDE = lib.mkForce "";

    qt =
      let
        qtctSettings = {
          Appearance = {
            color_scheme_path = "${config.xdg.configHome}/qt5ct/colors/noctalia.conf";
            custom_palette = true;
            standard_dialogs = "default";
            style = "Adwaita-Dark";
          };

          Fonts = {
            fixed = "\"Atkinson Hyperlegible Mono,12\"";
            general = "\"Atkinson Hyperlegible Next,12\"";
          };
        };
      in
      {
        enable = true;
        platformTheme.name = "qtct";
        style.name = "adwaita";

        qt5ctSettings = qtctSettings;
        qt6ctSettings = qtctSettings;
      };

    xdg.configFile."kdeglobals".text = ''
      [ColorEffects:Disabled]
      ChangeSelectionColor=
      Color=#222222
      ColorAmount=0
      ColorEffect=0
      ContrastAmount=0.65
      ContrastEffect=1
      Enable=
      IntensityAmount=0.1
      IntensityEffect=2

      [ColorEffects:Inactive]
      ChangeSelectionColor=true
      Color=#1e1e1e
      ColorAmount=0.025
      ColorEffect=2
      ContrastAmount=0.1
      ContrastEffect=2
      Enable=false
      IntensityAmount=0
      IntensityEffect=0

      [Colors:Button]
      BackgroundAlternate=#212121
      BackgroundNormal=#282828
      DecorationFocus=#3584e4
      DecorationHover=#3584e4
      ForegroundActive=#3584e4
      ForegroundInactive=#ffffff
      ForegroundLink=#1b467c
      ForegroundNegative=#c01c28
      ForegroundNeutral=#ffffff
      ForegroundNormal=#ffffff
      ForegroundPositive=#ffffff
      ForegroundVisited=#d5e4f6

      [Colors:Complementary]
      BackgroundAlternate=#212121
      BackgroundNormal=#242424
      DecorationFocus=#3584e4
      DecorationHover=#3584e4
      ForegroundActive=#3584e4
      ForegroundInactive=#ffffff
      ForegroundLink=#1b467c
      ForegroundNegative=#c01c28
      ForegroundNeutral=#ffffff
      ForegroundNormal=#d2e4f9
      ForegroundPositive=#ffffff
      ForegroundVisited=#d5e4f6

      [Colors:Header]
      BackgroundAlternate=#242424
      BackgroundNormal=#1e1e1e
      DecorationFocus=#3584e4
      DecorationHover=#3584e4
      ForegroundActive=#3584e4
      ForegroundInactive=#ffffff
      ForegroundLink=#1b467c
      ForegroundNegative=#c01c28
      ForegroundNeutral=#ffffff
      ForegroundNormal=#ffffff
      ForegroundPositive=#ffffff
      ForegroundVisited=#d5e4f6

      [Colors:Header][Inactive]
      BackgroundAlternate=#1e1e1e
      BackgroundNormal=#242424
      DecorationFocus=#3584e4
      DecorationHover=#3584e4
      ForegroundActive=#3584e4
      ForegroundInactive=#ffffff
      ForegroundLink=#1b467c
      ForegroundNegative=#c01c28
      ForegroundNeutral=#ffffff
      ForegroundNormal=#ffffff
      ForegroundPositive=#ffffff
      ForegroundVisited=#d5e4f6

      [Colors:Selection]
      BackgroundAlternate=#212121
      BackgroundNormal=#3584e4
      DecorationFocus=#3584e4
      DecorationHover=#3584e4
      ForegroundActive=#ffffff
      ForegroundInactive=#ffffff
      ForegroundLink=#1b467c
      ForegroundNegative=#490409
      ForegroundNeutral=#b39898
      ForegroundNormal=#ffffff
      ForegroundPositive=#b39898
      ForegroundVisited=#d5e4f6

      [Colors:Tooltip]
      BackgroundAlternate=#242424
      BackgroundNormal=#1e1e1e
      DecorationFocus=#3584e4
      DecorationHover=#3584e4
      ForegroundActive=#3584e4
      ForegroundInactive=#ffffff
      ForegroundLink=#1b467c
      ForegroundNegative=#c01c28
      ForegroundNeutral=#ffffff
      ForegroundNormal=#ffffff
      ForegroundPositive=#ffffff
      ForegroundVisited=#d5e4f6

      [Colors:View]
      BackgroundAlternate=#1e1e1e
      BackgroundNormal=#242424
      DecorationFocus=#d2e4f9
      DecorationHover=#ffffff
      ForegroundActive=#3584e4
      ForegroundInactive=#ffffff
      ForegroundLink=#1b467c
      ForegroundNegative=#c01c28
      ForegroundNeutral=#ffffff
      ForegroundNormal=#ffffff
      ForegroundPositive=#ffffff
      ForegroundVisited=#d5e4f6

      [Colors:Window]
      BackgroundAlternate=#042f62
      BackgroundNormal=#1e1e1e
      DecorationFocus=#3584e4
      DecorationHover=#3584e4
      ForegroundActive=#3584e4
      ForegroundInactive=#ffffff
      ForegroundLink=#1b467c
      ForegroundNegative=#c01c28
      ForegroundNeutral=#ffffff
      ForegroundNormal=#ffffff
      ForegroundPositive=#ffffff
      ForegroundVisited=#d5e4f6

      [General]
      ColorScheme=noctalia

      [KDE]
      contrast=4
      frameContrast=0.2

      [WM]
      activeBackground=4,47,98
      activeBlend=210,228,249
      activeForeground=210,228,249
      inactiveBackground=36,36,36
      inactiveBlend=255,255,255
      inactiveForeground=255,255,255
    '';
  };
}
