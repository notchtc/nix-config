{ config, lib, ... }:
{
  config.hardware.graphics = lib.mkIf config.mama.profiles.graphical.enable {
    enable = true;
    enable32Bit = true;
  };
}
