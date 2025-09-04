{ inputs, nixosModules, ... }:
{
  imports = [
    "${inputs.nixos-hardware.result}/common/cpu/intel/skylake"
    "${inputs.nixos-hardware.result}/common/gpu/amd"

    nixosModules.desktop
    nixosModules.gaming
    nixosModules.laptop

    ./disko.nix
  ];

  boot = {
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

  nixpkgs.hostPlatform = "x86_64-linux";
}
