{
  config,
  lib,
  pkgs,
  inputs,
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

  nixpkgs.overlays = [ inputs.nix-cachyos-kernel.result.overlays.pinned ];

  boot = {
    enableContainers = false;
    kernelPackages =
      if config.mama.profiles.graphical.enable then
        pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto-x86_64-v3
      else
        pkgs.linuxPackages_hardened;

    kernelModules = lib.mkIf config.mama.profiles.gaming.enable [ "ntsync" ];

    kexec.enable = false;

    initrd = {
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

  system.nixos-init.enable = true;
  security.protectKernelImage = true;
}
