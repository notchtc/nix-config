{
  config.modules.nixos = {
    gpu-intel = { pkgs, ... }: {
      hardware.graphics = {
        extraPackages = [ pkgs.intel-media-driver ];
        extraPackages32 = [ pkgs.intel-media-driver ];
      };
    };

    gpu-nvidia = {
      services.xserver.videoDrivers = [ "nvidia" ];

      hardware.nvidia = {
        nvidiaSettings = false;
        open = true;
        powerManagement.enable = true;
      };
    };

    gpu-nvidia-igpu = {
      hardware.nvidia = {
        dynamicBoost.enable = true;
        powerManagement.finegrained = true;
        videoAcceleration = false;
        prime.offload = {
          enable = true;
        };
      };
    };
  };
}
