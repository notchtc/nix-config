{ lib, pkgs, ... }:
{
  fonts = {
    packages = lib.attrValues {
      inherit (pkgs) sarasa-gothic inter;

      nerdfonts = pkgs.nerdfonts.override { fonts = [ "Iosevka" ]; };
    };

    fontconfig = {
      enable = true;
      cache32Bit = true;

      defaultFonts = {
        serif = [ "DejaVu Serif" ];
        sansSerif = [
          "Inter"
          "Sarasa Gothic J"
          "Sarasa Gothic K"
          "Sarasa Gothic SC"
        ];
        monospace = [
          "Sarasa Mono J"
          "Sarasa Mono K"
          "Sarasa Mono SC"
          "Iosevka Nerd Font Mono"
        ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };

  environment.sessionVariables = {
    FREETYPE_PROPERTIES = "cff:no-stem-darkening=0 autofitter:no-stem-darkening=0";
  };
}
