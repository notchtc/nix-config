{
  imports = [
    ./difftastic.nix
    ./eza.nix
    ./git.nix
    ./helix.nix
    ./jj.nix
    ./nix-index.nix
    ./zsh.nix
  ];

  programs = {
    bat.enable = true;
    fd.enable = true;
    ripgrep.enable = true;
    zoxide.enable = true;
  };
}
