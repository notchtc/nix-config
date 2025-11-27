{ config, lib, ... }:
{
  networking.networkmanager = {
    enable = true;
    ethernet.macAddress = lib.mkIf config.mama.profiles.server.enable "preserve";
    dns = "systemd-resolved";
    wifi = {
      backend = "iwd";
      powersave = true;
    };
  };

  environment.etc."NetworkManager/system-connections".source = "/persist/NetworkManager/";
  systemd = {
    services.NetworkManager-wait-online.enable = false;
    tmpfiles.rules = [ "d /persist/NetworkManager 0755 root root - -" ];
  };
}
