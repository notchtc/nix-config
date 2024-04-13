{
  flake.homeModules = {
    common = import ./common.nix;
    gnome = import ./desktops/gnome.nix;
    plasma = import ./desktops/plasma.nix;
    firefox = import ./programs/browsers/firefox;
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
