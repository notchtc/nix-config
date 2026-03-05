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
          atkinson-hyperlegible-mono
          atkinson-hyperlegible-next
          corefonts
          noto-fonts-cjk-sans
          noto-fonts-cjk-serif
          noto-fonts-color-emoji
          source-serif
          ;
        nerd-fonts = pkgs.nerd-fonts.symbols-only;
      };

      fontconfig = {
        enable = true;

        defaultFonts = {
          monospace = [
            "Atkinson Hyperlegible Mono"
            "Symbols Nerd Font Mono"
          ];

          sansSerif = [
            "Atkinson Hyperlegible Next"
            "Symbols Nerd Font"
          ];

          serif = [
            "Source Serif 4"
            "Symbols Nerd Font"
          ];

          emoji = [
            "Noto Color Emoji"
            "Symbols Nerd Font"
          ];
        };
      };
    };

    environment.variables = {
      FREETYPE_PROPERTIES = "autofitter:no-stem-darkening=0 autofitter:darkening-parameters=500,0,1000,500,2500,500,4000,0 cff:no-stem-darkening=0 type1:no-stem-darkening=0 t1cid:no-stem-darkening=0";
      QT_NO_SYNTHESIZED_BOLD = 1;
    };
  };
}
