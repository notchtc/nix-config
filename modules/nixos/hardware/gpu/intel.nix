{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf (lib.elem "intel" config.mama.hardware.gpu.gpus) {
    boot.initrd.kernelModules = [ "i915" ];
    services.xserver.videoDrivers = [ "modesetting" ];

    hardware.graphics = {
      extraPackages = [ pkgs.intel-media-driver ];
      extraPackages32 = [ pkgs.intel.media-driver ];
    };
  };
}
