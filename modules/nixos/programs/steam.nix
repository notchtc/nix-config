{ pkgs, ... }:
{
  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
  };

  chaotic.steam.extraCompatPackages = with pkgs; [ proton-ge-custom ];
}
