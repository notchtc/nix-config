{ pkgs, ... }:
{
  boot = {
    tmp.cleanOnBoot = true;
    kernelPackages = pkgs.linuxPackages_cachyos-lto;

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
    ];

    kernel.sysctl = {
      "vm.max_map_count" = 1048576;
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

    plymouth = {
      enable = true;
      theme = "breeze";
      font = "${pkgs.iosevka}/share/fonts/truetype/Iosevka-Regular.ttf";
    };
  };
}
