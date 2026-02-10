{ config, lib, ... }:
{
  options.mama.programs.gamescope.enable = lib.mkEnableOption "Gamescope" // {
    default = config.mama.profiles.gaming.enable;
  };

  config.programs.gamescope = lib.mkIf config.mama.programs.gamescope.enable {
    enable = true;
    capSysNice = true;
  };
}
