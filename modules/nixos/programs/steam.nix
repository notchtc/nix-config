{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ wineWowPackages.stagingFull ];

  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
  };

  chaotic.steam.extraCompatPackages = with pkgs; [ proton-ge-custom ];
}
