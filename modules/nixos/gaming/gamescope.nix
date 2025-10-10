{ config, lib, ... }:
{
  programs.gamescope = lib.mkIf config.mama.programs.gaming.gamescope.enable {
    enable = true;
    capSysNice = true;
  };
}
