{ pkgs, lib, ... }:
{
  boot = {
    kernelPackages = lib.mkDefault pkgs.linuxPackages_hardened;

    kernelParams = [
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
      timeout = 5;
      limine = {
        enable = true;
        efiSupport = true;
        enableEditor = false;
        maxGenerations = 10;
      };
    };
  };
}
