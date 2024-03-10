{self, ...}: {
  imports = [
    self.nixosModules.fonts
  ];

  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    dconf.enable = true;
    zsh = {
      enable = true;
      enableCompletion = false;
    };
  };
}
