{ config, lib, ... }:
let
  inherit (lib) mkIf;
  server = config.mama.profiles.server.enable;
in
{
  config = mkIf (!server) {
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
