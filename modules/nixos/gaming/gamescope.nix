{ config, lib, ... }:
let
  inherit (config.mama.profiles) gaming;
in
{
  options.mama.profiles.gaming.gamescope.enable = lib.mkEnableOption "Gamescope" // {
    default = gaming.enable;
  };

  config.programs.gamescope = lib.mkIf gaming.gamescope.enable {
    enable = true;
    capSysNice = true;
  };
}
