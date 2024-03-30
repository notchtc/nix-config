{ pkgs, ... }:
{
  boot = {
    tmp.cleanOnBoot = true;
    kernelPackages = pkgs.linuxPackages_cachyos-lto;

    initrd = {
      systemd.enable = true;
      verbose = false;
    };

    consoleLogLevel = 3;
    kernelParams = [
      "quiet"
      "udev.log_level=3"
    ];

    kernel.sysctl = {
      "vm.swappiness" = 10;
      "vm.max_map_count" = 1048576;
    };

    loader = {
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
