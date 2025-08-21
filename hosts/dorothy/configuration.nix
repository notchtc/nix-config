{
  inputs,
  lib,
  nixosModules,
  ...
}:
{
  imports = [
    "${inputs.nixos-hardware.result}/common/cpu/intel/skylake"
    "${inputs.nixos-hardware.result}/common/gpu/amd"

    inputs.disko.result.nixosModules.disko
    nixosModules.common
    nixosModules.desktop
    nixosModules.gaming
    nixosModules.laptop
    nixosModules.user-chtc

    ./disko.nix
  ];

  boot = {
    initrd.availableKernelModules = [
      "xhci_pci"
      "ahci"
      "usbhid"
      "sd_mod"
    ];
    initrd.kernelModules = [ "dm-snapshot" ];
    kernelModules = [ "kvm-intel" ];
  };

  services = {
    undervolt = {
      enable = true;
      coreOffset = -119;
    };
    displayManager.autoLogin.user = "chtc";
  };

  hardware.enableRedistributableFirmware = true;
  nix.settings.max-jobs = 4;
  nixpkgs.hostPlatform = "x86_64-linux";

  fileSystems."/home" = {
    device = lib.mkForce "/dev/mapper/pool-root";
    options = lib.mkForce [
      "subvol=home"
      "compress=zstd"
      "noatime"
      "exec"
      "nosuid"
      "nodev"
    ];
  };
}
