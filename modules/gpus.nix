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

    gpu-nvidia-igpu =
      {
        config,
        lib,
        pkgs,
        ...
      }:
      let
        inherit (lib.lists) drop elemAt singleton;
        inherit (lib.strings)
          fixedWidthString
          splitString
          toInt
          toLower
          ;
        inherit (lib.trivial) toHexString;
        inherit (pkgs) writeTextDir;
      in
      {
        hardware.nvidia = {
          dynamicBoost.enable = true;
          powerManagement.finegrained = true;
          videoAcceleration = false;
          prime.offload = {
            enable = true;
            enableOffloadCmd = true;
          };
        };

        services.udev.packages =
          let
            pciPath =
              xorgBusId:
              let
                components = drop 1 (splitString ":" xorgBusId);
                toHex = i: toLower (toHexString (toInt i));

                domain = "0000"; # Apparently the domain is practically always set to 0000
                bus = fixedWidthString 2 "0" (toHex (elemAt components 0));
                device = fixedWidthString 2 "0" (toHex (elemAt components 1));
                function = elemAt components 2; # The function is supposedly a decimal number
              in
              "dri/by-path/pci-${domain}:${bus}:${device}.${function}-card";

            pCfg = config.hardware.nvidia.prime;
            igpuPath = pciPath (if pCfg.intelBusId != "" then pCfg.intelBusId else pCfg.amdgpuBusId);
            dgpuPath = pciPath pCfg.nvidiaBusId;
          in

          singleton (
            writeTextDir "lib/udev/rules.d/61-gpu-offload.rules" ''
              SYMLINK=="${igpuPath}", SYMLINK+="dri/igpu1"
              SYMLINK=="${dgpuPath}", SYMLINK+="dri/dgpu1"
            ''
          );
      };
  };
}
