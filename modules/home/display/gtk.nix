{
  lib,
  osConfig,
  packages,
  pkgs,
  system,
  ...
}:
{
  gtk = lib.mkIf osConfig.mama.profiles.graphical.enable {
    enable = true;
    colorScheme = "dark";

    cursorTheme = {
      name = "Hackneyed";
      package = pkgs.hackneyed;
    };

    font = {
      name = "Iosevka Aile";
      package = pkgs.iosevka-bin.override { variant = "Aile"; };
      size = 11;
    };

    iconTheme = {
      name = "Oxygen";
      package = pkgs.kdePackages.oxygen-icons;
    };

    theme = {
      name = "Redmond97 SE Dangerous Creatures";
      package = packages.redmond97se-creatures.result.${system};
    };
  };

}
