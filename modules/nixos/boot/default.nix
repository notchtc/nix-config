{ config, pkgs, ... }:
{
  imports = [ ./loader.nix ];

  system.nixos-init.enable = true;
  boot = {
    kernelPackages =
      if config.mama.profiles.graphical.enable then
        pkgs.linuxPackages_xanmod_latest
      else
        pkgs.linuxPackages_hardened;

    kernelParams = [
      "systemd.show_status=auto"
      "rd.systemd.show_status=auto"

      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];

    kernel = {
      sysctl = {
        "vm.dirty_bytes" = 268435456;
        "vm.dirty_background_bytes" = 134217728;
        "vm.max_map_count" = 2147483642;
      };
      sysfs = {
        kernel.mm.transparent_hugepage = {
          enabled = "always";
          defrag = "defer";
          shmem_enabled = "within_size";
        };
      };
    };

    initrd = {
      systemd.enable = true;

      verbose = false;

      availableKernelModules = [
        "ahci"
        "sd_mod"
        "usbhid"
        "xhci_pci"
      ];

      compressorArgs = [
        "-19"
        "-T0"
      ];
    };

    tmp = {
      useTmpfs = true;
      tmpfsHugeMemoryPages = "within_size";
    };
  };

  systemd.package = pkgs.systemd.overrideAttrs (prevAttrs: {
    patches = (prevAttrs.patches or [ ]) ++ [
      (pkgs.fetchpatch2 {
        name = "dot.diff";
        url = "https://github.com/systemd/systemd/commit/e82aae6ac01e8461ab5b2500c3a38a92ef24621e.diff?full_index=1";
        hash = "sha256-pEuag/7iSvsqjDIYMiXU+5hvr+5Xmrp7Bknt4XUIFpc=";
      })
    ];
  });
}
