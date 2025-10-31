{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) attrValues mkIf;
  graphical = config.mama.profiles.graphical.enable;
in
{
  config = mkIf graphical {
    fonts = {
      enableDefaultPackages = true;
      packages = attrValues {
        inherit (pkgs) corefonts sarasa-gothic;
        nerd-fonts = pkgs.nerd-fonts.symbols-only;
      };

      fontconfig = {
        enable = true;

        defaultFonts = {
          monospace = [ "Sarasa Term J" ];
          sansSerif = [ "Sarasa UI J" ];
          serif = [ "DejaVu Serif" ];
          emoji = [ "Noto Color Emoji" ];
        };
      };
    };

    boot.plymouth.font = "${pkgs.sarasa-gothic}/share/fonts/truetype/Sarasa-Regular.ttc";
    console = {
      font = "ter-v24n";
      packages = [ pkgs.terminus_font ];
    };

    environment.variables = {
      FREETYPE_PROPERTIES = "autofitter:no-stem-darkening=0 autofitter:darkening-parameters=500,0,1000,500,2500,500,4000,0 cff:no-stem-darkening=0 type1:no-stem-darkening=0 t1cid:no-stem-darkening=0";
      QT_NO_SYNTHESIZED_BOLD = 1;
    };
  };
}
