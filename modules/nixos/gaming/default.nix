{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    lime3ds
    melonDS
    ppsspp-sdl-wayland
    wineWowPackages.stagingFull
  ];

  programs = {
    gamemode = {
      enable = true;
      settings = {
        general = {
          softrealtime = "auto";
          renice = 15;
        };
      };
    };

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      extest.enable = true;

      extraCompatPackages = [ pkgs.proton-ge-custom ];
      extraPackages = with pkgs; [
        protontricks
        steamtinkerlaunch
        winetricks
      ];
    };
  };
}
