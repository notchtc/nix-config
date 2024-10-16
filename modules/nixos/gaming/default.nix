{ pkgs, lib, ... }:
{
  environment.systemPackages = lib.attrValues {
    inherit (pkgs)
      #      lime3ds
      lutris
      melonDS
      ppsspp-sdl-wayland
      ;

    wine = pkgs.wineWowPackages.stagingFull;
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

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      extest.enable = true;
      protontricks.enable = true;

      extraCompatPackages = [
        pkgs.luxtorpeda
        pkgs.proton-ge-custom
      ];
    };
  };
}
