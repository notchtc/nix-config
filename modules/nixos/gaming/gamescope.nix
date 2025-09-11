{ config, lib, ... }:
{
  config = lib.mkIf config.mama.programs.gaming.gamescope.enable {
    programs.gamescope = {
      enable = true;
      capSysNice = true;
    };
  };
}
