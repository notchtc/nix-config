{ config, lib, ... }:
{
  config = lib.mkIf (lib.elem "amd" config.mama.hardware.gpu) {
    services.xserver.videoDrivers = [ "amdgpu" ];
    boot.kernelModules = [ "amdgpu" ];

    hardware.amdgpu = {
      initrd.enable = true;
      legacySupport.enable = true;
    };
  };
}
