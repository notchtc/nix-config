{ config, lib, ... }:
{
  config = lib.mkIf (!config.mama.profiles.server.enable) {
    systemd.services.NetworkManager-wait-online.enable = false;
    networking.networkmanager = {
      enable = true;
      dns = "systemd-resolved";
      wifi = {
        backend = "iwd";
        powersave = true;
      };
    };
  };
}
