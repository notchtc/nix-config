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

        blacklistedKernelModules = [
          # Obscure network protocols
          "dccp" # Datagram Congestion Control Protocol
          "sctp" # Stream Control Transmission Protocol
          "rds" # Reliable Datagram Sockets
          "tipc" # Transparent Inter-Process Communication
          "n-hdlc" # High-level Data Link Control
          "netrom" # NetRom
          "x25" # X.25
          "ax25" # Amateur X.25
          "rose" # ROSE
          "decnet" # DECnet
          "econet" # Econet
          "af_802154" # IEEE 802.15.4
          "ipx" # Internetwork Packet Exchange
          "appletalk" # Appletalk
          "psnap" # SubnetworkAccess Protocol
          "p8022" # IEEE 802.3
          "p8023" # Novell raw IEEE 802.3
          "can" # Controller Area Network
          "atm" # ATM

          # Old or rare or insufficiently audited filesystems
          "adfs" # Active Directory Federation Services
          "affs" # Amiga Fast File System
          "befs" # "Be File System"
          "bfs" # BFS, used by SCO UnixWare OS for the /stand slice
          "cramfs" # compressed ROM/RAM file system
          "cifs" # smb (Common Internet File System)
          "efs" # Extent File System
          "exofs" # EXtended Object File System
          "freevxfs" # Veritas filesystem driver
          "f2fs" # Flash-Friendly File System
          "vivid" # Virtual Video Test Driver (unnecessary)
          "gfs2" # Global File System 2
          "hpfs" # High Performance File System (used by OS/2)
          "hfs" # Hierarchical File System (Macintosh)
          "hfsplus" # " same as above, but with extended attributes
          "jffs2" # Journalling Flash File System (v2)
          "jfs" # Journaled File System - only useful for VMWare sessions
          "ksmbd" # SMB3 Kernel Server
          "minix" # minix fs - used by the minix OS
          "nfsv3" # " (v3)
          "nfsv4" # Network File System (v4)
          "nfs" # Network File System
          "nilfs2" # New Implementation of a Log-structured File System
          "omfs" # Optimized MPEG Filesystem
          "qnx4" # extent-based file system used by the QNX4 and QNX6 OSes
          "qnx6" # ^
          "squashfs" # compressed read-only file system (used by live CDs)
          "sysv" # implements all of Xenix FS, SystemV/386 FS and Coherent FS.
          "udf" # https://docs.kernel.org/5.15/filesystems/udf.html
        ];
      };
    };
}
