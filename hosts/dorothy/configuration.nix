{
  inputs,
  flake,
  lib,
  ...
}:
{
  imports = [
    inputs.disko.nixosModules.disko
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    flake.nixosModules.amdgpu
    flake.nixosModules.laptop
    flake.nixosModules.gaming
    flake.nixosModules.user-chtc
    ./disko.nix
  ];

  boot = {
    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "ahci"
        "usb_storage"
        "sd_mod"
      ];
      kernelModules = [ "dm-snapshot" ];
    };
    kernelModules = [ "kvm-intel" ];
  };

  networking.hostName = "dorothy";
  nixpkgs.hostPlatform = "x86_64-linux";

  services = {
    undervolt = {
      enable = true;
      coreOffset = -120;
    };
    displayManager.autoLogin.user = "chtc";
  };
  systemd.services.ModemManager.enable = lib.mkForce false;
}
