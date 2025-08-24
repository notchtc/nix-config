{
  imports = [
    ./helix.nix
    ./vcs.nix
    ./xdg.nix
  ];

  programs = {
    command-not-found.enable = false;
    zsh = {
      enable = true;
      enableCompletion = true;
    };
  };

  nix.gc = {
    automatic = true;
    randomizedDelaySec = "15min";
    options = "--delete-older-than 7d";
  };

  home.stateVersion = "25.11";
}
