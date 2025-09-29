{ config, lib, ... }:
{
  config = lib.mkIf (!config.mama.profiles.server.enable) {
    networking.stevenblack = {
      enable = true;
      block = [
        "fakenews"
        "gambling"
      ];
    };
  };
}
