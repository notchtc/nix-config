{
  host ? throw "No hostname provided",
  ...
}:
{
  imports = [
    ./blocking.nix
    ./iwd.nix
    ./networkd.nix
    ./resolved.nix
    ./ssh.nix
    ./sysctl.nix
  ];

  networking = {
    hostName = host;
    hostId = builtins.hashString "md5" host |> builtins.substring 0 8;

    nftables.enable = true;

    useDHCP = false;
    useNetworkd = true;

    nameservers = [
      "9.9.9.9#dns.quad9.net"
      "2620:fe::fe#dns.quad9.net"
      "149.112.112.112#dns.quad9.net"
      "2620:fe::9#dns.quad9.net"
    ];
  };
}
