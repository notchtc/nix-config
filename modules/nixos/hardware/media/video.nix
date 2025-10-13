{ config, lib, ... }:
{
  config = lib.mkIf config.mama.profiles.graphical.enable {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}
