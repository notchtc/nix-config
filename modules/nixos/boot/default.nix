{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./blacklist.nix
    ./loader.nix
    ./kernelParams.nix
    ./plymouth.nix
    ./sysctl.nix
    ./sysfs.nix
  ];

  system.nixos-init.enable = true;
  boot = {
    enableContainers = false;
    kernelPackages =
      if config.mama.profiles.graphical.enable then
        pkgs.linuxPackages_zen
      else
        pkgs.linuxPackages_hardened;

    kernelModules = lib.mkIf config.mama.profiles.gaming.enable [ "ntsync" ];

    kexec.enable = false;

    initrd = {
      systemd.enable = true;

      verbose = false;

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

  security.protectKernelImage = true;
}
