{
  config,
  lib,
  pkgs,
  ...
}:
{
  boot.plymouth = lib.mkIf config.mama.profiles.graphical.enable {
    enable = true;
    font = "${pkgs.atkinson-hyperlegible-next}/share/fonts/opentype/AtkinsonHyperlegibleNext-Regular.otf";
  };
}
