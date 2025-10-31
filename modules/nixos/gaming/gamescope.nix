{ config, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.mama.profiles) gaming;
in
{
  options.mama.profiles.gaming.gamescope.enable = mkEnableOption "Gamescope" // {
    default = gaming.enable;
  };

  config.programs.gamescope = mkIf gaming.gamescope.enable {
    enable = true;
    capSysNice = true;
  };
}
