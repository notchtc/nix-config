{
  config.modules.nixos.networking =
    { config, lib, ... }:
    let
      inherit (builtins) hashString substring;
      inherit (lib.modules) mkIf;
    in
    {
      networking = {
        hostId = hashString "md5" config.networking.hostName |> substring 0 8;

        nftables.enable = true;
        useDHCP = false;
        useNetworkd = true;

        nameservers = [
          "149.112.112.112#dns.quad9.net"
          "2620:fe::9#dns.quad9.net"
          "2620:fe::fe#dns.quad9.net"
          "9.9.9.9#dns.quad9.net"
        ];
      };

      systemd.network = {
        enable = true;

        links."eth" = {
          matchConfig.Type = "ether";
          linkConfig.MACAddressPolicy = mkIf (!config.xdg.portal.enable) "random";
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
              Anonymize = mkIf (!config.xdg.portal.enable) "yes";
              RouteMetric = 512;
            };
            dhcpV6Config = {
              WithoutRA = "solicit";
            };

            ipv6AcceptRAConfig = {
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
            };

            ipv6AcceptRAConfig = {
              RouteMetric = 1024;
            };
          };
        };
      };

      networking.wireless.iwd = {
        enable = true;

        settings = {
          Settings.AutoConnect = true;
          General.AddressRandomization = "network";
        };
      };

      services.resolved = {
        enable = true;
        settings.Resolve = {
          DNSOverTLS = "opportunistic";
          DNSSEC = "allow-downgrade";
          LLMNR = "false";
        };
      };
    };
}
