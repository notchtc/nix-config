{ config, pkgs, ... }:
{
  boot = {
    kernelPackages =
      if config.isDesktop then pkgs.linuxPackages_xanmod else pkgs.linuxPackages_hardened;

    consoleLogLevel = 0;
    kernelParams = [
      "quiet"
      "rd.systemd.show_status=auto"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
    tmp.cleanOnBoot = true;

    initrd = {
      systemd.enable = true;
      verbose = false;
    };

    loader = {
      limine = {
        enable = true;
        efiSupport = true;
        enableEditor = true;
      };
    };
  };
}
