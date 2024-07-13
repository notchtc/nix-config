{ pkgs, ... }:
{
  boot = {
    kernelPackages = pkgs.linuxPackages_cachyos-lto;
    tmp.useTmpfs = true;

    initrd = {
      systemd.enable = true;
      verbose = false;
    };

    consoleLogLevel = 0;
    kernelParams = [
      "quiet"
      "nowatchdog"
      "modprobe.blacklist=iTCO_wdt"
      "rd.systemd.show_status=auto"
      "rd.udev.log_level=3"
      "udev.log_priority=3"

      # amdgpu
      "radeon.si_support=0"
      "radeon.cik_support=0"
      "amdgpu.si_support=1"
      "amdgpu.cik_support=1"
    ];

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
