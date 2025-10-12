{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.mama.profiles.gaming.lutris.enable = lib.mkEnableOption "Lutris" // {
    default = config.mama.profiles.gaming.enable;
  };

  config.environment.systemPackages = lib.mkIf config.mama.profiles.gaming.lutris.enable [
    pkgs.lutris
  ];
}
