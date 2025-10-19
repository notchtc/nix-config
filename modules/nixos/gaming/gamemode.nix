{ config, lib, ... }:
{
  options.mama.profiles.gaming.gamemode.enable = lib.mkEnableOption "Gamemode" // {
    default = config.mama.profiles.gaming.enable;
  };

  config.programs.gamemode = lib.mkIf config.mama.profiles.gaming.gamemode.enable {
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
