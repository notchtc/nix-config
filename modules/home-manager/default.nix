{
  flake.homeModules = {
    common = import ./common.nix;
    plasma = import ./desktops/plasma.nix;
    schizofox = import ./programs/browsers/schizofox;
    helix = import ./programs/editors/helix.nix;
    mpv = import ./programs/mpv;
    bat = import ./programs/shell/bat.nix;
    dircolors = import ./programs/shell/dircolors.nix;
    eza = import ./programs/shell/eza.nix;
    git = import ./programs/shell/git.nix;
    starship = import ./programs/shell/starship.nix;
    zoxide = import ./programs/shell/zoxide.nix;
    zsh = import ./programs/shell/zsh.nix;
    foot = import ./programs/terminals/foot.nix;
  };
}
