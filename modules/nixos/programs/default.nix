{
  imports = [
    ./fonts.nix
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
