{ config, lib, ... }:
{
  systemd = {
    network = {
      enable = true;
      wait-online.enable = false;

      links = {
        "eth" = {
          matchConfig.Type = "ether";
          linkConfig.MACAddressPolicy = lib.mkIf (!config.mama.profiles.server.enable) "random";
        };
      };

      networks = {
        "20-eth" = {
          matchConfig = {
            Type = "ether";
            Driver = "!tun";
            Name = "!veth* !vnet*";
          };

          networkConfig = {
            DHCP = "yes";
            IPv4Forwarding = "yes";
            IPv6AcceptRA = "no";
            IPv6Forwarding = "yes";
            IPv6PrivacyExtensions = "yes";
          };

          dhcpV4Config = {
            Anonymize = lib.mkIf (!config.mama.profiles.server.enable) "yes";
            RouteMetric = 512;
          };
          dhcpV6Config = {
            WithoutRA = "solicit";
            RouteMetric = 512;
          };
        };

        "30-wlan" = {
          matchConfig.Type = "wlan";

          networkConfig = {
            DHCP = "yes";
            IPv4Forwarding = "yes";
            IPv6AcceptRA = "no";
            IPv6Forwarding = "yes";
            IPv6PrivacyExtensions = "yes";
            IgnoreCarrierLoss = "5s";
          };

          dhcpV4Config = {
            Anonymize = "yes";
            RouteMetric = 1024;
          };
          dhcpV6Config = {
            WithoutRA = "solicit";
            RouteMetric = 1024;
          };
        };
      };
    };

    services.systemd-networkd.stopIfChanged = false;
  };
}
