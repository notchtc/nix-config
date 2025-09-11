{ config, lib, ... }:
{
  networking.networkmanager = {
    enable = true;
    dns = "systemd-resolved";
    ethernet.macAddress = lib.mkIf config.mama.profiles.server.enable "preserve";
    wifi = {
      backend = "iwd";
      powersave = true;
    };
  };
}
