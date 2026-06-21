{
  config.modules.nixos = {
    gpu-amd = {
      services.xserver.videoDrivers = [ "amdgpu" ];
      boot.kernelModules = [ "amdgpu" ];

      hardware.amdgpu.legacySupport.enable = true;
    };

    gpu-intel = { pkgs, ... }: {
      boot.initrd.kernelModules = [ "i915" ];
      services.xserver.videoDrivers = [ "modesetting" ];

      hardware.graphics = {
        extraPackages = [ pkgs.intel-media-driver ];
        extraPackages32 = [ pkgs.intel-media-driver ];
      };
    };

    gpu-nvidia =
      { config, lib, ... }:
      let
        inherit (lib.attrsets) optionalAttrs;
        inherit (lib.options) mkEnableOption;
      in
      {
        options.hardware.igpuPresent = mkEnableOption "Enable when using iGPU besides NVIDIA";

        config = {
          services.xserver.videoDrivers = [ "nvidia" ];

          hardware.nvidia = {
            branch = "bleeding_edge";
            nvidiaSettings = false;
            open = true;
            powerManagement.enable = true;
          }
          // optionalAttrs config.hardware.igpuPresent {
            videoAcceleration = false;
            powerManagement.finegrained = true;
            prime.offload = {
              enable = true;
              enableOffloadCmd = true;
            };
          };
        };
      };
  };
}
