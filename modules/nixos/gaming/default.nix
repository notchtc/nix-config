{
  project,
  system,
  pkgs,
  lib,
  ...
}:
{
  environment.systemPackages = lib.attrValues {
    inherit (pkgs) lutris protonup-qt;

    inherit (project.inputs.openmw-nix.result.packages.${system})
      momw-configurator
      openmw-dev
      openmw-validator
      s3lightfixes
      ;
  };

  environment.sessionVariables = {
    PROTON_ENABLE_WAYLAND = 1;
    PROTON_USE_NTSYNC = 1;
  };
  programs = {
    gamemode = {
      enable = true;
      settings = {
        general = {
          softrealtime = "auto";
          renice = 17;
        };
        gpu = {
          apply_gpu_optimizations = "accept-responsibility";
          gpu_device = 0;
        };
      };
    };

    gamescope = {
      enable = true;
      capSysNice = false;
    };

    steam = {
      enable = true;
      dedicatedServer.openFirewall = true;
      extest.enable = true;
      gamescopeSession.enable = true;
      localNetworkGameTransfers.openFirewall = true;
      protontricks.enable = true;
      remotePlay.openFirewall = true;
    };
  };

  hardware.steam-hardware.enable = true;
  services.udev.packages = [ pkgs.game-devices-udev-rules ];
}
