{ pkgs, ... }:
{
  boot = {
    kernelPackages = pkgs.linuxPackages_cachyos-lto;

    consoleLogLevel = 0;
    kernelParams = [
      "quiet"
      "nowatchdog"
      "modprobe.blacklist=iTCO_wdt"
      "rd.systemd.show_status=auto"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];

    initrd = {
      systemd.enable = true;
      verbose = false;
    };
    tmp.useTmpfs = true;

    loader = {
      timeout = 0;
      efi.canTouchEfiVariables = true;

      systemd-boot = {
        enable = true;
        configurationLimit = 3;
        consoleMode = "auto";
        editor = false;
      };
    };
  };
}
