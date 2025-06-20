{ pkgs, lib, ... }:
{
  environment.systemPackages = lib.attrValues {
    inherit (pkgs)
      #azahar
      lutris
      #melonDS
      #ppsspp-sdl-wayland
      ;
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
      capSysNice = true;
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
}
