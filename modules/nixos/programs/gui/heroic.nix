{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.mama.programs.heroic.enable = lib.mkEnableOption "Heroic" // {
    default = config.mama.profiles.gaming.enable;
  };

  config.environment.systemPackages = lib.mkIf config.mama.programs.heroic.enable [ pkgs.heroic ];
}
