{ config, lib, ... }:
let
  cfg = config.mama.hardware.gpu;
in
{
  config = lib.mkIf (lib.elem "nvidia" cfg.gpus) {
    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.beta;

      nvidiaSettings = false;
      open = true;
      powerManagement.enable = true;
    }
    // lib.optionalAttrs cfg.igpu {
      videoAcceleration = false;
      powerManagement.finegrained = true;
      prime.offload.enable = true;
    };
  };
}
