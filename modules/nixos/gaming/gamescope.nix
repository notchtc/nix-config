{ config, lib, ... }:
{
  options.mama.profiles.gaming.gamescope.enable = lib.mkEnableOption "Gamescope" // {
    default = config.mama.profiles.gaming.enable;
  };

  config.programs.gamescope = lib.mkIf config.mama.profiles.gaming.gamescope.enable {
    enable = true;
    capSysNice = true;
  };
}
