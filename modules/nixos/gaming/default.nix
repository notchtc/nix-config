{ pkgs, lib, ... }:
{
  boot.kernel.sysctl = {
    "kernel.split_lock_mitigate" = 0;
  };

  environment.systemPackages = lib.attrValues {
    inherit (pkgs)
      #azahar
      lutris
      #melonDS
      #ppsspp-sdl-wayland
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

      extraCompatPackages = [ pkgs.proton-ge-bin ];
    };
  };

  hardware.steam-hardware.enable = true;
  services.udev.packages = [ pkgs.game-devices-udev-rules ];
}
