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
        branch = "bleeding_edge";
        nvidiaSettings = false;
        open = true;
        powerManagement.enable = true;
      };
    };

    gpu-nvidia-igpu = {
      hardware.nvidia = {
        videoAcceleration = false;
        powerManagement.finegrained = true;
        prime.offload = {
          enable = true;
          enableOffloadCmd = true;
        };
      };
    };
  };
}
