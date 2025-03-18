{ pkgs, ... }:
{
  boot = {
    kernelPackages = pkgs.linuxPackages_hardened;

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

  hardware.enableRedistributableFirmware = true;
}
