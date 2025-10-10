{ config, lib, ... }:
{
  networking.stevenblack = lib.mkIf (!config.mama.profiles.server.enable) {
    enable = true;
    block = [
      "fakenews"
      "gambling"
    ];
  };
}
