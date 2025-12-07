{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.mama.profiles.graphical.enable {
    fonts = {
      packages = lib.attrValues {
        inherit (pkgs)
          corefonts
          atkinson-hyperlegible-next
          atkinson-hyperlegible-mono
          noto-fonts-cjk-sans
          noto-fonts-cjk-serif
          noto-fonts-color-emoji
          source-serif
          ;
        nerd-fonts = pkgs.nerd-fonts.symbols-only;
      };

      fontconfig = {
        enable = lib.mkForce true;
        defaultFonts = {
          monospace = [ "Atkinson Hyperlegible Mono" ];
          sansSerif = [ "Atkinson Hyperlegible Next" ];
          serif = [ "Source Serif 4" ];
          emoji = [ "Noto Color Emoji" ];
        };
      };
    };

    boot.plymouth.font = "${pkgs.atkinson-hyperlegible-next}/share/fonts/opentype/AtkinsonHyperlegibleNext-Regular.otf";

    environment.variables = {
      FREETYPE_PROPERTIES = "autofitter:no-stem-darkening=0 autofitter:darkening-parameters=500,0,1000,500,2500,500,4000,0 cff:no-stem-darkening=0 type1:no-stem-darkening=0 t1cid:no-stem-darkening=0";
      QT_NO_SYNTHESIZED_BOLD = 1;
    };
  };
}
