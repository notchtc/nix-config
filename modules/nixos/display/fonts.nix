{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.mama.profiles.graphical.enable {
    fonts = {
      enableDefaultPackages = true;
      packages = lib.attrValues {
        inherit (pkgs) corefonts iosevka-bin noto-fonts-cjk-sans;

        iosevka-aile = pkgs.iosevka-bin.override { variant = "Aile"; };
        iosevka-etoile = pkgs.iosevka-bin.override { variant = "Etoile"; };
        nerd-fonts = pkgs.nerd-fonts.symbols-only;
      };

      fontconfig = {
        enable = lib.mkForce true;
        defaultFonts = {
          monospace = [ "Iosevka Term" ];
          sansSerif = [ "Iosevka Aile" ];
          serif = [ "Iosevka Etoile" ];
          emoji = [ "Noto Color Emoji" ];
        };
      };
    };

    boot.plymouth.font = "${pkgs.iosevka-bin}/share/fonts/truetype/Iosevka-Regular.ttc";

    environment.variables = {
      FREETYPE_PROPERTIES = "autofitter:no-stem-darkening=0 autofitter:darkening-parameters=500,0,1000,500,2500,500,4000,0 cff:no-stem-darkening=0 type1:no-stem-darkening=0 t1cid:no-stem-darkening=0";
      QT_NO_SYNTHESIZED_BOLD = 1;
    };
  };
}
