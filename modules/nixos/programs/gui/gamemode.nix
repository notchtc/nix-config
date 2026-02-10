{ config, lib, ... }:
{
  options.mama.programs.gamemode.enable = lib.mkEnableOption "Feral GameMode" // {
    default = config.mama.profiles.gaming.enable;
  };

  config.programs.gamemode.enable = lib.mkIf config.mama.programs.gamemode.enable true;
}
