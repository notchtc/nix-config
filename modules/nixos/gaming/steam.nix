{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ wineWowPackages.stagingFull ];

  programs.steam = {
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

  chaotic.steam.extraCompatPackages = with pkgs; [ proton-ge-custom ];
}
