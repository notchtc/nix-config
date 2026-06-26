{
  config.modules.nixos.kernel =
    {
      config,
      inputs,
      lib,
      pkgs,
      ...
    }:
    let
      inherit (lib.modules) mkIf;
    in
    {
      nixpkgs.overlays = [ inputs.nix-cachyos-kernel.result.overlays.pinned ];

      security.protectKernelImage = true;

      boot = {
        kernelPackages =
          if config.xdg.portal.enable then
            pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto-x86_64-v3
          else
            pkgs.linuxPackages_hardened;

        zfs.package = mkIf config.xdg.portal.enable config.boot.kernelPackages.zfs_cachyos;

        initrd = {
          verbose = false;
          compressorArgs = [
            "-19"
            "-T0"
          ];
        };

        kernelParams = [
          "nohz_full=4-7"

          "noresume"
          "nohibernate"

          "rootflags=noatime"

          "systemd.show_status=auto"
          "rd.systemd.show_status=auto"

          "rd.udev.log_level=3"
          "udev.log_priority=3"

          "fbcon=nodefer"
        ];

        kernel = {
          sysctl = {
            "vm.dirty_bytes" = 268435456;
            "vm.dirty_background_bytes" = 134217728;
            "vm.max_map_count" = 2147483642;

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
            "net.ipv4.tcp_adv_win_scale" = "-2";
            "net.ipv4.tcp_base_mss" = 1024;
            "net.ipv4.tcp_fastopen" = 3;
            "net.ipv4.tcp_mtu_probing" = 1;
            "net.ipv4.tcp_notsent_lowat" = 131072;
            "net.ipv4.tcp_rmem" = "8192 262144 536870912";
            "net.ipv4.tcp_slow_start_after_idle" = 0;
            "net.ipv4.tcp_tw_reuse" = 1;
            "net.ipv4.tcp_wmem" = "4096 16384 536870912";
          };

          sysfs = {
            kernel.mm.transparent_hugepage = {
              enabled = "always";
              defrag = "defer";
              shmem_enabled = "within_size";
            };
          };
        };
      };
    };
}
