{
  networking = {
    useDHCP = false;
    useNetworkd = true;

    nameservers = [
      "9.9.9.9#dns.quad9.net"
      "2620:fe::fe#dns.quad9.net"
      "149.112.112.112#dns.quad9.net"
      "2620:fe::9#dns.quad9.net"
    ];

    networkmanager = {
      enable = true;
      wifi = {
        backend = "iwd";
        powersave = true;
      };
    };

    nftables.enable = true;
  };

  services.resolved = {
    enable = true;
    dnsovertls = "true";
    dnssec = "false";
  };

  boot.kernel.sysctl = {
    "net.core.default_qdisc" = "cake";
    "net.core.netdev_max_backlog" = 250000;
    "net.core.rmem_default" = 8388608;
    "net.core.wmem_default" = 8388608;
    "net.core.rmem_max" = 536870912;
    "net.core.wmem_max" = 536870912;
    "net.core.optmem_max" = 40960;
    "net.ipv4.tcp_congestion_control" = "bbr";
    "net.ipv4.tcp_synack_retries" = 5;
    "net.ipv4.ip_local_port_range" = "1024 65535";
    "net.ipv4.tcp_slow_start_after_idle" = 0;
    "net.ipv4.tcp_mtu_probing" = 1;
    "net.ipv4.tcp_base_mss" = 1024;
    "net.ipv4.tcp_rmem" = "8192 262144 536870912";
    "net.ipv4.tcp_wmem" = "4096 16384 536870912";
    "net.ipv4.tcp_adv_win_scale" = "-2";
    "net.ipv4.tcp_notsent_lowat" = 131072;
  };
}
