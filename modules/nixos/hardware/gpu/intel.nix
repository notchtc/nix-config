{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) elem mkIf;
  inherit (config.mama.hardware) gpu;
in
{
  config = mkIf (elem "intel" gpu) {
    boot.initrd.kernelModules = [ "i915" ];
    services.xserver.videoDrivers = [ "modesetting" ];

    hardware.graphics = {
      extraPackages = [ pkgs.intel-media-driver ];
      extraPackages32 = [ pkgs.intel.media-driver ];
    };
  };
}
