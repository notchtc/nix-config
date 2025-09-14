{ config, ... }:
{
  imports = [
    ./blocking.nix
    ./network-manager.nix
    ./resolved.nix
    ./ssh.nix
    ./sysctl.nix
  ];

  networking = {
    hostId = builtins.substring 0 8 (builtins.hashString "md5" config.networking.hostName);

    useDHCP = false;
    useNetworkd = true;

    nftables.enable = true;

    nameservers = [
      "9.9.9.9#dns.quad9.net"
      "2620:fe::fe#dns.quad9.net"
      "149.112.112.112#dns.quad9.net"
      "2620:fe::9#dns.quad9.net"
    ];
  };

  systemd.services = {
    systemd-networkd.stopIfChanged = false;
    systemd-resolved.stopIfChanged = false;
  };
}
