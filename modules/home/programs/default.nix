{
  imports = [
    ./difftastic.nix
    ./eza.nix
    ./git.nix
    ./ghostty.nix
    ./helix.nix
    ./jj.nix
    ./librewolf.nix
    ./mpv-haruna.nix
    ./nix-index.nix
    ./vesktop.nix
    ./vicinae.nix
    ./zsh.nix
  ];

  programs = {
    bat.enable = true;
    fd.enable = true;
    ripgrep.enable = true;
    zoxide.enable = true;
  };
}
