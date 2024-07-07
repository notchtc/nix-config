{ pkgs, lib, ... }:
{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;

    extraPackages = lib.attrValues {
      inherit (pkgs) intel-media-driver libvdpau-va-gl;
    };

    extraPackages32 = lib.attrValues {
      inherit (pkgs.pkgsi686Linux) intel-media-driver libvdpau-va-gl;
    };
  };
}
