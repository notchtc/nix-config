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
      packages = [
        pkgs.corefonts
        pkgs.nerd-fonts.symbols-only
      ];
    };

    environment.sessionVariables = {
      FREETYPE_PROPERTIES = "cff:no-stem-darkening=0 autofitter:no-stem-darkening=0";
      QT_NO_SYNTHESIZED_BOLD = 1;
    };
  };
}
