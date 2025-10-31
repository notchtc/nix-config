{ config, lib, ... }:
let
  inherit (lib) elem mkIf;
  inherit (config.mama.hardware) gpu;
in
{
  config = mkIf (elem "amd" gpu) {
    services.xserver.videoDrivers = [ "amdgpu" ];
    boot.kernelModules = [ "amdgpu" ];

    hardware.amdgpu = {
      initrd.enable = true;
      legacySupport.enable = true;
    };
  };
}
