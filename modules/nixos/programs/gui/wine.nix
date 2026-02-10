{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.mama.programs.wine.enable = lib.mkEnableOption "Wine";

  config.environment.systemPackages = lib.mkIf config.mama.programs.wine.enable [
    pkgs.winetricks
    pkgs.wineWow64Packages.waylandFull
  ];
}
