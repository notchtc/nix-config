{ config, lib, ... }:
{
  systemd.services.NetworkManager-wait-online.enable = false;
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
