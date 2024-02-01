{pkgs, ...}: {
  programs = {
    gamemode.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
  };

  chaotic.steam.extraCompatPackages = with pkgs.nur.repos.ataraxiasjel; [proton-ge];
}
