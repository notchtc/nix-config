{config, ...}: {
  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
  };

  chaotic.steam.extraCompatPackages = with config.nur.repos.ataraxiasjel; [proton-ge];
}
