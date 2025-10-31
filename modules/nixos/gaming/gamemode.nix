{ config, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.mama.profiles) gaming;
in
{
  options.mama.profiles.gaming.gamemode.enable = mkEnableOption "Gamemode" // {
    default = gaming.enable;
  };

  config.programs.gamemode = mkIf gaming.gamemode.enable {
    enable = true;
    enableRenice = true;

    settings = {
      general = {
        softrealtime = "auto";
        renice = 17;
      };
    };
  };
}
