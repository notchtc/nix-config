{ config, lib, ... }:
let
  inherit (config.mama.profiles) gaming;
in
{
  options.mama.profiles.gaming.gamemode.enable = lib.mkEnableOption "Feral GameMode" // {
    default = gaming.enable;
  };

  config.programs.gamemode.enable = lib.mkIf gaming.gamemode.enable true;
}
