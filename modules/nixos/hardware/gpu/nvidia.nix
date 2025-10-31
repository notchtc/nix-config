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
  config = mkIf (elem "nvidia" gpu) {
    services.xserver.videoDrivers = [ "nvidia" ];

    hardware = {
      nvidia = {
        package = config.boot.kernelPackages.nvidiaPackages.beta;

        open = true;
        modesetting.enable = true;
        nvidiaSettings = false;

        powerManagement = {
          enable = true;
          finegrained = true;
        };
      };

      graphics = {
        extraPackages = [ pkgs.nvidia-vaapi-driver ];
        extraPackages32 = [ pkgs.pkgsi686Linux.nvidia-vaapi-driver ];
      };
    };
  };
}
