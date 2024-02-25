{pkgs, ...}: {
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
    };
  };

  chaotic.steam.extraCompatPackages = with pkgs.nur.repos.ataraxiasjel; [proton-ge];
}
