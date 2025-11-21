{
  config,
  host ? throw "No hostname provided",
  lib,
  ...
}:
let
  inherit (lib) mkIf;
  server = config.mama.profiles.server.enable;
in
{
  imports = [
    ./blocking.nix
    ./network-manager.nix
    ./resolved.nix
    ./ssh.nix
    ./sysctl.nix
  ];

  networking = {
    hostName = host;
    hostId = builtins.hashString "md5" host |> builtins.substring 0 8;

    useDHCP = false;
    useNetworkd = mkIf server true;

    nftables.enable = true;

    nameservers = [
      "9.9.9.9#dns.quad9.net"
      "2620:fe::fe#dns.quad9.net"
      "149.112.112.112#dns.quad9.net"
      "2620:fe::9#dns.quad9.net"
    ];
  };

  services.snowflake-proxy.enable = true;

  systemd = {
    network.wait-online.enable = false;
    services = {
      systemd-networkd.stopIfChanged = false;
      systemd-resolved.stopIfChanged = false;
    };
  };
}
