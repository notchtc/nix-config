{ config, lib, ... }:
{
  options.mama.hardware.bluetooth.enable = lib.mkEnableOption "Enable bluetooth";

  config.hardware.bluetooth = lib.mkIf config.mama.hardware.bluetooth.enable {
    enable = true;
    powerOnBoot = false;
  };
}
