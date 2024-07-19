{ lib, pkgs, ... }:
{
  fonts = {
    packages = lib.attrValues {
      inherit (pkgs)
        iosevka
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
        ;

      nerdfonts = pkgs.nerdfonts.override { fonts = [ "Iosevka" ]; };
    };

    fontconfig = {
      enable = true;
      cache32Bit = true;

      defaultFonts = {
        serif = [ "DejaVu Serif" ];
        sansSerif = [ "Iosevka Aile" ];
        monospace = [ "Iosevka Nerd Font Mono" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };

  environment.sessionVariables = {
    FREETYPE_PROPERTIES = "cff:no-stem-darkening=0 autofitter:no-stem-darkening=0";
  };
}
