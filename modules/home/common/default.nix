{
  imports = [
    ./eza.nix
    ./helix.nix
    ./nix-index.nix
    ./vcs.nix
    ./xdg.nix
    ./zsh.nix
  ];

  programs = {
    bat.enable = true;
    bottom.enable = true;
    fd.enable = true;
    ripgrep.enable = true;
    zoxide.enable = true;
  };

  nix.gc = {
    automatic = true;
    randomizedDelaySec = "15min";
    options = "--delete-older-than 7d";
  };

  home.stateVersion = "25.11";
}
