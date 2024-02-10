# Edit this configuration file to define what should be installed on # your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  lib,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ../../modules/nixos/desktops/plasma.nix
    ../../modules/nixos/programs/steam.nix
    ./hardware-configuration.nix
    ./disko.nix
  ];

  boot = {
    kernelParams = ["radeon.si_support=0" "radeon.cik_support=0" "amdgpu.si_support=1" "amdgpu.cik_support=1"];
    kernelModules = ["i915" "amdgpu"];
  };

  networking = {
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };
    nameservers = ["45.90.28.26" "45.90.30.26"];
  };

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = lib.attrValues {
        inherit
          (pkgs)
          intel-media-driver
          libvdpau-va-gl
          ;
      };
      extraPackages32 = lib.attrValues {
        inherit
          (pkgs.pkgsi686Linux)
          intel-media-driver
          libvdpau-va-gl
          ;
      };
    };
  };
}
