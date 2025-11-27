{ config, lib, ... }:
let
  inherit (config.mama.profiles) gaming;
in
{
  options.mama.profiles.gaming.gamemode.enable = lib.mkEnableOption "Gamemode" // {
    default = gaming.enable;
  };

  config.programs.gamemode = lib.mkIf gaming.gamemode.enable {
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
