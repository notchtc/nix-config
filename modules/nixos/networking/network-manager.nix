{ config, lib, ... }:
let
  inherit (lib) mkIf;
  server = config.mama.profiles.server.enable;
in
{
  config = mkIf (!server) {
    networking.networkmanager = {
      enable = true;
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
  };
}
