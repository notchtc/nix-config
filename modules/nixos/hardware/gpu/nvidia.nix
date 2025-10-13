{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf (lib.elem "nvidia" config.mama.hardware.gpu) {
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
