{ lib, pkgs, ... }:
{
  imports = [
    ./niri.nix
    ./pipewire.nix
    ./stylix.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  hardware.amdgpu.legacySupport.enable = true;
  time.timeZone = "Europe/Warsaw";

  fonts = {
    packages = lib.attrValues { inherit (pkgs) corefonts sarasa-gothic; };
    enableDefaultPackages = true;
  };

  programs.appimage = {
    enable = true;
    binfmt = true;
  };
}
