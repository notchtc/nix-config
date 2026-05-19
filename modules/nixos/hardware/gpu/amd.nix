{ config, lib, ... }:
{
  config = lib.mkIf (lib.elem "amd" config.mama.hardware.gpus) {
    services.xserver.videoDrivers = [ "amdgpu" ];
    boot.kernelModules = [ "amdgpu" ];

    hardware.amdgpu.legacySupport.enable = true;
  };
}
