{ pkgs, lib, ... }:
{
  boot = {
    kernelPackages = lib.mkDefault pkgs.linuxPackages_hardened;

    consoleLogLevel = 0;
    kernelParams = [
      "quiet"
      "rd.systemd.show_status=auto"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
    tmp.useTmpfs = true;

    initrd = {
      systemd.enable = true;
      verbose = false;
    };

    loader = {
      limine = {
        enable = true;
        efiSupport = true;
        enableEditor = true;
        maxGenerations = 10;
      };
    };
  };
}
